import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/apis/global_giving_api.dart';
import 'package:good_wallet/flavor_config.dart';
import 'package:good_wallet/services/projects/projects_service.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/views/common_viewmodels/projects_base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectsViewModel extends ProjectsBaseViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final ProjectsService? _projectsService = locator<ProjectsService>();
  final GlobalGivingApi? _globalGivingAPIservice = locator<GlobalGivingApi>();
  final FlavorConfigProvider _flavorConfigProvider =
      locator<FlavorConfigProvider>();
  String get testUserId => _flavorConfigProvider.testUserId;

  List<Project> projectQueryList = [];
  List<Project> get projects => _projectsService!.projects;
  List<Project> get projectUniqueAreas =>
      _projectsService!.getProjectsUniqueArea();
  List<Project>? projectTopPicks;
  bool isNew = true;
  final log = getLogger("projects_viewmodel.dart");

  // Starting money pool listener. Should only ever be called once!
  Future listenToData() async {
    setBusy(true);
    await _projectsService!.listenToProjects(uid: currentUser.uid);
    projectTopPicks = await _projectsService!.getProjectTopPicks();

    // some sorting
    if (projectTopPicks!.any((element) => element.name.contains("Climate"))) {
      Project climateProject = projectTopPicks!
          .firstWhere((element) => element.name.contains("Climate"));
      projectTopPicks!
          .removeWhere((element) => element.name.contains("Climate"));
      projectTopPicks = [climateProject, ...projectTopPicks!];
    }

    setBusy(false);
  }

  void reset() {
    isNew = true;
  }

  Project getProjectWithName({required String name}) {
    return projects.where((e) => e.name == name).first;
  }

  Future refresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    notifyListeners();
  }

  void pushGlobalGivingProjectsToFirestore() {
    log.i("Adding project info to firestore");
    _globalGivingAPIservice!.pushGlobalGivingProjectsToFirestore();
  }

  List<Project> getGoodWalletFundsInfo() {
    return _projectsService!.getGoodWalletFundsInfo();
  }

  void parseQueryProjects(List<Project> queryProjects) {
    projectQueryList = queryProjects;
  }

  Future queryProjects(String query) async {
    if (query == "") {
      isNew = true;
      projectQueryList = [];
      notifyListeners();
      return;
    }
    isNew = false;
    projectQueryList = [];
    List<Project?> tmpProjectList =
        await _projectsService!.queryProjects(queryString: query);
    for (dynamic project in tmpProjectList) {
      if (project != null) projectQueryList.add(project!);
    }
    log.i("Queried projects and found ${projectQueryList.length} matches");
    notifyListeners();
  }

  //////////////////////////////////////////////////
  /// Navigations
  ///
  Future navigateToProjectForAreaView(String area) async {
    await _navigationService!.navigateTo(Routes.projectsForAreaView,
        arguments: ProjectsForAreaViewArguments(area: area));
  }

  Future navigateToProjectsSearchView() async {
    await _navigationService!.navigateTo(Routes.projectsSearchView);
  }

  void navigateToProfileView() {
    _navigationService!.navigateTo(Routes.publicProfileViewMobile,
        arguments: PublicProfileViewMobileArguments(uid: currentUser.uid));
    //_navigationService!.navigateTo(Routes.profileViewMobile);
  }
}
