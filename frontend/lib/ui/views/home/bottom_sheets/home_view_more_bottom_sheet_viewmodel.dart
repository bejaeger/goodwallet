import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewMoreBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  void navigateToExploreView() {
    _navigationService!.navigateTo(Routes.exploreView,
        arguments: ExploreViewArguments(
            searchType: SearchType.FindFriends, autofocus: true));
  }
}
