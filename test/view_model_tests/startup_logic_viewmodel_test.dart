import 'package:flutter_test/flutter_test.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/ui/views/startup_logic/startup_logic_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';

StartUpLogicViewModel _getModel() => StartUpLogicViewModel();

void main() {
  group('StartupLogicViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());

    group('handleStartUpLogic -', () {
      test('When called should add listener to user state subject', () {
        final service = getAndRegisterUserDataService();
        var model = _getModel();
        model.handleStartUpLogic();
        verify(service.userStateSubject.listen);
      });

      // TODO: Find a way to unit test onData function
      // test('If no user is logged in, should navigate to loginView', () {
      //   final navigationService = getAndRegisterNavigationService();
      //   final service =
      //       getAndRegisterUserService(userStatus: UserStatus.SignedOut);
      //   var model = _getModel();
      //   model.handleStartUpLogic();
      //   expect(
      //       service.userStateSubject,
      //       verify(navigationService.replaceWith(
      //         Routes.loginView,
      //       )));
      // });

      // test('If user is logged in, should navigate to home view', () {
      //   final navigationService = getAndRegisterNavigationService();
      //   getAndRegisterUserService(userStatus: UserStatus.Initialized);
      //   var model = _getModel();
      //   model.handleStartUpLogic();
      //   verify(navigationService.replaceWith(
      //     Routes.layoutTemplateViewMobile,
      //   ));
      // });
    });
  });
}
