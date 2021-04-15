// Created with  @https://javiercbk.github.io/json_to_dart/
// from json
//
// {
//     "name": "name",
//     "description": "description",
//     "adminUID": "uid",
//     "adminName": "adminName",
//     "showTotalAmount": "False",
//     "invitedUsers": [
//         {
//             "uid": "uid",
//             "name": "name"
//         },
//         {
//             "uid": "uid",
//             "name": "name"
//         }
//     ],
//     "contributingUsers": [
//         {
//             "uid": "uid",
//             "name": "name"
//         },
//         {
//             "uid": "uid",
//             "name": "name"
//         }
//     ]
// }
//

class MoneyPoolModel {
  String name;
  String adminUID;
  String adminName;
  double total;
  String? description;
  bool showTotalAmount;
  List<ContributingUser>? invitedUsers;
  List<ContributingUser>? contributingUsers;

  MoneyPoolModel.empty()
      : this.name = "",
        this.adminUID = "",
        this.adminName = "",
        this.total = -1.0,
        this.description = "",
        this.showTotalAmount = false,
        this.invitedUsers = [],
        this.contributingUsers = [];

  MoneyPoolModel(
      {required this.name,
      required this.adminName,
      required this.adminUID,
      this.total = 0,
      this.description,
      this.showTotalAmount = true,
      this.invitedUsers,
      this.contributingUsers});

  MoneyPoolModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        adminUID = json['adminUID'],
        adminName = json['adminName'],
        showTotalAmount = json['showTotalAmount'],
        total = json['total'] {
    description = json['description'];
    if (json['invitedUsers'] != null) {
      invitedUsers = [];
      json['invitedUsers'].forEach((v) {
        invitedUsers!.add(ContributingUser.fromJson(v));
      });
    }
    if (json['contributingUsers'] != null) {
      contributingUsers = [];
      json['contributingUsers'].forEach(
        (v) {
          contributingUsers!.add(new ContributingUser.fromJson(v));
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['adminUID'] = this.adminUID;
    data['adminName'] = this.adminName;
    data['total'] = this.total;
    data['showTotalAmount'] = this.showTotalAmount;
    if (this.invitedUsers != null) {
      data['invitedUsers'] = this.invitedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.contributingUsers != null) {
      data['contributingUsers'] =
          this.contributingUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContributingUser {
  String uid;
  String name;

  ContributingUser({required this.uid, required this.name});

  ContributingUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    return data;
  }
}
