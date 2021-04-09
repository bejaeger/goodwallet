import 'package:good_wallet/utils/datamodel_helpers.dart';

// PODO for a good cause defined by our organization

class GoodWalletFundModel {
  String? title;
  String? description;
  String? imagePath;

  GoodWalletFundModel({
    this.title,
    this.description,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    var returnJson = {
      'title': title,
      'description': description,
      'imagePath': imagePath,
    };
    return returnJson;
  }

  static GoodWalletFundModel fromMap(Map<String, dynamic> map) {
    var data = GoodWalletFundModel(
      title: map["title"],
      description: map["description"],
      imagePath: map["imagePath"],
    );
    return data;
  }
}
