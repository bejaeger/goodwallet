import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/subjects.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  // our services registered with get_it
  MockSpec<UserService>(returnNullOnMissingStub: true),
  MockSpec<MoneyPoolsService>(returnNullOnMissingStub: true),
  MockSpec<FirestoreApi>(returnNullOnMissingStub: true),

  // stacked services registered with get_it
  MockSpec<NavigationService>(returnNullOnMissingStub: true),
  MockSpec<SnackbarService>(returnNullOnMissingStub: true),
  MockSpec<FirebaseAuthenticationService>(returnNullOnMissingStub: true),
])
MockUserService getAndRegisterUserDataService({
  UserStatus userStatus = UserStatus.SignedOut,
  User? currentUser,
}) {
  _removeRegistrationIfExists<UserService>();
  final service = MockUserService();
  when(service.userStateSubject)
      .thenAnswer((_) => BehaviorSubject<UserStatus>.seeded(userStatus));
  when(service.currentUser).thenReturn(currentUser ??
      User(uid: 'dummy_id', email: 'dummy_email', fullName: 'dummy_name'));
  locator.registerSingleton<UserService>(service);
  return service;
}

MockMoneyPoolsService getAndRegisterMoneyPoolService() {
  _removeRegistrationIfExists<MoneyPoolsService>();
  final service = MockMoneyPoolsService();
  locator.registerSingleton<MoneyPoolsService>(service);
  return service;
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockSnackbarService getAndRegisterSnackbarService() {
  _removeRegistrationIfExists<SnackbarService>();
  final service = MockSnackbarService();
  locator.registerSingleton<SnackbarService>(service);
  return service;
}

MockFirebaseAuthenticationService getAndRegisterFirebaseAuthenticationService({
  firebase.User? currentUser,
}) {
  _removeRegistrationIfExists<FirebaseAuthenticationService>();
  final service = MockFirebaseAuthenticationService();
  // Stream<firebase.User?> userStream(firebase.User? user) async* {
  //   yield user;
  // }
  // when(service.authStateChanges).thenAnswer((_) => userStream(currentUser));
  when(service.authStateChanges).thenAnswer((_) => Stream.value(currentUser));
  locator.registerSingleton<FirebaseAuthenticationService>(service);
  return service;
}

MockFirestoreApi getAndRegisterFirestoreApi({User? user}) {
  _removeRegistrationIfExists<FirestoreApi>();
  final service = MockFirestoreApi();
  when(service.getUser(uid: anyNamed("uid")))
      .thenAnswer((realInvocation) async => user);
  final userStats = getEmptyUserStatistics();
  when(service.getUserSummaryStatisticsStream(uid: anyNamed("uid"))).thenAnswer(
      (realInvocation) => BehaviorSubject<UserStatistics>.seeded(userStats));
  locator.registerSingleton<FirestoreApi>(service);
  return service;
}

void registerServices() {
  getAndRegisterUserDataService();
  getAndRegisterMoneyPoolService();
  getAndRegisterNavigationService();
  getAndRegisterSnackbarService();
  getAndRegisterFirestoreApi();
  getAndRegisterFirebaseAuthenticationService();
}

void unregisterServices() {
  locator.unregister<UserService>();
  locator.unregister<MoneyPoolsService>();
  locator.unregister<SnackbarService>();
  locator.unregister<NavigationService>();
  locator.unregister<FirestoreApi>();
  locator.unregister<FirebaseAuthenticationService>();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
