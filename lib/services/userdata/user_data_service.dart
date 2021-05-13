// Service to connect to user data stored on firestore

// Functionalities
// - initializing current User (id, e-mail, fullname, wallet balances)
// - exposing currentUser
// - exposing stream of wallet balances

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/exceptions/user_data_service_exception.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class UserDataService {
  final log = getLogger("user_data_service.dart");

  // firestore collections
  // TODO: Replace with FirestoreApi
  final _firestoreApi = locator<FirestoreApi>();
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
  UserStatus? get userStatus => userStateSubject.value;

  // subject to keep track and expose wallet
  BehaviorSubject<UserStatistics> userStatsSubject =
      BehaviorSubject<UserStatistics>.seeded(getEmptyUserStatistics());
  UserStatistics? get userStats => userStatsSubject.value;

  // current user with all our custom data attached to it
  late User _currentUser;
  User get currentUser => _currentUser;
  void setCurrentUser(User user) {
    _currentUser = user;
  }

  // list of latest transactions and their subscriptions
  Map<MoneyTransferQueryConfig, List<MoneyTransfer>> latestTransfers = {};
  Map<MoneyTransferQueryConfig, StreamSubscription?> _transfersSubscriptions =
      {};

  // Listen to auth state changes.
  // This is useful in scenarios where we want to
  // show certain content without the need register for the user.
  // This might not be of need for mobile but
  // will become more useful thinking about PWAs especially
  // on desktop.
  late Stream<firebase.User?> userStream;
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;

  UserDataService() {
    userStream = _firebaseAuth.authStateChanges();
    userStream.listen(
      (user) async {
        if (user != null) {
          _changeUserStatus(UserStatus.SignedIn);
          initializeCurrentUser(user);
        } else {
          _changeUserStatus(UserStatus.SignedOut);
        }
        log.i("User status changed to ${userStateSubject.value}");
      },
    );
  }

  void _changeUserStatus(UserStatus status) {
    userStateSubject.add(status);
  }

  //////////////////////////////////////////////////////////////////
  //
  // Function related to User setup

  // syncing data from firestore to client
  Future initializeCurrentUser(firebase.User user) async {
    log.i("Initializing user data");

    if (userStateSubject.value != UserStatus.Initialized) {
      log.i("Populating current user");
      try {
        await _populateCurrentUser(user);
        await listenToUserSummaryStats(user.uid);
        _changeUserStatus(UserStatus.Initialized);
      } catch (e) {
        // this should produce an error. listened to in start up logic
        log.wtf(
            "This should never happen and is likely due to an inconsistency in the backend: ${e.toString()}");
        _changeUserStatus(UserStatus.SignedInNotInitialized);
        throw UserDataServiceException(
            message: "Initializing current user failed",
            devDetails: e.toString());
      }
    } else {
      log.w("User already initialized. ");
    }
  }

  // populating current user
  Future _populateCurrentUser(firebase.User user) async {
    try {
      final populatedUser = await _firestoreApi.getUser(uid: user.uid);

      if (populatedUser != null) {
        _currentUser = populatedUser;
      } else {
        // This means no user has been created yet in cloud firestore
        // This happens for example when loggin in with third-party providers like
        // google, facebook, ...
        // We first have to create a user and then
        log.i(
            "Create user because this seems to be the first time a user is logging in with third-party authentification");
        try {
          final nowPopulatedUser = await createUser(user);
          _currentUser = nowPopulatedUser;
        } catch (e) {
          rethrow;
        }
      }
    } catch (e) {
      log.e("Error in _populateCurrentUser(): ${e.toString()}");
      rethrow;
    }
  }

  // create user documents (user info, statistics) in firestore
  Future<User> createUser(firebase.User user, [String? fullName]) async {
    // create a new user profile on firestore
    try {
      String name = fullName ?? (user.displayName ?? "");
      String email = user.email ?? "";
      List<String> keywords = getListOfKeywordsFromString(name);
      User myuser = User(
        uid: user.uid,
        email: email,
        fullName: name,
        searchKeywords: keywords,
      );
      UserStatistics stats = getEmptyUserStatistics();
      await _firestoreApi.createUser(user: myuser, stats: stats);
      return myuser;
    } catch (e) {
      log.e("Error in createUser(): ${e.toString()}");
      throw UserDataServiceException(
        message: "Creating user data failed with message",
        devDetails: e.toString(),
        prettyDetails:
            "User data could not be created in our databank. Please try again later or contact support with error messaage: ${e.toString()}",
      );
    }
  }

  ////////////////////////////////////////////////////////////
  /// Setting up listeners
  ///
  Future listenToUserSummaryStats(String uid) async {
    try {
      _firestoreApi
          .getUserSummaryStatisticsStream(uid: uid)
          .listen((stats) => userStatsSubject.add(stats));
    } catch (e) {
      rethrow;
    }
  }

  /////////////////////////////////////////////////////
  /// Functions related to money transfers
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
        .where("transferDetails.senderId", isEqualTo: currentUser.uid)
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .snapshots();
    Stream<QuerySnapshot> incoming = _paymentsCollectionReference
        .where("transferDetails.recipientId", isEqualTo: currentUser.uid)
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
        .doc(_currentUser.uid)
        .collection("donations")
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .snapshots();
    Stream<QuerySnapshot> incoming = _paymentsCollectionReference
        .where("transferDetails.recipientId", isEqualTo: currentUser.uid)
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
        .doc(_currentUser.uid)
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
        .where("transferDetails.senderId", isEqualTo: currentUser.uid)
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
        .where("transferDetails.recipientId", isEqualTo: currentUser.uid)
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
            .where("paidOutUsersIds", arrayContains: currentUser.uid)
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
      {required Query outgoing,
      required Query incoming,
      int? maxNumberReturns}) {
    // combine streams with rxdart
    Stream<QuerySnapshot> outSnapshot = maxNumberReturns == null
        ? outgoing.snapshots()
        : outgoing.limit(maxNumberReturns).snapshots();
    Stream<QuerySnapshot> inSnapshot = maxNumberReturns == null
        ? incoming.snapshots()
        : incoming.limit(maxNumberReturns).snapshots();

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

  isSupportedFirestoreQueryFilter({dynamic isEqualToFilter}) {
    if (isEqualToFilter == null) return true;
    if (isEqualToFilter.length > 1) return false;
    return true;
  }

  // Get query for transaction with given direction.
  // optionally set the maximum number of documents retrieved
  Stream<List<MoneyTransfer>> getTransferDataStream(
      {required MoneyTransferQueryConfig config}) {
    // check arguments:
    if (!isSupportedFirestoreQueryFilter(
        isEqualToFilter: config.isEqualToFilter)) {
      throw UserDataServiceException(
          message:
              "The provided firestore query filter: '$config.isEqualToFilter' is not supported at the moment!");
    }

    Query query;
    if (config.type == TransferType.All) {
      Query outgoing = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.uid)
          .orderBy("createdAt", descending: true);
      Query incoming = _paymentsCollectionReference
          .where("transferDetails.recipientId", isEqualTo: currentUser.uid)
          .orderBy("createdAt", descending: true);
      Stream<List<MoneyTransfer>> transfersStream =
          getCombinedMoneyTransfersStream(
              outgoing: outgoing, incoming: incoming);
      return transfersStream;
    } else if (config.type == TransferType.Peer2PeerSent) {
      query = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.uid)
          // document fields are the same so the type is Peer2Peer here
          .where("type", isEqualTo: "Peer2Peer")
          .orderBy("createdAt", descending: true);
      // .where("createdAt",
      // isGreaterThan: Timestamp.fromDate(DateTime(2021, 5, 8)));
    } else if (config.type == TransferType.Peer2PeerReceived) {
      query = _paymentsCollectionReference
          .where("transferDetails.recipientId", isEqualTo: currentUser.uid)
          // document fields are the same so the type is Peer2Peer here
          .where("type", isEqualTo: "Peer2Peer")
          .orderBy("createdAt", descending: true);
    } else if (config.type == TransferType.Peer2Peer) {
      Query querySent = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.uid)
          // document fields are the same so the type is Peer2Peer here
          .where("type", isEqualTo: "Peer2Peer")
          .orderBy("createdAt", descending: true);
      Query queryReceived = _paymentsCollectionReference
          .where("transferDetails.recipientId", isEqualTo: currentUser.uid)
          // document fields are the same so the type is Peer2Peer here
          .where("type", isEqualTo: "Peer2Peer")
          .orderBy("createdAt", descending: true);
      Stream<List<MoneyTransfer>>? stream = getCombinedMoneyTransfersStream(
          outgoing: querySent,
          incoming: queryReceived,
          maxNumberReturns: config.maxNumberReturns);
      return stream;
    } else if (config.type == TransferType.Donation) {
      query = _paymentsCollectionReference
          .where("transferDetails.senderId", isEqualTo: currentUser.uid)
          .where("type", isEqualTo: "Donation")
          .orderBy("createdAt", descending: true);
    } else if (config.type == TransferType.MoneyPoolPayout) {
      // This is querying for the full payout documents holding
      // all MoneyPoolPayoutTransfers. Look in moneyPoolPayouts collection
      query = _moneyPoolPayoutsCollectionReference
          .where("paidOutUserIds", arrayContains: currentUser.uid)
          .orderBy("createdAt", descending: true);
    } else if (config.type == TransferType.MoneyPoolPayoutTransfer) {
      query = _paymentsCollectionReference
          .where("transferDetails.recipientId", isEqualTo: currentUser.uid)
          .where("type", isEqualTo: "MoneyPoolPayoutTransfer")
          .orderBy("createdAt", descending: true);
    } else if (config.type == TransferType.MoneyPoolContribution) {
      if (config.isEqualToFilter == null) {
        query = _paymentsCollectionReference
            .where("transferDetails.senderId", isEqualTo: currentUser.uid)
            .where("type", isEqualTo: "MoneyPoolContribution")
            .orderBy("createdAt", descending: true);
      } else {
        query = _paymentsCollectionReference
            .where(config.isEqualToFilter!.keys.first,
                isEqualTo: config.isEqualToFilter!.values.first)
            .where("transferDetails.senderId", isEqualTo: currentUser.uid)
            .where("type", isEqualTo: "MoneyPoolContribution")
            .orderBy("createdAt", descending: true);
      }
    } else {
      // TODO: Throw exception and make return value non-nullable
      log.e("Could not find stream corresponding to provided config '$config'");
      throw Exception("Exception occured. TODO: Add proper Exception here!");
    }

    if (config.maxNumberReturns != null)
      query = query.limit(config.maxNumberReturns!);

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

  // More generic class to listen to firestore collections for updates.
  // callback can be used to provide notifyListeners from the viewmodel
  // to the service
  void addTransferDataListener(
      {required MoneyTransferQueryConfig config, void Function()? callback}) {
    // TODO: Treat type MoneyPoolPayout
    if (config.type == TransferType.MoneyPoolPayout) {
      log.e(
          "Can't listen to money pool payouts at the moment. NOT YET IMPLEMENTED");
      if (callback != null) callback();
      return;
    }

    if (_transfersSubscriptions.containsKey(config)) {
      log.v(
          "Stream with config '$config' already listened to, resuming it in case it has been paused!");
      _transfersSubscriptions[config]?.resume();
      if (callback != null) callback();
      return;
    } else {
      log.i("Setting up listener for transfers with config $config.");
      Stream<List<MoneyTransfer>> snapshot;
      try {
        snapshot = getTransferDataStream(config: config);

        // listen to combined stream and add transactions to controller
        _transfersSubscriptions[config] = snapshot.listen(
          (transactions) {
            // Option to make the list unique!
            if (config.makeUnique != null) {
              // TODO: Make function that makes this list unique for senderNames
              latestTransfers[config] = transactions.toSet().toList();
            } else {
              latestTransfers[config] = transactions;
            }
            log.v(
                "Listened to ${transactions.length} transfers with config $config. Max returns were specified with ${config.maxNumberReturns}");
            if (callback != null) callback();
          },
        );
      } catch (e) {
        rethrow;
      }
    }
  }

  // pause the listener
  void pauseTransferDataListener(
      {required MoneyTransferQueryConfig config, void Function()? callback}) {
    log.v("Remove transfer data listener with config: '$config'");
    _transfersSubscriptions[config]?.pause();
  }

  // Get transactions for type and direction
  // Could be done better! User has to parse redundant information
  List<MoneyTransfer> getTransfers({required MoneyTransferQueryConfig config}) {
    if (config.type == TransferType.Invalid) {
      log.w(
          "You tried to retrieve list of money transfers of invalid type. Returning empty list");
      return [];
    }

    if (!latestTransfers.containsKey(config)) {
      log.w(
          "Did not find any transfers for config $config. Please add a listener with 'addTransferDataListener()'. Returning empty list");
      return [];
    } else {
      return latestTransfers[config]!;
    }
  }

  ///////////////////////////////////////////////////
  // Clean up

  // clear all data when user logs out!
  Future handleLogoutEvent() async {
    // clear wallet
    userStatsSubject.add(getEmptyUserStatistics());
    // set current user to null
    _currentUser = User.empty();
    // remove money Pools
    _moneyPoolService!.clearData();
    // actually log out from firebase
    await _firebaseAuthenticationService!.logout();
    // set auth state to signed out
    userStateSubject.add(UserStatus.SignedOut);
  }
}
