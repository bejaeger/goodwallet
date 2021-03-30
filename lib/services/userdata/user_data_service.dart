// Service to connect to user data stored on firestore

// Functionalities
// - initializing current User (id, e-mail, fullname, wallet balances)
// - exposing currentUser
// - exposing stream of wallet balances

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/payments/donation_model.dart';
import 'package:good_wallet/datamodels/payments/transaction_model.dart';
import 'package:good_wallet/datamodels/payments/wallet_balances_model.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/user_status.dart';
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

  final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

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
  MyUser _currentUser;
  MyUser get currentUser => _currentUser;
  void setCurrentUser(MyUser user) {
    _currentUser = user;
  }

  // Listen to auth state changes.
  // This is useful in scenarios where we want to
  // show certain content without the need register for the user.
  // This might not be of need for mobile but
  // will become more useful thinking about PWAs especially
  // on desktop.
  Stream<User> userStream;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserDataService() {
    userStream = _firebaseAuth.authStateChanges();
    userStream.listen(
      (user) async {
        if (user != null) {
          userStateSubject.add(UserStatus.SignedIn);
          initializeCurrentUser(user.uid);
        } else {
          userStateSubject.add(UserStatus.SignedOut);
        }
        log.i("User status changed to ${userStateSubject.value}");
      },
    );
  }

  Future<UserDataServiceResult> initializeCurrentUser(String uid) async {
    log.i("Initializing user data");

    if (uid == null) {
      log.e("No user id specified for initiliazation.");
      return UserDataServiceResult.error(errorMessage: "No user specified!");
    }

    if (userStateSubject.value != UserStatus.Initialized) {
      log.i("Populating current user");
      try {
        await _populateCurrentUser(uid);
        userWalletSubject.add(await updateWallet(uid));
        userStateSubject.add(UserStatus.Initialized);
      } catch (e) {
        return UserDataServiceResult.error(
            errorMessage:
                "Initializing current user failed with message: ${e.toString()}");
      }
    } else {
      log.w(
          "User already initialized. To avoid future problems it is best to check why this function is executed twice");
    }
    return UserDataServiceResult();
  }

  Future _populateCurrentUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      if (userData == null) {
        // This means no user has been created yet in cloud firestore
        // This happens for example when loggin in with google, facebook, ...
        // We first have to create a user and then

        log.w(
            "Create user because this seems to be the first time a user is logging in with third-party authentification");
        //createUser(uid);
        // We NEED the actual user here!
        log.e("This is not yet implemented!");
      }
      MyUser user = MyUser.fromData(userData.data());
      _currentUser = user;
    } catch (e) {
      log.e("Error in _populateCurrentUser(): ${e.toString()}");
      rethrow;
    }
  }

  // User ------------------------------------------------->>
  Future createUser(User user, [String fullName]) async {
    if (user == null) {
      UserDataServiceResult.error(
          errorMessage: "Could not create user, user is null");
    }
    // create a new user profile on firestore`
    num balance = 0;
    num implicitDonations = 0;
    num donations = 0;
    String name = fullName ?? (user.displayName ?? "");
    MyUser myuser = MyUser(
      id: user.uid,
      email: user.email,
      fullName: name,
      balance: balance,
      implicitDonations: implicitDonations,
      donations: donations,
    );
    try {
      await _usersCollectionReference.doc(user.uid).set(myuser.toJson(true));
      return UserDataServiceResult();
    } catch (e) {
      log.e("Error in createUser(): ${e.toString()}");
      return UserDataServiceResult.error(
          errorMessage:
              "Creating user data failed with message: ${e.toString()}");
    }
  }

  Future updateWallet(var uid) async {
    try {
      _usersCollectionReference.doc(uid).snapshots().listen((userData) {
        if (userData != null) {
          userWalletSubject.add(WalletBalancesModel.fromData({
            'currentBalance': userData["balance"] as num,
            'donations': userData["donations"] as num,
            'transferredToPeers': userData["implicitDonations"] as num,
          }));
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
        .where("senderUid", isEqualTo: currentUser.id)
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .snapshots();
    Stream<QuerySnapshot> incoming = _paymentsCollectionReference
        .where("recipientUid", isEqualTo: currentUser.id)
        .orderBy("createdAt", descending: true)
        .snapshots();

    // combine streams with rxdart
    Stream<List<dynamic>> transactionStream =
        Rx.combineLatest2(outgoing, incoming, (outSnapshot, inSnapshot) {
      // list of transactions to be returned
      List<dynamic> transactions = <dynamic>[];

      if (outSnapshot.docs.isNotEmpty) {
        transactions.addAll(outSnapshot.docs
            .map((snapshot) => TransactionModel.fromMap(snapshot.data()))
            .toList());
      }
      if (inSnapshot.docs.isNotEmpty) {
        List<dynamic> inTransactions = inSnapshot.docs
            .map((snapshot) => TransactionModel.fromMap(snapshot.data()))
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
        .where("recipientUid", isEqualTo: currentUser.id)
        .orderBy("createdAt", descending: true)
        .snapshots();

    // combine streams with rxdart
    Stream<List<dynamic>> transactionStream =
        Rx.combineLatest2(outgoing, incoming, (outSnapshot, inSnapshot) {
      // list of transactions to be returned
      List<dynamic> transactions = <dynamic>[];

      if (outSnapshot.docs.isNotEmpty) {
        transactions.addAll(outSnapshot.docs
            .map((snapshot) => DonationModel.fromMap(snapshot.data()))
            .toList());
      }
      if (inSnapshot.docs.isNotEmpty) {
        List<dynamic> inTransactions = inSnapshot.docs
            .map((snapshot) => TransactionModel.fromMap(snapshot.data()))
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
    if (donationsSnapshot != null) {
      if (donationsSnapshot.docs.isNotEmpty) {
        listOfDonations.addAll(donationsSnapshot.docs
            .map((snapshot) => DonationModel.fromMap(snapshot.data()))
            .toList());
      } else {
        log.e("Snapshot of donations collectoin is empty");
      }
    } else {
      log.e(
          "Donations could not be retrieved, check how you access the firestore collections");
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
        .where("senderUid", isEqualTo: currentUser.id)
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .get();
    if (transactionsSnapshot != null) {
      if (transactionsSnapshot.docs.isNotEmpty) {
        try {
          listOfTransactionsToPeers.addAll(transactionsSnapshot.docs
              .map((snapshot) => TransactionModel.fromMap(snapshot.data()))
              .toList());
        } catch (e) {
          log.e("Could not map firestore data into TransactionModel");
        }
      } else {
        log.e("Snapshot of donations collecton is empty");
      }
    } else {
      log.e(
          "Donations could not be retrieved, check how you access the firestore collections");
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
        .where("recipientUid", isEqualTo: currentUser.id)
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .get();
    if (transactionsSnapshot != null) {
      if (transactionsSnapshot.docs.isNotEmpty) {
        try {
          listOfTransactions.addAll(transactionsSnapshot.docs
              .map((snapshot) => TransactionModel.fromMap(snapshot.data()))
              .toList());
        } catch (e) {
          log.e("Could not map firestore data into TransactionModel");
        }
      } else {
        log.e("Snapshot of donations collectin is empty");
      }
    } else {
      log.e(
          "Donations could not be retrieved, check how you access the firestore collections");
    }

    return listOfTransactions;
  }

  Future handleLogoutEvent() async {
    // clear wallet
    userWalletSubject.add(WalletBalancesModel.empty());
    // set current user to null
    _currentUser = null;
    // actually log out from firebase
    await _firebaseAuthenticationService.logout();
    // set auth state to signed out
    userStateSubject.add(UserStatus.SignedOut);
  }
}

// Helper class returned from public function of UserDataService
class UserDataServiceResult {
  /// Helper message which type of data was tried to be acceessed
  final String typeOfData;

  /// Contains the error message for the request
  final String errorMessage;

  UserDataServiceResult({this.typeOfData}) : errorMessage = null;

  UserDataServiceResult.error({this.errorMessage}) : typeOfData = null;

  /// Returns true if the response has an error associated with it
  bool get hasError => errorMessage != null && errorMessage.isNotEmpty;
}
