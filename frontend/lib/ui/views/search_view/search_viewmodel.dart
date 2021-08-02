import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/social_functions_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends SocialFunctionsViewModel {
  List<PublicUserInfo> userInfoList = [];

  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final NavigationService? _navigationService = locator<NavigationService>();
  final log = getLogger("search_viewmodel.dart");

  void selectUserAndProceed(int index, SearchType searchType) {
    final uid = userInfoList[index].uid;
    log.i("Selected user with id = $uid");
    if (searchType == SearchType.UserToTransferTo) {
      navigateToTransferView(uid, index);
      log.i("Navigate to transferFundsAmountView");
    } else if (searchType == SearchType.UserToInviteToMP) {
      log.i("Navigate back");
      // TODO: invite user! We pop screen and handle the rest in single_money_pool_viewmodel!
      _navigationService!.back(result: userInfoList[index]);
    } else if (searchType == SearchType.Explore ||
        searchType == SearchType.FindFriends) {
      log.i("Navigate to public profile view");
      navigateToPublicProfileView(uid);
    }
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

  Future onSelected(Map<String, dynamic> map) async {
    if (map.containsKey("uid")) {
      navigateToPublicProfileView(map["uid"]);
    }
  }

  /////////////////////////////////////////////////
  /// Navigation

  void navigateToScanQRCodeView() {
    _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 0));
  }

  void navigateToProfileView() {
    _navigationService!.navigateTo(Routes.publicProfileViewMobile,
        arguments: PublicProfileViewMobileArguments(uid: currentUser.uid));
  }

  Future navigateToTransferView(String uid, int index) async {
    _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.Bank),
            type: TransferType.User2UserSent,
            recipientInfo: RecipientInfo.user(
                name: userInfoList[index].name, id: userInfoList[index].uid)));
  }
}
