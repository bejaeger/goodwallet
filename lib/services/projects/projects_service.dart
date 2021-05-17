// Holds state of projects

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/utils/logger.dart';

class ProjectsService {
  final _firestoreApi = locator<FirestoreApi>();

  final GlobalGivingAPIService? _globalGivingAPIservice =
      locator<GlobalGivingAPIService>();
  final CollectionReference _causesCollectionReference =
      FirebaseFirestore.instance.collection("causes");

  final log = getLogger("projects_service.dart");

  StreamSubscription? _projectsStreamSubscription;
  List<Project> projects = [];
  List<Project> projectsUniqueArea = [];

  List<ConciseProjectInfo> goodWalletFunds = [];

  // adds listener to projects collection
  // allows to wait for the first emission of the stream via the completer
  Future<void>? listenToProjects({required String uid}) async {
    if (_projectsStreamSubscription == null) {
      var completer = Completer<void>();
      _projectsStreamSubscription =
          _firestoreApi.getProjectsStream(uid: uid).listen((snapshot) {
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

  List<String> getAllAreas() {
    List<String> uniqueThemes = projects.map((e) => e.area).toList();
    uniqueThemes = uniqueThemes.toSet().toList();
    return uniqueThemes;
  }

  List<Project> getProjectsForArea({required String area}) {
    List<Project> filteredProjects =
        projects.where((element) => element.area == area).toList();
    log.v("Found ${filteredProjects.length} projects with area $area");
    return filteredProjects;
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
}
