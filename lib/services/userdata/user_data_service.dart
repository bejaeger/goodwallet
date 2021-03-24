// Service to connect to user data stored on firestore

// Functionalities
// - initializing current User (id, e-mail, fullname, wallet balances)
// - exposing currentUser
// - exposing stream of wallet balances

import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/payments/wallet_balances_model.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/utils/logger.dart';

class UserDataService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final StreamController<WalletBalancesModel> _balancesStreamController =
      StreamController<WalletBalancesModel>.broadcast();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final log = getLogger("user_data_service.dart");

  bool _isInitializedCurrentUser = false;

  MyUser _currentUser;
  MyUser get currentUser => _currentUser;
  void setCurrentUser(MyUser user) {
    _currentUser = user;
  }

  Future<UserDataServiceResult> initializeCurrentUser(String uid) async {
    log.i("Initializing user data");

    if (uid == null) {
      return UserDataServiceResult.error(errorMessage: "No user ID specified!");
    }

    if (!_isInitializedCurrentUser) {
      log.i("Populating current user");
      var result = await _populateCurrentUser(uid);
      if (result is String) {
        // no user present yet!
        return UserDataServiceResult.error(
            errorMessage:
                "populating current user failed with message: $result");
      }
      // User is initialized successfully

      // TODO: Is this needed? should happen automatically with exposed streams
      // UPDATE
      // updating the state of the app
      await _userWalletService.updateBalancesLocal(uid);
      _isInitializedCurrentUser = true;
    } else {
      log.w(
          "User already initialized, this could cause problems. Check why this function is executed again");
    }
    return UserDataServiceResult();
  }

  Future _populateCurrentUser(String uid) async {
    var result = await _getUser(uid);
    if (result is String) {
      // In case no profile is available yet!
      return result;
    } else {
      // successful, set current user!
      _currentUser = result;
      return true;
    }
  }

  // User ------------------------------------------------->>
  Future createUser(User user, [String fullName]) async {
    // create a new user profile on firestore`
    num balance = 0;
    num implicitDonations = 0;
    num donations = 0;
    MyUser myuser = MyUser(
      id: user.uid,
      email: user.email,
      fullName: fullName != null ? fullName : user.displayName,
      balance: balance,
      implicitDonations: implicitDonations,
      donations: donations,
    );
    try {
      await _usersCollectionReference.doc(user.uid).set(myuser.toJson(true));
      return myuser;
    } catch (e) {
      log.e("Error in createUser(): ${e.toString()}");
      return e.toString();
    }
  }

  Future _getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      MyUser user = MyUser.fromData(userData.data());
      return user;
    } catch (e) {
      log.e("Error in _getUser(): ${e.toString()}");
      return e.toString();
    }
  }

  Stream listenToBalanceRealTime(var uid) {
    log.i("Start listening to wallet balances");
    Stream<DocumentSnapshot> docSnapshot =
        _usersCollectionReference.doc(uid).snapshots();
    docSnapshot.listen((userData) {
      if (userData != null) {
        _balancesStreamController.add(WalletBalancesModel.fromMap({
          'currentBalance': userData["balance"],
          'donated': userData["donations"],
          'sentToPeer': userData["implicitDonations"],
        }));
      }
    });
    return _balancesStreamController.stream;
  }

  void handleLogoutEvent() {
    // TODO: Clear current MyUser!
    _currentUser = null;
    _isInitializedCurrentUser = false;
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
