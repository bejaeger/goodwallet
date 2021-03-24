import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/datamodels/user/user_state_model.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

// Service for authentification on top of stacked' FirebaseAuthentificationService
// Functionalities
//  - Handle login/signup

// TODO
// Refactor this service and use stacked authentification service instead
// Rename it to UserAuthStatusService

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserDataService _userDataService = locator<UserDataService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final log = getLogger("authentification_service.dart");

  // bool to keep track of initialization
  bool _isInitializedCurrentUser;

  var _userStateSubject = BehaviorSubject<UserState>();

  UserStatus _userStatus;
  UserStatus get userStatus => _userStatus;

  bool get isSignedIn => _userStatus == UserStatus.SignedIn;

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

        // TODO Initialize HERE!
        // otherwise the initialization happens too late!

        UserDataServiceResult result =
            await _userDataService.initializeCurrentUser(user?.uid);
        if (!result.hasError) {
          _userStatus = UserStatus.SignedIn;
          _userStateSubject.add(UserState(value: user));
        } else {
          log.e("Error innitializing current user: ${result.errorMessage}");
        }
        log.i("Initialized current user = ${_userStateSubject.value.status}");
      } else {
        _isInitializedCurrentUser = false;
        _userStatus = UserStatus.SignedOut;
        _userStateSubject.add(UserState(value: null));
        _userDataService.setCurrentUser(null);
        log.i("User status changed to ${_userStateSubject.value.status}");
      }
    });
  }

  Future<bool> isUserLoggedIn() async {
    bool loggedIn = userStatus == UserStatus.SignedIn ? true : false;
    return loggedIn;
  }

  Future logout() async {
    // just need to logout, the rest is handled by listeners
    _isInitializedCurrentUser = false;
    _firebaseAuth.signOut();
  }
}
