// Service for authentification
// Functionalities
//  - Handle login/signup

import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/models/user.dart';
import 'package:good_wallet/services/userdata/firestore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final FirestoreUserService _firestoreService =
      locator<FirestoreUserService>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  MyUser _currentUser;
  MyUser get currentUser => _currentUser;

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
    await _prepareUserData(user);
    // Done
    print("signed in " + user.displayName);
    //return user != null;
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

      // create a new user profile on firestore`
      num balance = 0;
      num implicitDonations = 0;
      num donations = 0;
      _currentUser = MyUser(
        id: authResult.user.uid,
        email: email,
        fullName: fullName,
        balance: balance,
        implicitDonations: implicitDonations,
        donations: donations,
      );
      var result = await _firestoreService.createUser(_currentUser);
      if (result is String) {
        return result;
      }

      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> isUserLoggedIn() async {
    // TODO: Use dartxs package here
    // @see: https://fireship.io/lessons/flutter-firebase-google-oauth-firestore/
    await Future.delayed(Duration(seconds: 3));
    var user = _firebaseAuth.currentUser;
    await _prepareUserData(user);
    print("User object: ");
    print(user);
    return user != null;
  }

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }

  Future _prepareUserData(User user) async {
    if (user != null) {
      print("INFO: Populating current user");
      await _populateCurrentUser(user);
      await _userWalletService.updateBalancesLocal(user.uid);
    }
  }

  Future updateCurrentUser() async {
    var user = _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
  }

  Future logout() async {
    _currentUser = null;
    _firebaseAuth.signOut();
  }
}
