import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/goodcauses/global_giving_project_model.dart';
import 'package:good_wallet/datamodels/goodcauses/good_wallet_project_model.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/ui/views/base_viewmodel.dart';

class CausesViewModel extends BaseModel {
  List<GoodWalletProjectModel> projects;

  final _globalGivingAPIservice = locator<GlobalGivingAPIService>();

  Future fetchProjects() async {
    projects = await _globalGivingAPIservice.getFeaturedProjects();
    notifyListeners();
  }
}
