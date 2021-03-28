// Service to connect to user data stored on firestore

// Functionalities
// - initializing current User (id, e-mail, fullname, wallet balances)
// - exposing currentUser
// - exposing stream of wallet balances

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/app/app.locator.dart';
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

  // controller to expose stream of wallet data and transactions
  final StreamController<WalletBalancesModel> _balancesStreamController =
      StreamController<WalletBalancesModel>.broadcast();
  final StreamController<List<dynamic>> _transactionsController =
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
      // var userData = await _usersCollectionReference.doc(uid).get();
      // userWalletSubject.add(WalletBalancesModel.fromData({
      //   'currentBalance': userData["balance"] as num,
      //   'donations': userData["donations"] as num,
      //   'transferredToPeers': userData["implicitDonations"] as num,
      // }));
    } catch (e) {
      log.e("Error updating user wallet: ${e.toString()}");
      rethrow;
    }
  }

  // This function is deprecated
  // Listen to wallet in base_viewmodel instead
  // Also, easier to use BehaviorSubject
  Stream listenToBalanceRealTime(var uid) {
    log.i("Start listening to wallet balances");
    Stream<DocumentSnapshot> docSnapshot =
        _usersCollectionReference.doc(uid).snapshots();
    docSnapshot.listen((userData) {
      if (userData != null) {
        _balancesStreamController.add(WalletBalancesModel.fromData({
          'currentBalance': userData["balance"] as double,
          'donations': userData["donations"] as double,
          'transferredToPeers': userData["implicitDonations"] as double,
        }));
      }
    });
    return _balancesStreamController.stream;
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

  Future getUsersOnceOff() async {
    try {
      var usersDocuments = await _usersCollectionReference.get();
      if (usersDocuments.docs.isNotEmpty) {
        return usersDocuments.docs
            .map((snapshot) => MyUser.fromMap(snapshot.data()))
            .where((mappedItem) => mappedItem.fullName != null)
            .toList();
      }
    } catch (e) {
      log.e("Error getting all user names in getUsersOnceOff(): ${e.toString()}");
      rethrow;
    }
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
