import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';
import 'package:good_wallet/utils/logger.dart';

// For info on json parsing see
// @see https://dart.dev/tutorials/web/fetch-data

class GlobalGivingAPIService {
  final log = getLogger("global_giving_api_service.dart");
  final CollectionReference _causesCollectionReference =
      FirebaseFirestore.instance.collection("causes");

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
    Uri url = Uri.https(
        "api.globalgiving.org",
        "/api/public/projectservice/featured/projects",
        {"api_key": "578f2d27-8c47-4456-9d57-3bb0cb3f883b"});
    http.Response? response = await fetchProject(url);
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

  Future getFeaturedProjects() async {
    // test request for specific project
    // Uri url = Uri.http("api.globalgiving.org",
    //     "/api/public/projectservice/featured/projects", //?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b");
    //     {"api_key": "578f2d27-8c47-4456-9d57-3bb0cb3f883b"});
    Uri url = Uri.https(
        "api.globalgiving.org",
        "/api/public/projectservice/featured/projects",
        {"api_key": "578f2d27-8c47-4456-9d57-3bb0cb3f883b"});
    http.Response? response = await fetchProject(url);
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

  Future getProjectsOfTheMonth({bool addToFirestore = false}) async {
    List<String> projectIds = [
      "14516",
      "3935",
      "5607",
      "31919",
      "9451",
      "2291",
      "8799",
      "1877",
      "6066",
      "898"
    ];
    Uri url = Uri.https(
      "api.globalgiving.org",
      "/api/public/projectservice/projects/collection/ids",
      {
        "api_key": "578f2d27-8c47-4456-9d57-3bb0cb3f883b",
        "projectIds": projectIds.join(",")
      },
    );
    return _getProjectListFromHTTPCall(url, addToFirestore);
  }

  Future<List<Project>> _getProjectListFromHTTPCall(
      Uri url, bool addToFirestore) async {
    http.Response? response = await fetchProject(url);
    List<Project> projectList = [];
    //if (response == null) return response;
    try {
      var jsonResponse = convert.jsonDecode(response!.body);
      var fetchedProjects =
          jsonResponse["projects"]["project"] as List<dynamic>;
      int numberProjects = fetchedProjects.length;
      for (int i = 0; i < numberProjects; i++) {
        Project project = getProjectFromGlobalGivingAPICall(
          fetchedProjects[i],
        );
        if (addToFirestore) _causesCollectionReference.add(project.toJson());
        projectList.add(project);
      }
    } catch (e) {
      log.e(
          "Could not return featured projects, failed with error: ${e.toString()}");
    }
    return projectList;
  }

  Future<http.Response?> fetchProject(dynamic url) async {
    http.Response? response;
    try {
      response = await http.get(url, headers: {'accept': 'application/json'});
    } catch (e) {
      log.e("Error when trying to fetch project data: ${e.toString()}");
    }
    return response;
  }
}
