import 'package:good_wallet/datamodels/goodcauses/global_giving_project_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

// For info on json parsing see
// @see https://dart.dev/tutorials/web/fetch-data

class GlobalGivingAPIService {
  Future getRandomProject() async {
    // test request for specific project
    String url =
        "https://api.globalgiving.org/api/public/projectservice/projects/14516?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b";
    // all projects (returns 10)
    url =
        "https://api.globalgiving.org/api/public/projectservice/all/projects/active?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b&nextProjectId=14516";
    // featured projects (returns 10)
    url =
        "https://api.globalgiving.org/api/public/projectservice/featured/projects?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b";
    http.Response response = await fetchProject(url);
    try {
      var jsonResponse = convert.jsonDecode(response.body);
      var fetchedProjects =
          jsonResponse["projects"]["project"] as List<dynamic>;
      int numberProjects = fetchedProjects.length - 1;
      Random random = new Random();
      int randomProjectNumber =
          random.nextInt(numberProjects); // seems limitted
      var jsonProject = fetchedProjects[randomProjectNumber];
      GlobalGivingProjectModel project =
          GlobalGivingProjectModel.readJsonProject(jsonProject);
      return project;
      //return project;
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  Future getFeaturedProjects() async {
    // test request for specific project
    Uri url = Uri.http("api.globalgiving.org",
        "/api/public/projectservice/featured/projects?api_key=578f2d27-8c47-4456-9d57-3bb0cb3f883b");
    //{"api_key": "578f2d27-8c47-4456-9d57-3bb0cb3f883b"});
    http.Response response = await fetchProject(url);
    try {
      var jsonResponse = convert.jsonDecode(response.body);
      var fetchedProjects =
          jsonResponse["projects"]["project"] as List<dynamic>;
      int numberProjects = fetchedProjects.length - 1;

      List<GlobalGivingProjectModel> projectList;
      for (int i = 0; i < numberProjects; i++) {
        GlobalGivingProjectModel project =
            GlobalGivingProjectModel.readJsonProject(fetchedProjects[i]);
        projectList.add(project);
      }
      return projectList;
      //return project;
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  Future<http.Response> fetchProject(dynamic url) async {
    http.Response response;
    try {
      response = await http.get(url, headers: {'accept': 'application/json'});
    } catch (e) {
      print("Error when trying to fetch project data: ${e.toString()}");
    }
    return response;
  }
}
