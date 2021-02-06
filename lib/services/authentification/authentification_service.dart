// Service for authentification
// Functionalities
//  - Handle login/signup

import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/datamodels/user/user_state_model.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/userdata/firestore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final FirestoreUserService _firestoreService =
      locator<FirestoreUserService>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  MyUser _currentUser;
  MyUser get currentUser => _currentUser;

  // bool to keep track of initialization
  bool _isInitializedCurrentUser;

  var _userStateSubject = BehaviorSubject<UserState>();

  UserStatus _userStatus;
  UserStatus get userStatus => _userStatus;

  BehaviorSubject<UserState> get userStateSubject => _userStateSubject;
  Stream<User> userStream;

  AuthenticationService() {
    // ! Initialize AuthentificationService at the start of the app !
    // TODO: Proper error handling!
    _isInitializedCurrentUser = false;
    _userStateSubject.add(UserState(value: "undefined"));
    _userStatus = UserStatus.Unknown;
    userStream = _firebaseAuth.authStateChanges();
    userStream.listen((user) async {
      if (user != null) {
        // only initialize if not already initialized!
        var result = await _initializeCurrentUser(user);
        if (result) {
          _userStatus = UserStatus.SignedIn;
          _userStateSubject.add(UserState(value: user));
        }
        print(
            "INFO: Initialized current user, user status = ${_userStateSubject.value.status}");
      } else {
        _isInitializedCurrentUser = false;
        _userStatus = UserStatus.SignedOut;
        _userStateSubject.add(UserState(value: null));
        _currentUser = null;
        print("INFO: User status changed to ${_userStateSubject.value.status}");
      }
    });
  }

  Future loginWithGoogle() async {
    // FIXME: Handle errors!
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    User user = userCredential.user;
    var result = await _initializeCurrentUser(user);
    if (result is String || (result is bool && !result)) {
      // need to create user in firestore!
      // create a new user profile on firestore
      var resultUser = await _firestoreService.createUser(user);
      if (resultUser is String) {
        return resultUser;
      } else {
        _currentUser = resultUser;
      }
    }

    // successfully signed in and set _currentUser
    return true;
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("INFO: Prepare user data");
      await _initializeCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      print("ERROR: ${e.toString()}");
      return e.toString();
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      var result =
          await _firestoreService.createUser(authResult.user, fullName);
      if (result is String) {
        return result;
      } else {
        _currentUser = result;
      }

      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> isUserLoggedIn() async {
    bool loggedIn = userStatus == UserStatus.SignedIn ? true : false;
    return loggedIn;
  }

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      var result = await _firestoreService.getUser(user.uid);
      if (result is String) {
        // In case no profile is available yet!
        return result;
      } else {
        _currentUser = result;
        return true;
      }
    }
    return false;
  }

  Future _initializeCurrentUser(User user) async {
    // return currentUser here!?
    if (user != null && !_isInitializedCurrentUser) {
      print("INFO: Populating current user");
      var result = await _populateCurrentUser(user);
      if (result is String) {
        // no user present yet!
        return result;
      } else if (!result) {
        return false;
      }
      // updating the state of the app
      await _userWalletService.updateBalancesLocal(user.uid);
      _isInitializedCurrentUser = true;
      return true;
    }
    return false;
  }

  Future logout() async {
    // just need to logout, the rest is handled by listeners
    _firebaseAuth.signOut();
  }
}
