import 'dart:ffi';

import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/constants/constants.dart';
import 'package:good_wallet/data/global_giving_api_aux_data.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/exceptions/global_giving_api_exception.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';
import 'package:good_wallet/utils/logger.dart';

// For info on json parsing see
// @see https://dart.dev/tutorials/web/fetch-data

// This Api is currently only used to push information
// to our Firestore database!
// This is handled very poorly at the moment in the app and done
// by just using a button press in projects_view (need to uncommnent some lines)
// Ideally, this needs to happen
// only once for the Alpha v1 release, so we should be fine with that for now :)
// The client app will read the info from the Firestore database!

class GlobalGivingApi {
  final log = getLogger("global_giving_api_service.dart");

  final _firestoreApi = locator<FirestoreApi>();

  Future pushGlobalGivingProjectsToFirestore() async {
    // TODO: Take list of projects and fetch 10 projects for each request.

    try {
      String projectIdsString = kGlobalGivingProjectIds.join(",");
      final projectList =
          await getProjectsFromIds(projectIdsString: projectIdsString);
      for (dynamic project in projectList) {
        String nameForKeywords =
            "${project.name} ${project.area} ${project.organization.name}";
        List<String> nameSearch = getListOfKeywordsFromString(nameForKeywords);
        Project newProject = project.copyWith(nameSearch: nameSearch);
        _firestoreApi.createOrUpdateProject(project: newProject);
      }
    } catch (e) {
      throw GlobalGivingApiException(
          message: "Could not add projects to firestore",
          devDetails: "Error thrown: $e");
    }
  }

  Future getProjectsFromIds({required String projectIdsString}) async {
    Uri uri = getGlobalGivingUri(projectIds: projectIdsString);
    http.Response? response = await makeGlobalGivingApiCall(uri: uri);

    List<Project> projectList = [];
    if (response == null) {
      log.e(
          "For some reason the api request returned null! Returning empty project list.");
      return [];
    }
    try {
      var jsonResponse = convert.jsonDecode(response.body);
      var fetchedProjects =
          jsonResponse["projects"]["project"] as List<dynamic>;
      int numberProjects = fetchedProjects.length;
      for (int i = 0; i < numberProjects; i++) {
        Project project = getProjectFromGlobalGivingAPICall(
          fetchedProjects[i],
        );
        projectList.add(project);
      }
    } catch (e) {
      log.e(
          "Could not return featured projects, failed with error: ${e.toString()}");
      rethrow;
    }
    return projectList;
  }

  Uri getGlobalGivingUri({required String projectIds}) {
    Uri uri = Uri.https(
      kGlobalGivingAuthority,
      "/api/public/projectservice/projects/collection/ids",
      {
        "api_key": "578f2d27-8c47-4456-9d57-3bb0cb3f883b",
        "projectIds": projectIds,
      },
    );
    return uri;
  }

  Future makeGlobalGivingApiCall({required Uri uri}) async {
    http.Response? response;
    try {
      response = await http.get(uri, headers: {'accept': 'application/json'});
    } catch (e) {
      log.e("Error when trying to fetch project data: ${e.toString()}");
      rethrow;
    }
    return response;
  }

//--------------------------------------------------
// PLAYGROUND ==>>
// -----------------------------------------------------

  // get a random project
  Future getRandomProject() async {
    // test request for specific project
    //String url =
    //  "https://api.globalgiving.org/api/public/projectservice/projects/14516?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b";
    // all projects (returns 10)
    //url =
    //  "https://api.globalgiving.org/api/public/projectservice/all/projects/active?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b&nextProjectId=14516";
    // featured projects (returns 10)
    //url =
    //  "https://api.globalgiving.org/api/public/projectservice/featured/projects?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b";

    Uri uri = Uri.https(
        kGlobalGivingAuthority,
        kGlobalGivingFeatureProjectUnencodedPath,
        {"api_key": kGlobalGivingApiKey});
    http.Response? response = await makeGlobalGivingApiCall(uri: uri);
    if (response == null) {
      return null;
    }
    try {
      var jsonResponse = convert.jsonDecode(response.body);
      var fetchedProjects =
          jsonResponse["projects"]["project"] as List<dynamic>;
      int numberProjects = fetchedProjects.length - 1;
      Random random = new Random();
      int randomProjectNumber =
          random.nextInt(numberProjects); // seems limitted
      var jsonProject = fetchedProjects[randomProjectNumber];
      Project project = getProjectFromGlobalGivingAPICall(
        jsonProject,
      );
      return project;
      //return project;
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  // Get a random set of 10 features
  Future getFeaturedProjects() async {
    // test request for specific project
    // Uri url = Uri.http("api.globalgiving.org",
    //     "/api/public/projectservice/featured/projects", //?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b");
    //     {"api_key": "578f2d27-8c47-4456-9d57-3bb0cb3f883b"});
    Uri uri = Uri.https(
        kGlobalGivingAuthority,
        kGlobalGivingFeatureProjectUnencodedPath,
        {"api_key": kGlobalGivingApiKey});
    http.Response? response = await makeGlobalGivingApiCall(uri: uri);
    if (response == null) {
      return null;
    }
    try {
      var jsonResponse = convert.jsonDecode(response.body);
      var fetchedProjects =
          jsonResponse["projects"]["project"] as List<dynamic>;
      int numberProjects = fetchedProjects.length - 1;

      List<Project> projectList = [];
      for (int i = 0; i < numberProjects; i++) {
        Project project = getProjectFromGlobalGivingAPICall(fetchedProjects[i]);
        projectList.add(project);
      }
      return projectList;
    } catch (e) {
      log.e(
          "Could not return featured projects, failed with error: ${e.toString()}");
    }
  }
}
