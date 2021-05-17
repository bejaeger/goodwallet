import 'package:flutter_test/flutter_test.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:mockito/mockito.dart';
import '../helpers/mock_firebase_user.dart';
import '../helpers/test_helpers.dart';

UserDataService _getService({required bool startListeningToAuthStateChanges}) {
  return UserDataService(
      startListeningToAuthStateChanges: startListeningToAuthStateChanges);
}

final mockFirebaseUser = MockFirebaseUser();

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

  group('Initialization of user -', () {
    test(
        'When firebase user is null UserStatus should be SignedOut after listening auth state chance',
        () async {
      getAndRegisterFirestoreApi();
      getAndRegisterFirebaseAuthenticationService(currentUser: null);
      final service = _getService(startListeningToAuthStateChanges: false);
      await service.listenToAuthStateChanges();
      expect(service.userStatus, UserStatus.SignedOut);
    });

    test(
        'When firebase user is not null and has an entry in the database UserStatus should be Initialized after awaiting auth state changes',
        () async {
      getAndRegisterFirebaseAuthenticationService(
          currentUser: mockFirebaseUser);
      getAndRegisterFirestoreApi(
          user: User(
              uid: 'dummy_uid', email: 'dummy_email', fullName: 'dummy_name'));
      when(mockFirebaseUser.uid).thenReturn("UID");
      when(mockFirebaseUser.email).thenReturn("EMAIL");
      when(mockFirebaseUser.displayName).thenReturn("NAME");
      final service = _getService(startListeningToAuthStateChanges: false);
      await service.listenToAuthStateChanges();
      expect(service.userStatus, UserStatus.Initialized);
    });

    ///////////////////
    //// Not yet working because it says a non-mockito object is tested...what!?
    // test(
    //     'When firebase user is not null but has no entry in the database should create User',
    //     () async {
    //   getAndRegisterFirebaseAuthenticationService(
    //       currentUser: mockFirebaseUser);
    //   final _firestoreApi = getAndRegisterFirestoreApi(user: null);
    //   when(mockFirebaseUser.uid).thenReturn("UID");
    //   when(mockFirebaseUser.email).thenReturn("EMAIL");
    //   when(mockFirebaseUser.displayName).thenReturn("NAME");
    //   final service = _getService(startListeningToAuthStateChanges: false);
    //   await service.listenToAuthStateChanges();
    //   verify(_firestoreApi.createUser);
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
