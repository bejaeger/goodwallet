import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/services/projects/projects_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

// this common viewmodel adds functionality for handling
// the project favorites feature

class ProjectsBaseViewModel extends BaseModel {
  final ProjectsService? _projectsService = locator<ProjectsService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserService? _userService = locator<UserService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final log = getLogger("projects_base_viewmodel.dart");

  List<Project> getFavoriteProjects() {
    return _projectsService!.getProjectsWithIds(
        projectIds: currentUser.userSettings.favoriteProjectIds);
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
            title: "Added to favorites.",
            message: "",
            duration: Duration(seconds: 1));
      } else {
        _snackbarService.showSnackbar(
            title: "Removed from favorites.",
            message: "",
            duration: Duration(seconds: 1));
      }
    } catch (e) {
      log.wtf("Could not add or remove favorite project due to error $e");
      rethrow;
    }
  }

  Future navigateToFavoritesView() async {
    await _navigationService!.navigateTo(Routes.favoriteProjectsView);
  }

  Future navigateToSingleProjectScreen(String projectId) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(projectId: projectId));
  }
}
