// Service taking care of all backend functionality
// for creating, deleting, disbursing, ... money pools
// Some of this will call cloud functions!

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/base/concise_money_pool_info.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/money_pools/users/contributing_user.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/subjects.dart';

class MoneyPoolsService {
  final _firestoreApi = locator<FirestoreApi>();

  final CollectionReference _moneyPoolsCollectionReference =
      FirebaseFirestore.instance.collection("moneypools");
  final CollectionReference _moneyPoolPayoutsCollectionReference =
      FirebaseFirestore.instance.collection("moneyPoolPayouts");
  final CollectionReference _paymentsCollectionReference =
      FirebaseFirestore.instance.collection("payments");

  // will also enable collection group queries for this collection
  final String contributionsKey = "moneyPoolContributions";
  final log = getLogger("money_pool_service.dart");

  List<MoneyPool> moneyPools = [];
  StreamSubscription? _moneyPoolsStreamSubscription;

  List<MoneyPool> moneyPoolsInvitedTo = [];
  StreamSubscription? _moneyPoolsInvitedToStreamSubscription;
  BehaviorSubject<int> numberInvitedMoneyPoolsSubject =
      BehaviorSubject<int>.seeded(0);

  void init({required String uid}) {
    // This function is called in startup logic viewmodel
    listenToMoneyPoolsInvitedTo(uid: uid);
  }

  // updates the number of invites for notifications
  void _updateNumberInvitedMoneyPools() {
    numberInvitedMoneyPoolsSubject.add(moneyPoolsInvitedTo.length);
  }

  // Queries for invitations
  Future listenToMoneyPoolsInvitedTo({required String uid}) async {
    if (_moneyPoolsInvitedToStreamSubscription == null) {
      _moneyPoolsInvitedToStreamSubscription = _firestoreApi
          .getMoneyPoolsInvitedToStream(uid: uid)
          .listen((moneyPools) {
        moneyPoolsInvitedTo = moneyPools;
        _updateNumberInvitedMoneyPools();
      });
    } else {
      log.w("Money pools invited to already listened to");
    }
    log.i(
        "Found ${moneyPoolsInvitedTo.length} money pools the user is invited to");
  }

  // Invites user by adding user info to money pool document
  // Adds to: invitedUserIds and invitedUsers (PublicFacingUserInfo)
  Future addInvitedUserToMoneyPool(
      {required PublicUserInfo userInfo, required MoneyPool moneyPool}) async {
    // also updates local state!
    moneyPool.invitedUserIds.add(userInfo.uid);
    moneyPool.invitedUsers.add(userInfo);
    _firestoreApi.updateMoneyPool(moneyPool);
  }

  // adds listener to money pools the user is contributing to
  // allows to wait for the first emission of the stream via the completer
  Future<void> listenToMoneyPools({required String uid}) async {
    var completer = Completer<void>();
    if (_moneyPoolsStreamSubscription == null) {
      _moneyPoolsStreamSubscription =
          _firestoreApi.getMoneyPoolsStream(uid: uid).listen((snapshot) {
        moneyPools = snapshot;
        if (!completer.isCompleted) {
          completer.complete();
        }
        log.v("Listened to ${moneyPools.length} moneyPools");
      });
    } else {
      log.w(
          "Money pool stream already listened to, not adding another listener");
    }
    return completer.future;
  }

  Future<MoneyPool> createAndReturnMoneyPool({required MoneyPool moneyPool}) {
    return _firestoreApi.createAndReturnMoneyPool(moneyPool: moneyPool);
  }

  ////////////////////////////////////////////////////////
  //
  // Called when an invitation to a money view has been accepted.
  // Updates documents to handle acceptance of invitation.
  //
  // What needs to happen?
  // 1. Update Firestore:
  //    A: remove invited user form list in money pool main document
  //    B: Add new contributingUsers to array in main document
  //       (eventually needs to happen in cloud function for security reasons!)
  // 2. Listeners will update the local state
  Future acceptInvitation(String uid, String name, MoneyPool moneyPool) async {
    // 1. Update Firestore
    //
    // A. remove invited user from lists
    moneyPool.invitedUsers.removeWhere((element) => element.uid == uid);
    moneyPool.invitedUserIds.removeWhere((element) => element == uid);

    // B. add contributing user to list
    ContributingUser newContributingUser =
        ContributingUser(name: name, uid: uid);
    moneyPool.contributingUsers.add(newContributingUser);
    moneyPool.contributingUserIds.add(uid);

    // TODO: Add cloud function for this update
    // update money pool
    // This call should be made with a cloud function!
    await _firestoreApi.updateMoneyPool(moneyPool);

    return true;
  }

  //////////////////////////////////////////////////////////////////
  // Called when an invitation to a money view has been accepted
  // Updates documents to handle decline of invitation
  //
  // What needs to happen?
  // 1. Update Firestore:
  //    remove invited User from lists in main document
  // 2. Update state:
  //    remove money pool from moneyPoolsInvitedTo list
  Future declineInvitation(String uid, MoneyPool moneyPool) async {
    // 1. Update Firestore
    moneyPool.invitedUsers.removeWhere((element) => element.uid == uid);
    moneyPool.invitedUserIds.removeWhere((element) => element == uid);
    await _firestoreApi.updateMoneyPool(moneyPool);
  }

  // Gets and returns money pool from firestore
  Future getMoneyPool(String mpid) async {
    return _firestoreApi.getMoneyPool(mpid);
  }

  // Gets and returns money pool from firestore
  Future deleteMoneyPool(String mpid) async {
    await _firestoreApi.deleteMoneyPool(mpid);
  }

  // returns list of money pool payouts
  // likely there will be none or little because
  // probably usually the money pool is deleted after disbursement
  Future<List<MoneyPoolPayout>> getMoneyPoolPayouts(String mpid) async {
    List<MoneyPoolPayout> returnList = [];
    QuerySnapshot snapshot = await _moneyPoolPayoutsCollectionReference
        .where("moneyPool.moneyPoolId", isEqualTo: mpid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      returnList = snapshot.docs
          .map((element) => MoneyPoolPayout.fromJson(element.data()))
          .toList();
    }
    log.i("Fetched ${returnList.length} money pool payout documents");
    return returnList;
  }

  // adds payout data to firestore which will trigger a cloud function
  // to update all the good wallets
  // Additionally add money transfer document to payment collection
  // mainly for "read" purposes!
  Future submitMoneyPoolPayout(MoneyPoolPayout data) async {
    try {
      DocumentReference docRef = _moneyPoolPayoutsCollectionReference.doc();
      var newData = data.copyWith(payoutId: docRef.id);
      await docRef.set(newData.toJson());

      // Push each money pool payout transfer to payments collection
      List<MoneyTransfer> moneyTransfers = [];
      data.transfersDetails.forEach((element) {
        moneyTransfers.add(
          MoneyTransfer.moneyPoolPayoutTransfer(
              transferDetails: element,
              moneyPoolInfo: ConciseMoneyPoolInfo(
                  moneyPoolId: data.moneyPool.moneyPoolId,
                  name: data.moneyPool.name,
                  total: data.moneyPool.total),
              payoutId: docRef.id,
              createdAt: FieldValue.serverTimestamp()),
        );
      });
      moneyTransfers.forEach((element) {
        DocumentReference docRef = _paymentsCollectionReference.doc();
        var newElement = element.copyWith(transferId: docRef.id);
        docRef.set(newElement.toJson());
      });
    } catch (e) {
      log.e("Error when pushing data to firestore: ${e.toString()}");
      rethrow;
    }
  }

  void clearData() {
    moneyPools = [];
    moneyPoolsInvitedTo = [];
    _moneyPoolsStreamSubscription?.cancel();
    _moneyPoolsStreamSubscription = null;
    _moneyPoolsInvitedToStreamSubscription?.cancel();
    _moneyPoolsInvitedToStreamSubscription = null;
    log.i("Cleared lists of money pools");
  }
}
