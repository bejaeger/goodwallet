// Service for authentification
// Functionalities
//  - Handle login/signup

import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/user.dart';
import 'package:good_wallet/services/userdata/firestore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

enum UserStatus { Unknown, SignedIn, SignedOut }

class UserState {
  UserStatus status;
  dynamic value;

  UserState({this.value}) {
    this.status = value == "undefined"
        ? UserStatus.Unknown
        : value == null
            ? UserStatus.SignedOut
            : UserStatus.SignedIn;
    this.value = value;
  }
}

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final FirestoreUserService _firestoreService =
      locator<FirestoreUserService>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  MyUser _currentUser;
  MyUser get currentUser => _currentUser;

  var _userState = BehaviorSubject<UserState>();
  UserStatus get userStatus => _userState.value.status;
  Stream<User> userStream;

  // Stream<User> user; // firebase user
  AuthenticationService() {
    // ! Very important to initialize this !
    _userState.add(UserState(value: "undefined"));
    userStream = FirebaseAuth.instance.authStateChanges();
    userStream.listen((user) {
      if (user != null) {
        _userState.add(UserState(value: user));
      } else {
        _userState.add(UserState(value: null));
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
    var result = await _prepareUserData(user);
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
      await _prepareUserData(authResult.user);
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
    // TODO: Use dartxs package here to handle currentUser
    // @see: https://fireship.io/lessons/flutter-firebase-google-oauth-firestore/
    // THIS NEEDS TO BE IMPROVED!
    bool loop = true;
    var user;
    var counter = 0;
    //print(userStream.done);
    //print("Before loop $userState.status");

    print("status: ${_userState.value.status}");

    while (loop) {
      await Future.delayed(Duration(milliseconds: 100));
      try {
        user = _firebaseAuth.currentUser;
        var uid = user.uid;
        loop = false;
      } catch (e) {
        print("In loop $userStream");
        print("INFO: Trying to get current user again after 0.1 seconds!");
        counter = counter + 1;
        if (counter > 20) break;
      }
    }
    //return user.done();
    print("After loop");
    //print(userStream.done);
    print("has value: ${_userState.hasValue}");
    print("status: ${_userState.value.status}");

    await _prepareUserData(user);
    return user != null;
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

  Future _prepareUserData(User user) async {
    if (user != null) {
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
      return true;
    }
    return false;
  }

  Future logout() async {
    _currentUser = null;
    _firebaseAuth.signOut();
  }
}
