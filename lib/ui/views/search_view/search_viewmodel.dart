import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends BaseModel {
  List<PublicUserInfo> userInfoList = [];

  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final NavigationService? _navigationService = locator<NavigationService>();

  final log = getLogger("search_viewmodel.dart");

  void selectUser(int index, SearchType searchType) {
    if (searchType == SearchType.userToTransferTo) {
      _navigationService!.replaceWith(Routes.transferFundsAmountView,
          arguments: TransferFundsAmountViewArguments(
              type: FundTransferType.transferToPeer,
              receiverInfo: userInfoList[index]));
    } else if (searchType == SearchType.userToInviteToMP) {
      // TODO: invite user! We pop screen and handle the rest in single_money_pool_viewmodel!
      _navigationService!.back(result: userInfoList[index]);
    }
    // _navigationService!.replaceWith(Routes.sendMoneyViewMobile,
    //     arguments: SendMoneyViewMobileArguments(userInfo: userInfoList[index]));
  }

  Future queryUsers(String query) async {
    QuerySnapshot foundUsers = await _usersCollectionReference
        .where("searchKeywords", arrayContains: query.toLowerCase())
        .get();
    userInfoList = foundUsers.docs.map((DocumentSnapshot doc) {
      return PublicUserInfo(
          name: doc.get("fullName") as String,
          email: doc.get("email") as String,
          uid: doc.get("id") as String);
    }).toList();

    log.i("Queried users and found ${userInfoList.length} matches");
    notifyListeners();
  }

  void navigateToScanQRCodeView() {
    _navigationService!.replaceWith(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 0));
  }
}
