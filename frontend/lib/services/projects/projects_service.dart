// Holds state of projects

import 'dart:async';

import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/utils/logger.dart';

class ProjectsService {
  final _firestoreApi = locator<FirestoreApi>();

  final log = getLogger("projects_service.dart");

  StreamSubscription? _projectsStreamSubscription;
  List<Project> projects = [];
  List<Project> projectsUniqueArea = [];
  List<Project> favoriteProjects = [];

  List<ConciseProjectInfo> goodWalletFunds = [];

  // adds listener to projects collection
  // allows to wait for the first emission of the stream via the completer
  Future<void>? listenToProjects({required String uid}) async {
    if (_projectsStreamSubscription == null) {
      final snapshot = _firestoreApi.getProjectsStream(uid: uid);
      var completer = Completer<void>();
      _projectsStreamSubscription = snapshot.listen((snapshot) {
        projects = snapshot;
        if (!completer.isCompleted) {
          completer.complete();
        }
        log.v("Listened to ${projects.length} Projects");
      });
      return completer.future;
    } else {
      log.w("Projects stream already listened to, not adding another listener");
    }
  }

  List<Project> getProjectsUniqueArea() {
    List<Project> returnList = [];
    projects.forEach((element) {
      if (!returnList
          .any((returnElement) => returnElement.area == element.area))
        returnList.add(element);
    });
    projectsUniqueArea = returnList;
    return returnList;
  }

  List<Project> getProjectsWithIds({required List<String>? projectIds}) {
    if (projectIds == null) {
      return [];
    } else {
      List<Project> returnList = [];
      projects.forEach((element) {
        if (projectIds.contains(element.id)) {
          returnList.add(element);
        }
      });
      favoriteProjects = returnList;
      return returnList;
    }
  }

  Future<List<Project>> getProjectTopPicks() async {
    final globalStats = await _firestoreApi.getGlobalStatistics();
    return getProjectsWithIds(projectIds: globalStats.projectTopPicksIds);
  }

  List<String> getAllAreas() {
    List<String> uniqueThemes = projects.map((e) => e.area).toList();
    uniqueThemes = uniqueThemes.toSet().toList();
    return uniqueThemes;
  }

  List<Project> getProjectsForArea({required String area}) {
    if (area == "Good Wallet Fund") {
      return getGoodWalletFundsInfo();
    } else {
      List<Project> filteredProjects =
          projects.where((element) => element.area == area).toList();
      log.v("Found ${filteredProjects.length} projects with area $area");
      return filteredProjects;
    }
  }

  Future<Project> getProjectWithId({required String projectId}) async {
    Project? project;
    final iterable = projects.where((element) => element.id == projectId);
    if (iterable.isEmpty) {
      project = await _firestoreApi.getProjectWithId(id: projectId);
    } else {
      project = iterable.first;
    }
    return project;
  }

  Future<List<Project?>> queryProjects({required String queryString}) async {
    return await _firestoreApi.queryProjects(queryString: queryString);
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

  //--------------------------------------
  // Clean-up

  void clearData() {
    _projectsStreamSubscription?.cancel();
    _projectsStreamSubscription = null;
  }
}
