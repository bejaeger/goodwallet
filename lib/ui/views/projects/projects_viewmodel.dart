import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/apis/global_giving_api.dart';
import 'package:good_wallet/services/projects/projects_service.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/views/common_viewmodels/projects_base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectsViewModel extends ProjectsBaseViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final ProjectsService? _projectsService = locator<ProjectsService>();
  final GlobalGivingApi? _globalGivingAPIservice = locator<GlobalGivingApi>();

  List<Project> get projects => _projectsService!.projects;
  List<Project> get projectUniqueAreas =>
      _projectsService!.getProjectsUniqueArea();

  final log = getLogger("projects_viewmodel.dart");

  // Starting money pool listener. Should only ever be called once!
  Future listenToProjects() async {
    setBusy(true);
    await _projectsService!.listenToProjects(uid: currentUser.uid);
    setBusy(false);
  }

  //////////////////////////////////////////////////
  /// Navigations
  ///
  Future navigateToProjectForAreaView({required String area}) async {
    await _navigationService!.navigateTo(Routes.projectsForAreaView,
        arguments: ProjectsForAreaViewArguments(area: area));
  }

  Project getProjectWithName({required String name}) {
    return projects.where((e) => e.name == name).first;
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    notifyListeners();
  }

  void pushGlobalGivingProjectsToFirestore() {
    log.i("Adding project info to firestore");
    _globalGivingAPIservice!.getProjectsOfTheMonth(addToFirestore: true);
  }

  List<Project> getGoodWalletFundsInfo() {
    return _projectsService!.getGoodWalletFundsInfo();
  }
}
