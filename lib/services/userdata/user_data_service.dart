// Service to connect to user data stored on firestore

// Functionalities
// - initializing current User (id, e-mail, fullname, wallet balances)
// - exposing currentUser
// - exposing stream of wallet balances

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/payments/wallet_balances_model.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class UserDataService {
  final log = getLogger("user_data_service.dart");

  // firestore collections
  final CollectionReference _paymentsCollectionReference =
      FirebaseFirestore.instance.collection("payments");
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _moneyPoolPayoutsCollectionReference =
      FirebaseFirestore.instance.collection("moneyPoolPayouts");

  final FirebaseAuthenticationService? _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();

  // controller to expose stream of wallet transactions and payments
  final StreamController<List<dynamic>> _transactionsController =
      StreamController<List<dynamic>>.broadcast();
  final StreamController<List<dynamic>> _walletTransactionsController =
      StreamController<List<dynamic>>.broadcast();

  // subject to keep track of initialization of user
  BehaviorSubject<UserStatus> userStateSubject =
      BehaviorSubject<UserStatus>.seeded(UserStatus.Unknown);

  // subject to keep track and expose wallet
  BehaviorSubject<WalletBalancesModel> userWalletSubject =
      BehaviorSubject<WalletBalancesModel>.seeded(WalletBalancesModel.empty());

  // current user with all our custom data attached to it
  late MyUser _currentUser;
  MyUser get currentUser => _currentUser;
  void setCurrentUser(MyUser user) {
    _currentUser = user;
  }

  // list of latest transactions and their subscriptions
  Map<String, List<MoneyTransfer>> latestTransfers = {};
  Map<String, StreamSubscription?> _transfersSubscriptions = {};

  // Listen to auth state changes.
  // This is useful in scenarios where we want to
  // show certain content without the need register for the user.
  // This might not be of need for mobile but
  // will become more useful thinking about PWAs especially
  // on desktop.
  late Stream<User?> userStream;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserDataService() {
    userStream = _firebaseAuth.authStateChanges();
    userStream.listen(
      (user) async {
        if (user != null) {
          userStateSubject.add(UserStatus.SignedIn);
          initializeCurrentUser(user);
        } else {
          userStateSubject.add(UserStatus.SignedOut);
        }
        log.i("User status changed to ${userStateSubject.value}");
      },
    );
  }

  Future<UserDataServiceResult> initializeCurrentUser(User user) async {
    log.i("Initializing user data");

    if (userStateSubject.value != UserStatus.Initialized) {
      log.i("Populating current user");
      try {
        UserDataServiceResult result = await _populateCurrentUser(user);
        if (result.hasError) return result;
        await listenToWalletUpdates(user.uid);
        userStateSubject.add(UserStatus.Initialized);
      } catch (e) {
        // this should produce an error. listened to in start up logic
        userStateSubject.add(UserStatus.SignedInNotInitialized);
        return UserDataServiceResult.error(
            errorMessage:
                "Initializing current user failed with message: ${e.toString()}");
      }
    } else {
      log.w("User already initialized. ");
    }
    return UserDataServiceResult();
  }

  Future _populateCurrentUser(User user) async {
    try {
      var userData = await _usersCollectionReference.doc(user.uid).get();
      if (!userData.exists) {
        // This means no user has been created yet in cloud firestore
        // This happens for example when loggin in with google, facebook, ...
        // We first have to create a user and then

        log.w(
            "Create user because this seems to be the first time a user is logging in with third-party authentification");
        var result = await createUser(user);
        if (result.hasError) {
          return UserDataServiceResult.error(
              errorMessage:
                  "User data could not be created in our databank. Please try again later or contact support with error messaage: ${result.errorMessage}");
        } else {
          // retrieve data again because now it exists
          userData = await _usersCollectionReference.doc(user.uid).get();
        }
      }
      // populate current User
      if (userData.data() == null) {
        log.wtf(
            "user data document could be found but it does not have any data! Something is seriously wrong");
        return UserDataServiceResult.error(
            errorMessage: "Something is seriously wrong! Please check logs");
      } else {
        MyUser myUser = MyUser.fromData(userData.data()!);
        _currentUser = myUser;
        return UserDataServiceResult();
      }
    } catch (e) {
      log.e("Error in _populateCurrentUser(): ${e.toString()}");
      rethrow;
    }
  }

  // User ------------------------------------------------->>
  Future createUser(User user, [String? fullName]) async {
    // create a new user profile on firestore`
    num currentBalance = 0;
    num transferredToPeers = 0;
    num donations = 0;
    num raised = 0;
    try {
      String name = fullName ?? (user.displayName ?? "");
      String email = user.email ?? "";
      MyUser myuser = MyUser(
        id: user.uid,
        email: email,
        fullName: name,
        currentBalance: currentBalance,
        transferredToPeers: transferredToPeers,
        donations: donations,
        raised: raised,
      );
      await _usersCollectionReference.doc(user.uid).set(myuser.toJson(true));
      return UserDataServiceResult();
    } catch (e) {
      log.e("Error in createUser(): ${e.toString()}");
      return UserDataServiceResult.error(
          errorMessage:
              "Creating user data failed with message: ${e.toString()}");
    }
  }

  Future listenToWalletUpdates(var uid) async {
    try {
      _usersCollectionReference.doc(uid).snapshots().listen((userData) {
        if (userData.exists) {
          try {
            if (userData.data() == null) {
              log.wtf(
                  "User data document found but data is null. Something is seriously messed up! Adding empty wallet");
            } else {
              userWalletSubject.add(
                WalletBalancesModel.fromData(userData.data()!),
              );
            }
          } catch (e) {
            log.e("Could not fetch wallet data due to error ${e.toString()}");
          }
        } else {
          log.e("Wallet data could not be retrieved from firebase");
        }
      });
    } catch (e) {
      log.e("Error updating user wallet: ${e.toString()}");
      rethrow;
    }
  }

  Stream listenToTransactionsRealTime() {
    // Function listening to payments collections
    // where user is found in senderUid or recipientUid

    // TODO: Add limit to this query and only load more
    // when user asks for it!
    // keyword: pagination
    // @see https://www.filledstacks.com/post/how-to-perform-real-time-pagination-with-firestore/

    if (userStateSubject.value != UserStatus.Initialized)
      log.i("User not initialized, the following code will break");

    // There is no OR query for different fields in firebase
    // Get single streams and combine later with rxDart

    Stream<QuerySnapshot> outgoing = _paymentsCollectionReference
        .where("transferDetails.senderId", isEqualTo: currentUser.id)
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .snapshots();
    Stream<QuerySnapshot> incoming = _paymentsCollectionReference
        .where("transferDetails.recipientId", isEqualTo: currentUser.id)
        .orderBy("createdAt", descending: true)
        .snapshots();

    // combine streams with rxdart
    Stream<List<dynamic>> transactionStream = Rx.combineLatest2(
        outgoing, incoming, (dynamic outSnapshot, dynamic inSnapshot) {
      // list of transactions to be returned
      List<dynamic> transactions = <dynamic>[];

      if (outSnapshot.docs.isNotEmpty) {
        transactions.addAll(outSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList());
      }
      if (inSnapshot.docs.isNotEmpty) {
        List<dynamic> inTransactions = inSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList();
        List<dynamic> transactionIds =
            transactions.map((element) => element.transactionId).toList();
        inTransactions.forEach((element) {
          // Add logic to find top ups (transactions to own account!)
          // Can be deprecated once data is already stored accordingly with topUp = true!
          if (!transactionIds.contains(element.transactionId)) {
            transactions.add(element);
          } else {
            element.topUp = true;
            transactions.removeWhere(
                (el2) => el2.transactionId == element.transactionId);
            transactions.add(element);
          }
        });
      }

      return transactions;
    });
    // listen to combined stream and add transactions to controller
    transactionStream.listen((transactions) {
      _transactionsController.add(transactions);
    });
    // return stream from controller
    return _transactionsController.stream;
  }

  Stream listenToWalletTransactionsRealTime() {
    // Function listening to collections to fetch
    // incoming and outgoing (donations) money of the Good Wallet

    // TODO: Add limit to this query and only load more
    // when user asks for it!
    // keyword: pagination
    // @see https://www.filledstacks.com/post/how-to-perform-real-time-pagination-with-firestore/

    if (userStateSubject.value != UserStatus.Initialized)
      log.i("User not initialized, the following code will break");

    // There is no OR query for different fields in firebase
    // Get single streams and combine later with rxDart

    // outgoing = donations
    Stream<QuerySnapshot> outgoing = _usersCollectionReference
        .doc(_currentUser.id)
        .collection("donations")
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .snapshots();
    Stream<QuerySnapshot> incoming = _paymentsCollectionReference
        .where("transferDetails.recipientId", isEqualTo: currentUser.id)
        .orderBy("createdAt", descending: true)
        .snapshots();

    // combine streams with rxdart
    Stream<List<dynamic>> transactionStream = Rx.combineLatest2(
        outgoing, incoming, (dynamic outSnapshot, dynamic inSnapshot) {
      // list of transactions to be returned
      List<dynamic> transactions = <dynamic>[];

      if (outSnapshot.docs.isNotEmpty) {
        transactions.addAll(outSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList());
      }
      if (inSnapshot.docs.isNotEmpty) {
        List<dynamic> inTransactions = inSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList();
        List<dynamic> transactionIds =
            transactions.map((element) => element.transactionId).toList();
        inTransactions.forEach((element) {
          // Add logic to find top ups (transactions to own account!)
          // Can be deprecated once data is already stored accordingly with topUp = true!
          if (!transactionIds.contains(element.transactionId)) {
            transactions.add(element);
          } else {
            element.topUp = true;
            transactions.removeWhere(
                (el2) => el2.transactionId == element.transactionId);
            transactions.add(element);
          }
        });
      }

      return transactions;
    });
    // listen to combined stream and add transactions to controller
    transactionStream.listen((transactions) {
      _walletTransactionsController.add(transactions);
    });
    // return stream from controller
    return _walletTransactionsController.stream;
  }

  Future<List<dynamic>> getListOfDonations() async {
    // TODO: Add limit to this query and only load more
    // when user asks for it!
    // keyword: pagination
    // @see https://www.filledstacks.com/post/how-to-perform-real-time-pagination-with-firestore/

    if (userStateSubject.value != UserStatus.Initialized)
      log.i("User not initialized, the following code will break!");

    List<dynamic> listOfDonations = <dynamic>[];

    QuerySnapshot donationsSnapshot = await _usersCollectionReference
        .doc(_currentUser.id)
        .collection("donations")
        .orderBy("createdAt", descending: true)
        .get();
    if (donationsSnapshot.docs.isNotEmpty) {
      listOfDonations.addAll(donationsSnapshot.docs
          .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
          .toList());
    } else {
      log.e("Snapshot of donations collectoin is empty");
    }

    return listOfDonations;
  }

  Future<List<dynamic>> getListOfTransactionsToPeers() async {
    // TODO: Add limit to this query and only load more
    // when user asks for it!
    // keyword: pagination
    // @see https://www.filledstacks.com/post/how-to-perform-real-time-pagination-with-firestore/

    if (userStateSubject.value != UserStatus.Initialized)
      log.i("User not initialized, the following code will break!");

    List<dynamic> listOfTransactionsToPeers = <dynamic>[];
    QuerySnapshot transactionsSnapshot = await _paymentsCollectionReference
        .where("transferDetails.senderId", isEqualTo: currentUser.id)
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .get();
    if (transactionsSnapshot.docs.isNotEmpty) {
      try {
        listOfTransactionsToPeers.addAll(transactionsSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList());
      } catch (e) {
        log.e("Could not map firestore data into TransactionModel");
      }
    } else {
      log.e("Snapshot of donations collecton is empty");
    }

    return listOfTransactionsToPeers;
  }

  Future<List<dynamic>> getListOfIncomingTransactions() async {
    // TODO: Add limit to this query and only load more
    // when user asks for it!
    // keyword: pagination
    // @see https://www.filledstacks.com/post/how-to-perform-real-time-pagination-with-firestore/

    if (userStateSubject.value != UserStatus.Initialized)
      log.i("User not initialized, the following code will break!");

    List<dynamic> listOfTransactions = <dynamic>[];
    QuerySnapshot transactionsSnapshot = await _paymentsCollectionReference
        .where("transferDetails.recipientId", isEqualTo: currentUser.id)
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .get();
    if (transactionsSnapshot.docs.isNotEmpty) {
      try {
        listOfTransactions.addAll(transactionsSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList());
      } catch (e) {
        log.e("Could not map firestore data into TransactionModel");
      }
    } else {
      log.e("Snapshot of donations collection is empty");
    }

    return listOfTransactions;
  }

  Future<List<dynamic>> getListOfMoneyPoolPayouts() async {
    // TODO: Add limit to this query and only load more
    // when user asks for it!
    // keyword: pagination
    // @see https://www.filledstacks.com/post/how-to-perform-real-time-pagination-with-firestore/

    if (userStateSubject.value != UserStatus.Initialized)
      log.i("User not initialized, the following code will break!");

    List<dynamic> listOfTransactions = <dynamic>[];
    QuerySnapshot transactionsSnapshot =
        await _moneyPoolPayoutsCollectionReference
            .where("paidOutUsersIds", arrayContains: currentUser.id)
            .get();
    if (transactionsSnapshot.docs.isNotEmpty) {
      try {
        listOfTransactions.addAll(transactionsSnapshot.docs
            .map((snapshot) => MoneyPoolPayout.fromJson(snapshot.data()))
            .toList());
      } catch (e) {
        log.e("Could not map firestore data into MoneyPoolPayout");
      }
    } else {
      log.e("Snapshot of donations collection is empty");
    }
    return listOfTransactions;
  }

  Stream<List<MoneyTransfer>> getCombinedMoneyTransfersStream(
      {required Query outgoing, required Query incoming, int? maxNumber}) {
    // combine streams with rxdart
    Stream<QuerySnapshot> outSnapshot = maxNumber == null
        ? outgoing.snapshots()
        : outgoing.limit(maxNumber).snapshots();
    Stream<QuerySnapshot> inSnapshot = maxNumber == null
        ? incoming.snapshots()
        : incoming.limit(maxNumber).snapshots();

    return Rx.combineLatest2<QuerySnapshot, QuerySnapshot, List<MoneyTransfer>>(
        outSnapshot, inSnapshot,
        (QuerySnapshot outSnapshot, QuerySnapshot inSnapshot) {
      // list of transactions to be returned
      List<MoneyTransfer> transactions = [];
      if (outSnapshot.docs.isNotEmpty) {
        transactions.addAll(outSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList());
      }
      if (inSnapshot.docs.isNotEmpty) {
        List<MoneyTransfer> inTransactions = inSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList();
        List<String> transactionIds =
            transactions.map((element) => element.transferId).toList();
        inTransactions.forEach((element) {
          // TODO: Resolve conflicts properly
          // Add logic to find top ups (transactions to own account!)
          // Can be deprecated once data is already stored accordingly with topUp = true!
          if (!transactionIds.contains(element.transferId)) {
            transactions.add(element);
          } else {
            transactions
                .removeWhere((el2) => el2.transferId == element.transferId);
            transactions.add(element);
          }
        });
      }
      transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return transactions;
    });
  }

  // Get query for transaction with given direction.
  // optionally set the maximum number of documents retrieved
  Stream<List<MoneyTransfer>> getTransferDataStream(
      {required TransferType type, int? maxNumber}) {
    Query query;
    if (type == TransferType.All) {
      Query outgoing = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.id)
          .orderBy("createdAt", descending: true);
      Query incoming = _paymentsCollectionReference
          .where("transferDetails.recipientId", isEqualTo: currentUser.id)
          .orderBy("createdAt", descending: true);
      Stream<List<MoneyTransfer>> transfersStream =
          getCombinedMoneyTransfersStream(
              outgoing: outgoing, incoming: incoming);
      return transfersStream;
    } else if (type == TransferType.Peer2PeerSent) {
      query = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.id)
          // document fields are the same so the type is Peer2Peer here
          .where("type", isEqualTo: "Peer2Peer")
          .orderBy("createdAt", descending: true);
      // .where("createdAt",
      // isGreaterThan: Timestamp.fromDate(DateTime(2021, 5, 8)));
    } else if (type == TransferType.Peer2PeerReceived) {
      query = _paymentsCollectionReference
          .where("transferDetails.recipientId", isEqualTo: currentUser.id)
          // document fields are the same so the type is Peer2Peer here
          .where("type", isEqualTo: "Peer2Peer")
          .orderBy("createdAt", descending: true);
    } else if (type == TransferType.Peer2Peer) {
      Query querySent = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.id)
          // document fields are the same so the type is Peer2Peer here
          .where("type", isEqualTo: "Peer2Peer")
          .orderBy("createdAt", descending: true);
      Query queryReceived = _paymentsCollectionReference
          .where("transferDetails.recipientId", isEqualTo: currentUser.id)
          // document fields are the same so the type is Peer2Peer here
          .where("type", isEqualTo: "Peer2Peer")
          .orderBy("createdAt", descending: true);
      Stream<List<MoneyTransfer>>? stream = getCombinedMoneyTransfersStream(
          outgoing: querySent, incoming: queryReceived, maxNumber: maxNumber);
      return stream;
    } else if (type == TransferType.Donation) {
      query = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.id)
          .where("type", isEqualTo: "Donation")
          .orderBy("createdAt", descending: true);
    } else if (type == TransferType.MoneyPoolPayout) {
      // This is querying for the full payout documents holding
      // all MoneyPoolPayoutTransfers. Look in moneyPoolPayouts collection
      query = _moneyPoolPayoutsCollectionReference
          .where("paidOutUserIds", arrayContains: currentUser.id)
          .orderBy("createdAt", descending: true);
    } else if (type == TransferType.MoneyPoolPayoutTransfer) {
      query = _paymentsCollectionReference
          .where("transferDetails.recipientId", isEqualTo: currentUser.id)
          .where("type", isEqualTo: "MoneyPoolPayoutTransfer")
          .orderBy("createdAt", descending: true);
    } else if (type == TransferType.MoneyPoolContribution) {
      query = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.id)
          .where("type", isEqualTo: "MoneyPoolContribution")
          .orderBy("createdAt", descending: true);
    } else {
      // TODO: Throw exception and make return value non-nullable
      log.e(
          "Could not find stream corresponding to provided transfer type '$type'");
      throw Exception("Exception occured. TODO: Add proper Exception here!");
    }

    if (maxNumber != null) query = query.limit(maxNumber);

    // convert Stream<QuerySnapshot> to Stream<List<MoneyTransfer>>
    Stream<List<MoneyTransfer>> returnStream = query.snapshots().map(
          (event) => event.docs
              .map(
                (doc) => MoneyTransfer.fromJson(doc.data()),
              )
              .toList(),
        );
    return returnStream;
  }

  String getStreamConfigString({required TransferType type, int? maxNumber}) {
    // TODO: Make maxNumber treatment smarter!
    Map<String, String> config = {
      "type": type.toString(),
      "maxNumber": maxNumber.toString()
    };
    return config.toString();
  }

  // More generic class to listen to firestore collections for updates.
  // callback can be used to provide notifyListeners from the viewmodel
  // to the service
  void addTransferDataListener(
      {required TransferType type, int? maxNumber, void Function()? callback}) {
    // TODO: We need to make sure that the callback is called!

    String configString =
        getStreamConfigString(type: type, maxNumber: maxNumber);

    // TODO: Treat type MoneyPoolPayout
    if (type == TransferType.MoneyPoolPayout) {
      log.e(
          "Can't listen to money pool payouts at the moment. NOT YET IMPLEMENTED");
      return;
    }

    if (_transfersSubscriptions.containsKey(configString)) {
      log.v(
          "Stream with config '$configString' already listened to, not adding a second listener!");
      return;
    } else {
      log.i("Setting up listener for transfers with config $configString.");
      Stream<List<MoneyTransfer>> snapshot =
          getTransferDataStream(type: type, maxNumber: maxNumber);
      // listen to combined stream and add transactions to controller
      _transfersSubscriptions[configString] = snapshot.listen(
        (transactions) {
          latestTransfers[configString] = transactions;
          log.v(
              "Listened to ${transactions.length} transfers with config $configString. Limit was set to $maxNumber");
          if (callback != null) callback();
        },
      );
    }
  }

  // Get transactions for type and direction
  // Could be done better! User has to parse redundant information
  List<MoneyTransfer> getTransfers(
      {required TransferType type, int? maxNumber}) {
    String configString =
        getStreamConfigString(type: type, maxNumber: maxNumber);
    if (!latestTransfers.containsKey(configString)) {
      log.w(
          "Did not find any transfers for config $configString. Please add a listener with 'addTransferDataListener()'. Returning empty list");
      return [];
    } else {
      return latestTransfers[configString]!;
    }
  }

  ///////////////////////////////////////////////////
  // Clean up

  // clear all data when user logs out!
  Future handleLogoutEvent() async {
    // clear wallet
    userWalletSubject.add(WalletBalancesModel.empty());
    // set current user to null
    _currentUser = MyUser.empty();
    // remove money Pools
    _moneyPoolService!.clearData();
    // actually log out from firebase
    await _firebaseAuthenticationService!.logout();
    // set auth state to signed out
    userStateSubject.add(UserStatus.SignedOut);
  }
}

// Helper class returned from public function of UserDataService
class UserDataServiceResult {
  /// Helper message which type of data was tried to be acceessed
  final String? typeOfData;

  /// Contains the error message for the request
  final String? errorMessage;

  UserDataServiceResult({this.typeOfData}) : errorMessage = null;

  UserDataServiceResult.error({this.errorMessage}) : typeOfData = null;

  /// Returns true if the response has an error associated with it
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
