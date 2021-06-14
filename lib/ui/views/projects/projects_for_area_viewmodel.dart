import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class ProjectsForAreaViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserService? _userService = locator<UserService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final log = getLogger("projects_for_area_viewmodel.dart");

  final List<Project> projects;
  ProjectsForAreaViewModel({required this.projects});

  Future navigateToSingleProjectScreen(index) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(
            project: projects[index], projectId: projects[index].id));
  }

  bool isFavoriteProject(String projectId) {
    return _userService!.isFavoriteProject(projectId: projectId);
  }

  Future addOrRemoveFavorite(String projectId) async {
    try {
      bool add = await _userService!.addOrRemoveFavorite(projectId: projectId);
      notifyListeners();
      if (add) {
        _snackbarService.showSnackbar(
            title: "Added to favorites.", message: "");
      } else {
        _snackbarService.showSnackbar(
            title: "Removed from favorites.", message: "");
      }
    } catch (e) {
      log.wtf("Could not add or remove favorite project due to error $e");
      rethrow;
    }
  }
}
