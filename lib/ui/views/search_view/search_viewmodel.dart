import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
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
    if (searchType == SearchType.UserToTransferTo) {
      _navigationService!.replaceWith(Routes.transferFundsAmountView,
          arguments: TransferFundsAmountViewArguments(
              senderInfo: SenderInfo(moneySource: MoneySource.Bank),
              type: TransferType.User2UserSent,
              recipientInfo: RecipientInfo.user(
                  name: userInfoList[index].name,
                  id: userInfoList[index].uid)));
    } else if (searchType == SearchType.UserToInviteToMP) {
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
          name: doc.get("fullName"),
          uid: doc.get("uid"),
          email: doc.get("email"));
    }).toList();
    log.i("Queried users and found ${userInfoList.length} matches");
    notifyListeners();
  }

  void navigateToScanQRCodeView() {
    _navigationService!.replaceWith(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 0));
  }
}
