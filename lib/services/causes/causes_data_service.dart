import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/utils/logger.dart';

class CausesDataService {
  final GlobalGivingAPIService? _globalGivingAPIservice =
      locator<GlobalGivingAPIService>();
  final CollectionReference _causesCollectionReference =
      FirebaseFirestore.instance.collection("causes");

  final log = getLogger("causes_data_service.dart");
  List<Project> projects = [];
  List<ConciseProjectInfo> goodWalletFunds = [];
  List<String> uniqueThemes = [];

  Future loadProjects() async {
    if (projects.isEmpty) {
      await fetchGlobalGivingProjects();
      log.i("Fetched project list with length ${projects.length}");
      // TODO: Add public facing user notice when no projects could be retrieved..e.g. network issues
      uniqueThemes = projects.map((e) => e.area).toList();
      uniqueThemes = uniqueThemes.toSet().toList();
      log.i("Found unique themes: $uniqueThemes");
    }
  }

  Future loadGoodWalletFunds() async {
    if (goodWalletFunds.isEmpty) {
      goodWalletFunds = [
        ConciseProjectInfo(
          id: "DummyID",
          name: "Friend Referral Fund",
          description:
              "This fund is used to raise money when referring the Good Wallet to your peers",
          imagePath: ImagePath.peopleHoldingHands,
          area: "Good Wallet Fund",
        ),
        ConciseProjectInfo(
          id: "DummyID",
          name: "The Developer Fund",
          description:
              "Support further developments of the Good Wallet to offer better services",
          imagePath: ImagePath.workNextToCreek,
          area: "Good Wallet Fund",
        ),
      ];
      log.i(
          "Fetched good wallet fund list with length ${goodWalletFunds.length}");
    }
  }

  Future fetchGlobalGivingProjects() async {
    QuerySnapshot projectsSnapshot = await _causesCollectionReference
        .where("causeType",
            isEqualTo: describeEnum(CauseType.GlobalGivingProject))
        .get();
    if (projectsSnapshot.docs.isNotEmpty) {
      log.i("Found data of global giving projects on firestore");
      projects = projectsSnapshot.docs
          .map((snapshot) => Project.fromJson(snapshot.data()))
          .toList();
    } else {
      log.i("Get global giving projects from API");
      // No data stored on firestore yet, use global giving API
      projects = await _globalGivingAPIservice!
          .getProjectsOfTheMonth(addToFirestore: false);
    }
  }
}
