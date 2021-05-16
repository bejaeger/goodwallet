import 'package:flutter_test/flutter_test.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:mockito/mockito.dart';
import '../helpers/test_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

UserDataService _getService({required bool startListeningToAuthStateChanges}) {
  return UserDataService(
      startListeningToAuthStateChanges: startListeningToAuthStateChanges);
}

class MockFirebaseUser extends Mock implements firebase.User {}

final MockFirebaseUser _mockFirebaseUser = MockFirebaseUser();

void main() {
  group('UserDataServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());
  });

  group('UserDataService (constructor) -', () {
    test(
        'When user data service is initialized with startListeningToAuthStateChanges set to true the userStreamSubscription should be non null verifying that the stream is listened to',
        () {
      getAndRegisterFirestoreApi();
      getAndRegisterFirebaseAuthenticationService();
      final service = _getService(startListeningToAuthStateChanges: true);
      expect(service.userStreamSubscription, isNot(null));
    });
  });

  group('authStateChangesOnDataCallback -', () {
    test(
        'When user is null UserStatus should be SignedOut after listening auth state chance',
        () async {
      getAndRegisterFirestoreApi();
      // register auth with null as user
      getAndRegisterFirebaseAuthenticationService(currentUser: null);
      final service = _getService(startListeningToAuthStateChanges: false);
      await service.listenToAuthStateChanges();
      expect(service.userStatus, UserStatus.SignedOut);
    });

    // test(
    //     'When user is not null UserStatus should be SignedIn after listening to auth state change',
    //     () async {
    //   final mockFirestoreApi = getAndRegisterFirestoreApi();
    //   final mockAuth = getAndRegisterFirebaseAuthenticationService(
    //       currentUser: _mockFirebaseUser);

    //   when(mockFirestoreApi.getUser(uid: anyNamed('uid'))).thenAnswer(
    //       (realInvocation) async =>
    //           User(uid: 'id', email: 'dummy_email', fullName: 'dummy_name'));

    //   UserDataService? service;
    //   try {
    //     service = _getService(startListeningToAuthStateChanges: false);
    //     await service.listenToAndAwaitFirstAuthStateChanges();
    //     expect(service.userStatus, UserStatus.SignedIn);
    //   } catch (e) {
    //     print("CAUGHT ERROR");
    //     expect(service?.userStatus, UserStatus.SignedIn);
    //   }
    // });
  });

  group('isValidFirestoreQueryConfig -', () {
    test('Should be true if simply asked for transfer type donation', () {
      getAndRegisterFirestoreApi();
      getAndRegisterFirebaseAuthenticationService();
      final service = _getService(startListeningToAuthStateChanges: false);
      final config = MoneyTransferQueryConfig(type: TransferType.Donation);
      expect(service.isValidFirestoreQueryConfig(config: config), true);
    });

    test('Should return false if filter length is larger 1', () {
      getAndRegisterFirestoreApi();
      getAndRegisterFirebaseAuthenticationService();
      final service = _getService(startListeningToAuthStateChanges: false);
      final config = MoneyTransferQueryConfig(
          type: TransferType.Donation,
          isEqualToFilter: {"hi": "10", "ciao": "is"});
      expect(service.isValidFirestoreQueryConfig(config: config), false);
    });
  });
}
