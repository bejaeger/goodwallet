import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/global_giving_project_model.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_fund_model.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class CausesViewModel extends BaseModel {
  final _globalGivingAPIservice = locator<GlobalGivingAPIService>();
  final _navigationService = locator<NavigationService>();
  final CollectionReference _causesCollectionReference =
      FirebaseFirestore.instance.collection("causes");

  List<GoodWalletProjectModel> projects;
  List<GoodWalletFundModel> goodWalletFunds;

  Future fetchCauses() async {
    setBusy(true);
    if (projects == null) {
      await fetchGlobalGivingProjects();
      log.i("Fetched project list with length ${projects.length}");
    }
    if (goodWalletFunds == null) {
      goodWalletFunds = [
        GoodWalletFundModel(
          title: "Friend Referral Fund",
          description:
              "This fund is used to raise money when referring the Good Wallet to your peers",
          imagePath: ImagePath.peopleHoldingHands,
        ),
        GoodWalletFundModel(
          title: "The Developer Fund",
          description:
              "Support further developments of the Good Wallet to offer better services",
          imagePath: ImagePath.workNextToCreek,
        ),
      ];
      log.i(
          "Fetched good wallet fund list with length ${goodWalletFunds.length}");
    }
    setBusy(false);
    notifyListeners();
  }

  Future fetchGlobalGivingProjects() async {
    QuerySnapshot projectsSnapshot = await _causesCollectionReference
        .where("causeType", isEqualTo: CauseType.GlobalGivingProject.toString())
        .get();
    if (projectsSnapshot != null) {
      projects = projectsSnapshot.docs
          .map((snapshot) => GoodWalletProjectModel.fromMap(snapshot.data()))
          .toList();
    } else {
      // No data stored on firestore yet, use global giving API
      projects = await _globalGivingAPIservice.getProjectsOfTheMonth(
          addToFirestore: false);
    }
  }

  Future navigateToProjectScreen(index) async {
    await _navigationService.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(project: projects[index]));
  }
}
