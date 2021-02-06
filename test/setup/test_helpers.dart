// This file contains setup functions that are created
// to remove duplicate code from tests and make them more
// readable.

import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

AuthenticationService getAndRegisterAuthentificationService() {
  var authentificationService = AuthenticationService();
  locator.registerSingleton<AuthenticationService>(authentificationService);
  return authentificationService;
}

NavigationService getAndRegisterNavigationService() {
  var navigationService = NavigationService();
  locator.registerSingleton<NavigationService>(navigationService);
  return navigationService;
}
