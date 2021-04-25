import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/utils/logger.dart';

class CausesDataService {
  final GlobalGivingAPIService? _globalGivingAPIservice =
      locator<GlobalGivingAPIService>();
  final CollectionReference _causesCollectionReference =
      FirebaseFirestore.instance.collection("causes");
  final UserDataService? _userDataService = locator<UserDataService>();

  final log = getLogger("causes_data_service.dart");
  List<GoodWalletProjectModel> projects = [];
  List<String> uniqueThemes = [];

  Future loadProjects() async {
    if (projects.isEmpty) {
      await fetchGlobalGivingProjects();
      log.i("Fetched project list with length ${projects.length}");
      // TODO: Add user info when no projects could be retrieved..e.g. network issues
    }
    uniqueThemes = projects.map((e) => e.themeName!).toList();
    uniqueThemes = uniqueThemes.toSet().toList();
    log.i("Found unique themes: $uniqueThemes");
  }

  Future fetchGlobalGivingProjects() async {
    QuerySnapshot projectsSnapshot = await _causesCollectionReference
        .where("causeType",
            isEqualTo: describeEnum(CauseType.GlobalGivingProject))
        .get();
    if (projectsSnapshot.docs.isNotEmpty) {
      log.i("Found data of global giving projects on firestore");
      projects = projectsSnapshot.docs
          .map((snapshot) => GoodWalletProjectModel.fromMap(snapshot.data()))
          .toList();
    } else {
      log.i("Get global giving projects from API");
      // No data stored on firestore yet, use global giving API
      projects = await _globalGivingAPIservice!
          .getProjectsOfTheMonth(addToFirestore: false);
    }
  }
}
