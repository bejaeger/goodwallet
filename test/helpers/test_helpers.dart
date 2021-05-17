import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/subjects.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  // our services registered with get_it
  MockSpec<UserDataService>(returnNullOnMissingStub: true),
  MockSpec<MoneyPoolsService>(returnNullOnMissingStub: true),
  MockSpec<FirestoreApi>(returnNullOnMissingStub: true),

  // stacked services registered with get_it
  MockSpec<NavigationService>(returnNullOnMissingStub: true),
  MockSpec<SnackbarService>(returnNullOnMissingStub: true),
  MockSpec<FirebaseAuthenticationService>(returnNullOnMissingStub: true),
])
UserDataService getAndRegisterUserDataService({
  UserStatus userStatus = UserStatus.SignedOut,
  User? currentUser,
}) {
  _removeRegistrationIfExists<UserDataService>();
  final service = MockUserDataService();
  when(service.userStateSubject)
      .thenAnswer((_) => BehaviorSubject<UserStatus>.seeded(userStatus));
  when(service.currentUser).thenReturn(currentUser ??
      User(uid: 'dummy_id', email: 'dummy_email', fullName: 'dummy_name'));
  locator.registerSingleton<UserDataService>(service);
  return service;
}

MoneyPoolsService getAndRegisterMoneyPoolService() {
  _removeRegistrationIfExists<MoneyPoolsService>();
  final service = MockMoneyPoolsService();
  locator.registerSingleton<MoneyPoolsService>(service);
  return service;
}

NavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

SnackbarService getAndRegisterSnackbarService() {
  _removeRegistrationIfExists<SnackbarService>();
  final service = MockSnackbarService();
  locator.registerSingleton<SnackbarService>(service);
  return service;
}

FirebaseAuthenticationService getAndRegisterFirebaseAuthenticationService({
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

FirestoreApi getAndRegisterFirestoreApi({User? user}) {
  _removeRegistrationIfExists<FirestoreApi>();
  final service = MockFirestoreApi();
  when(service.getUser(uid: anyNamed("uid")))
      .thenAnswer((realInvocation) async => user);
  final userStats = getEmptyUserStatistics();
  when(service.getUserSummaryStatisticsStream(uid: anyNamed("uid"))).thenAnswer(
      (realInvocation) => BehaviorSubject<UserStatistics>.seeded(userStats));
  when(service.createUser(user: anyNamed("user"), stats: anyNamed("stats")))
      .thenAnswer((realInvocation) async {});
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
  locator.unregister<UserDataService>();
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
