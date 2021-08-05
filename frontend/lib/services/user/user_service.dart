// Intermediary between Firestore and Viewmodels

// Functionalities
// - initializing current User (id, e-mail, fullname, wallet balances)
// - exposing currentUser
// - exposing stream of statistics

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/statistics/supported_project_statistics.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/datamodels/user/user_settings.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/exceptions/user_service_exception.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class UserService {
  final log = getLogger("user_service.dart");

  final _firestoreApi = locator<FirestoreApi>();
  final FirebaseAuthenticationService? _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  // subject to keep track of initialization of user
  BehaviorSubject<UserStatus> userStateSubject =
      BehaviorSubject<UserStatus>.seeded(UserStatus.Unknown);
  UserStatus? get userStatus => userStateSubject.value;

  // subject to keep track and expose wallet
  BehaviorSubject<UserStatistics> userStatsSubject =
      BehaviorSubject<UserStatistics>.seeded(getEmptyUserStatistics());
  UserStatistics? get userStats => userStatsSubject.value;

  // store list of friends
  // map of list of money pools with money Pool id as key
  List<User> friends = [];
  StreamSubscription? _userDataStreamSubscription;

  // current user with all our custom data attached to it
  late User _currentUser;
  // Get current user
  User get currentUser => _currentUser;
  void setCurrentUser(User user) {
    _currentUser = user;
  }

  StreamSubscription? userStreamSubscription;
  // Argument implemented for testing purposes
  UserService({bool startListeningToAuthStateChanges = true}) {
    if (startListeningToAuthStateChanges) {
      listenToAuthStateChanges();
    }
  }

  // Listen to auth state changes with option to await first results
  // (the latter is useful for unit testing)
  // This is useful in scenarios where we want to
  // show certain content without the need to register for the user.
  // This might not be of need for mobile but
  // will become more useful thinking about PWAs especially
  // on desktop.
  Future<void>? listenToAuthStateChanges() async {
    if (userStreamSubscription == null) {
      var completer = Completer<void>();
      userStreamSubscription = _firebaseAuthenticationService!.firebaseAuth
          .authStateChanges()
          .listen((user) async {
        await authStateChangesOnDataCallback(user);
        if (!completer.isCompleted) {
          completer.complete();
        }
      });
      return completer.future;
    } else {
      log.w(
          "Auth state changes already listened to, not adding another listener");
    }
  }

  Future<void> authStateChangesOnDataCallback(firebase.User? user) async {
    if (user != null) {
      _changeUserStatus(UserStatus.SignedIn);
      await initializeCurrentUser(user);
    } else {
      _changeUserStatus(UserStatus.SignedOut);
    }
    log.i("User status changed to ${userStateSubject.value}");
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
        await _syncOrCreateUserAccount(user: user);
        await listenToUserSummaryStats(uid: user.uid);
        _changeUserStatus(UserStatus.Initialized);
      } catch (e) {
        // this should produce an error. listened to in start up logic
        log.wtf(
            "This should never happen and is likely due to an inconsistency in the backend: ${e.toString()}");
        _changeUserStatus(UserStatus.SignedInNotInitialized);
        throw UserServiceException(
            message: "Initializing current user failed",
            devDetails: e.toString());
      }
    } else {
      log.w("User already initialized. ");
    }
  }

  // populating current user
  Future _syncOrCreateUserAccount({required firebase.User user}) async {
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
          final nowPopulatedUser = await createUser(
            user: User(
                uid: user.uid,
                fullName: user.displayName ?? "",
                email: user.email ?? "",
                userSettings: UserSettings()),
          );
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
  Future<User> createUser({required User user}) async {
    // create a new user profile on firestore
    try {
      List<String> keywords = getListOfKeywordsFromString(user.fullName);
      User newUser = user.copyWith(searchKeywords: keywords);
      UserStatistics stats = getEmptyUserStatistics();
      await _firestoreApi.createUser(user: newUser, stats: stats);
      return newUser;
    } catch (e) {
      log.e("Error in createUser(): ${e.toString()}");
      throw UserServiceException(
        message: "Creating user data failed with message",
        devDetails: e.toString(),
        prettyDetails:
            "User data could not be created in our databank. Please try again later or contact support with error messaage: ${e.toString()}",
      );
    }
  }

  ///////////////////////////////////////////////////////////////
  ///
  /// Functions related to user data and settings

  /// Setting up user stats listener
  Future listenToUserSummaryStats({required String uid}) async {
    try {
      _firestoreApi
          .getUserSummaryStatisticsStream(uid: uid)
          .listen((stats) => userStatsSubject.add(stats));
    } catch (e) {
      rethrow;
    }
  }

  Future updateUserSettings({required userSettings}) async {
    _currentUser = _currentUser.copyWith(userSettings: userSettings);
    _firestoreApi.updateUserData(user: _currentUser);
  }

  ///////////////////////////////////////////////////////////////
  ///
  /// Functions related to user favorites and friends

  bool isFavoriteProject({required String projectId}) {
    List<String>? favIds = _currentUser.userSettings.favoriteProjectIds;
    if (favIds == null) {
      return false;
    } else {
      return favIds.contains(projectId);
    }
  }

  Future addOrRemoveFavorite({required String projectId}) async {
    UserSettings settings = _currentUser.userSettings;
    late UserSettings newSettings;
    List<String>? favIds = _currentUser.userSettings.favoriteProjectIds;
    late bool add;
    if (favIds == null) {
      add = true;
      newSettings = settings.copyWith(favoriteProjectIds: [projectId]);
    } else {
      if (favIds.contains(projectId)) {
        add = false;
        favIds.remove(projectId);
        newSettings = settings.copyWith(favoriteProjectIds: favIds);
      } else {
        add = true;
        favIds.add(projectId);
        newSettings = settings.copyWith(favoriteProjectIds: favIds);
      }
    }
    updateUserSettings(userSettings: newSettings);
    return add;
  }

  List<SupportedProjectStatistics> getSupportedProjects() {
    if (userStats == null) return [];
    return userStats!.donationStatistics.when(
        (totalDonations, supportedProjects, monthlyDonations) {
      supportedProjects
          .sort((a, b) => b.totalDonations.compareTo(a.totalDonations));
      return supportedProjects;
    }, empty: (totalDonations, supportedProjects, monthlyDonations) => []);
  }

  bool isFriend({required String uid}) {
    List<String>? friendsIds = _currentUser.userSettings.friendsIds;
    if (friendsIds == null) {
      return false;
    } else {
      return friendsIds.contains(uid);
    }
  }

  Future addOrRemoveFriend({required String uid}) async {
    UserSettings settings = _currentUser.userSettings;
    late UserSettings newSettings;
    List<String>? friendsIds = _currentUser.userSettings.friendsIds;
    late bool add;
    if (friendsIds == null) {
      add = true;
      newSettings = settings.copyWith(friendsIds: [uid]);
    } else {
      if (friendsIds.contains(uid)) {
        add = false;
        friendsIds.remove(uid);
        newSettings = settings.copyWith(friendsIds: friendsIds);
      } else {
        add = true;
        friendsIds.add(uid);
        newSettings = settings.copyWith(friendsIds: friendsIds);
      }
    }
    updateUserSettings(userSettings: newSettings);
    return add;
  }

  // TODO: make this a stream of users that is listened to in the  viewmodel!
  // need two streams. Stream of list with friends Ids. Whenevre that updates the
  // stream holding the list of friends will update too.

  Future listenToFriends() async {
    if (_userDataStreamSubscription == null) {
      var completer = Completer<void>();
      Stream userStream = _firestoreApi.getUserStream(uid: currentUser.uid);
      _userDataStreamSubscription = userStream.listen((event) async {
        await updateFriends();
        if (!completer.isCompleted) {
          completer.complete();
        }
        log.v("Listened to ${friends.length} friends");
      });
      return completer.future;
    }
  }

  Future updateFriends() async {
    List<String>? friendsIds = _currentUser.userSettings.friendsIds;
    List<User> tmpFriends = [];
    List<String> previousFriendsIds = friends.map((e) => e.uid).toList();
    if (friendsIds != null) {
      // add friends to but only read documents of new friends
      for (var id in friendsIds) {
        if (!previousFriendsIds.contains(id)) {
          log.i("getting user data with id $id");
          User? tmpUser = await _firestoreApi.getUser(uid: id);
          if (tmpUser != null) {
            tmpFriends.add(tmpUser);
          }
        }
      }
      // remove friends
      for (var id in previousFriendsIds) {
        if (!friendsIds.contains(id)) {
          friends.removeWhere((element) => element.uid == id);
        }
      }
    }
    friends.addAll(tmpFriends);
  }

  ///////////////////////////////////////////////////
  // Clean up

  // clear all data when user logs out!
  Future handleLogoutEvent() async {
    // cancel user stream subscription
    userStreamSubscription?.cancel();
    userStreamSubscription = null;
    // cancel user stream subscription
    _userDataStreamSubscription?.cancel();
    _userDataStreamSubscription = null;
    // clear wallet
    userStatsSubject.add(getEmptyUserStatistics());
    // set current user to null
    _currentUser = getEmptyUser();
    // actually log out from firebase
    await _firebaseAuthenticationService!.logout();
    // set auth state to signed out
    userStateSubject.add(UserStatus.SignedOut);
  }
}
