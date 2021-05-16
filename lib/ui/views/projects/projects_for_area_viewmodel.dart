import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectsForAreaViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  final List<Project> projects;
  ProjectsForAreaViewModel({required this.projects});

  Future navigateToSingleProjectScreen(index) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(
            project: projects[index], projectId: projects[index].id));
  }
}
