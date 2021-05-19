import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/services/projects/projects_service.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectsViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final ProjectsService? _projectsService = locator<ProjectsService>();
  final GlobalGivingAPIService? _globalGivingAPIservice =
      locator<GlobalGivingAPIService>();

  List<Project> get projects => _projectsService!.projects;
  List<Project> get projectUniqueAreas =>
      _projectsService!.getProjectsUniqueArea();
  List<Project> projectsForArea({required String area}) {
    if (area == "Good Wallet Fund") {
      return getGoodWalletFundsInfo();
    } else {
      return _projectsService!.getProjectsForArea(area: area);
    }
  }

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
  Future navigateToFavoritesView() async {
    showNotImplementedSnackbar();
  }

  Future navigateToProjectForAreaView({required String area}) async {
    await _navigationService!.navigateTo(Routes.projectsForAreaView,
        arguments: ProjectsForAreaViewArguments(
            projects: projectsForArea(area: area), area: area));
  }

  Future navigateToSingleProjectScreen({required String projectName}) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(
            project: getProjectWithName(name: projectName),
            projectId: getProjectWithName(name: projectName).id));
  }

  Project getProjectWithName({required String name}) {
    return projects.where((e) => e.name == name).first;
  }

  ///////////////////////////////////////////////////////
  /// Temporary extras

  /// good wallet funds
  List<Project> getGoodWalletFundsInfo() {
    return [
      Project(
          name: "Friend Referral Fund",
          id: "DummyID",
          area: "Good Wallet Fund",
          causeType: CauseType.GoodWalletFund,
          summary:
              "This fund is used to raise money to be used when referring the Good Wallet to friends",
          imageUrl: ImagePath.peopleHoldingHands),
      Project(
          name: "The Developer Fund",
          id: "DummyID",
          area: "Good Wallet Fund",
          causeType: CauseType.GoodWalletFund,
          summary:
              "Support further developments of the Good Wallet to offer better services",
          imageUrl: ImagePath.workNextToCreek),
    ];
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    notifyListeners();
  }

  void pushGlobalGivingProjectsToFirestore() {
    log.i("Adding project info to firestore");
    _globalGivingAPIservice!.getProjectsOfTheMonth(addToFirestore: true);
  }
}
