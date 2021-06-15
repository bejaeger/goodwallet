import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/services/projects/projects_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/projects_base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';

class ProjectsForAreaViewModel extends ProjectsBaseViewModel {
  final ProjectsService? _projectsService = locator<ProjectsService>();

  final log = getLogger("projects_for_area_viewmodel.dart");

  final String area;
  ProjectsForAreaViewModel({required this.area});

  List<Project> get projects =>
      _projectsService!.getProjectsForArea(area: area);
}
