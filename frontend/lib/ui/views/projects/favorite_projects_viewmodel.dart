import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/ui/views/common_viewmodels/projects_base_viewmodel.dart';

class FavoriteProjectsViewModel extends ProjectsBaseViewModel {
  List<Project> get projects => getFavoriteProjects();

  Future refresh() async {
    notifyListeners();
  }
}
