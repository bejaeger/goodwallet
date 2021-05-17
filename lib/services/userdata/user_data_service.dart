// Intermediary between Firestore and Viewmodels

// Functionalities
// - initializing current User (id, e-mail, fullname, wallet balances)
// - exposing currentUser
// - exposing stream of statistics
// - allows to retrieve any transfer document

// TODO: Get rid of FirebaseAuth dependence or make it such
// that it can be mocked out in unit tests
// Potentially add authStateChange to FirebaseAuthenticationService

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/exceptions/user_data_service_exception.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class UserDataService {
  final log = getLogger("user_data_service.dart");

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

  // current user with all our custom data attached to it
  late User _currentUser;
  // Get current user
  User get currentUser => _currentUser;
  void setCurrentUser(User user) {
    _currentUser = user;
  }

  // list of latest transactions and their subscriptions
  Map<MoneyTransferQueryConfig, List<MoneyTransfer>> latestTransfers = {};
  Map<MoneyTransferQueryConfig, StreamSubscription?> _transfersSubscriptions =
      {};

  StreamSubscription? userStreamSubscription;
  // Argument implemented for testing purposes
  UserDataService({bool startListeningToAuthStateChanges = true}) {
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
      userStreamSubscription =
          _firebaseAuthenticationService!.authStateChanges.listen((user) async {
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
        throw UserDataServiceException(
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
                email: user.email ?? ""),
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
      throw UserDataServiceException(
        message: "Creating user data failed with message",
        devDetails: e.toString(),
        prettyDetails:
            "User data could not be created in our databank. Please try again later or contact support with error messaage: ${e.toString()}",
      );
    }
  }

  ///////////////////////////////////////////////////////////////
  ///
  /// Functions related to user data

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

  // Get query for transaction with given direction.
  // optionally set the maximum number of documents retrieved
  Stream<List<MoneyTransfer>> getTransferDataStream(
      {required MoneyTransferQueryConfig config}) {
    // check arguments:
    if (!isValidFirestoreQueryConfig(config: config)) {
      throw UserDataServiceException(
          message:
              "The provided firestore query filter: '$config.isEqualToFilter' is not supported at the moment!");
    }
    return _firestoreApi.getTransferDataStream(
        config: config, uid: currentUser.uid);
  }

  // Get transfers for config. Using this function makes only sense
  // if a listener has been added with addTransferDataListener, seebe low
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

  // More generic class to listen to firestore collections for updates.
  // callback can be used to provide notifyListeners from the viewmodel
  // to the service
  void addTransferDataListener(
      {required MoneyTransferQueryConfig config, void Function()? callback}) {
    // TODO: Support for type MoneyPoolPayout
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
            if (config.makeUniqueRecipient != null) {
              latestTransfers[config] =
                  getMoneyTransfersWithUniqueSender(transactions);
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

  ///////////////////////////////////////////////
  /// Helpers

  /// Return list with removed duplicates
  List<MoneyTransfer> getMoneyTransfersWithUniqueSender(
      List<MoneyTransfer> transfer) {
    List<MoneyTransfer> returnTransfers = [];
    transfer.forEach((element) {
      if (!returnTransfers.any((returnElement) =>
          returnElement.transferDetails.recipientId ==
          element.transferDetails.recipientId)) returnTransfers.add(element);
    });
    return returnTransfers;
  }

  bool isValidFirestoreQueryConfig({required MoneyTransferQueryConfig config}) {
    if (config.isEqualToFilter != null && config.isEqualToFilter!.length > 1)
      return false;
    if (config.type == TransferType.Invalid) return false;
    return true;
  }

  ///////////////////////////////////////////////////
  // Clean up

  // clear all data when user logs out!
  Future handleLogoutEvent() async {
    // clear wallet
    userStatsSubject.add(getEmptyUserStatistics());
    // set current user to null
    _currentUser = User.empty();
    // actually log out from firebase
    await _firebaseAuthenticationService!.logout();
    // set auth state to signed out
    userStateSubject.add(UserStatus.SignedOut);
  }
}
