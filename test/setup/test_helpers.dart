// This file contains setup functions that are created
// to remove duplicate code from tests and make them more
// readable.

import 'package:good_wallet/services/authentification/user_auth_status_listener_service.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

UserAuthStatusListenerService getAndRegisterAuthentificationService() {
  var authentificationService = UserAuthStatusListenerService();
  locator.registerSingleton<UserAuthStatusListenerService>(
      authentificationService);
  return authentificationService;
}

NavigationService getAndRegisterNavigationService() {
  var navigationService = NavigationService();
  locator.registerSingleton<NavigationService>(navigationService);
  return navigationService;
}
