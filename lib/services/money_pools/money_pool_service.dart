// Service taking care of all backend functionality
// for creating, deleting, disbursing, ... money pools
// Some of this will call cloud functions!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_contribution.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_payout_model.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/subjects.dart';

class MoneyPoolService {
  final CollectionReference _moneyPoolsCollectionReference =
      FirebaseFirestore.instance.collection("moneypools");
  final CollectionReference _moneyPoolPayoutsCollectionReference =
      FirebaseFirestore.instance.collection("moneyPoolPayouts");

  final String contributionsKey = "contributionsKey";
  final log = getLogger("money_pool_service.dart");

  List<MoneyPoolModel> moneyPools = [];
  List<MoneyPoolModel> moneyPoolsInvitedTo = [];
  BehaviorSubject<int> numberInvitedMoneyPoolsSubject =
      BehaviorSubject<int>.seeded(0);

  Future init(String uid) async {
    // This function is called in startup logic viewmodel
    loadMoneyPoolsInvitedTo(uid);
  }

  // updates the number of invites for notifications
  void _updateNumberInvitedMoneyPools(int number) {
    numberInvitedMoneyPoolsSubject.add(number);
  }

  // loads the money pools into an array owned and exposed by this service
  Future loadMoneyPools(String uid, [bool force = false]) async {
    if (moneyPools.isEmpty || force) {
      moneyPools = await fetchMoneyPools(uid);
    }
  }

  // Queries for invitations
  Future loadMoneyPoolsInvitedTo(String uid) async {
    List<MoneyPoolModel>? moneyPoolsInvitedToTmp = <MoneyPoolModel>[];
    QuerySnapshot snapshot = await _moneyPoolsCollectionReference
        .where("invitedUserIds", arrayContains: uid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      try {
        moneyPoolsInvitedToTmp.addAll(snapshot.docs
            .map((snapshot) => MoneyPoolModel.fromJson(snapshot.data()))
            .toList());
      } catch (e) {
        log.e(
            "Could not map firestore data into MoneyPoolInvitationModel due to error ${e.toString()}");
        rethrow;
      }
    }
    moneyPoolsInvitedTo = moneyPoolsInvitedToTmp;
    log.i(
        "Found ${moneyPoolsInvitedTo.length} money pools the user is invited to");
    _updateNumberInvitedMoneyPools(moneyPoolsInvitedTo.length);
  }

  // returns list of invited users for specific money pool
  Future<List<PublicUserInfo>> getInvitedUsers(String mpid) async {
    DocumentSnapshot snapshot =
        await _moneyPoolsCollectionReference.doc(mpid).get();
    List invitedUsers = snapshot.get("invitedUsers");
    List<PublicUserInfo> returnList =
        invitedUsers.map((s) => PublicUserInfo.fromJson(s.data())).toList();
    log.i("Fetched ${returnList.length} invited users");
    return returnList;
  }

  // Get list of contributing users for given money pool
  Future<List> getContributingUsers(String mpid) async {
    DocumentSnapshot snapshot =
        await _moneyPoolsCollectionReference.doc(mpid).get();
    List contributingUsers = [];
    try {
      List contributingUsersList = snapshot.get("contributingUsers");
      contributingUsers.addAll(contributingUsersList.map((element) {
        ContributingUser.fromJson(element);
      }).toList());
    } on StateError catch (e) {
      log.e(
          "Returning empty list, likely because array with name 'contributingUsers' could not be found in document. Error thrown: ${e.toString()}");
      return [];
    }
    log.i("Fetched ${contributingUsers.length} contributing users");
    return contributingUsers;
  }

  // Invites user by adding user info to money pool document
  // Adds to: invitedUserIds and invitedUsers (PublicFacingUserInfo)
  Future addInvitedUserToMoneyPool(
      {required PublicUserInfo userInfo,
      required MoneyPoolModel moneyPool}) async {
    // also updates local state!
    moneyPool.invitedUserIds.add(userInfo.uid);
    moneyPool.invitedUsers.add(userInfo);
    updateMoneyPool(moneyPool);
  }

  // Adds document to moneypools collection
  Future createMoneyPool(
      MoneyPoolModel moneyPool, String uid, String name) async {
    // probably we want to call a cloud function instead
    log.i("Creating money pool: ${moneyPool.toJson()}");
    try {
      DocumentReference docRef = _moneyPoolsCollectionReference.doc();
      moneyPool.moneyPoolId = docRef.id;
      await docRef.set(moneyPool.toJson());
      // update local money pool list
      moneyPools.add(moneyPool);
    } catch (e) {
      log.e("Could not create document, exiting with error ${e.toString()}");
      rethrow;
    }
  }

  // Updates money pool document
  Future updateMoneyPool(MoneyPoolModel moneyPool) async {
    // probably we want to call a cloud function instead

    log.i("Updating money pool: ${moneyPool.toJson()}");
    try {
      _moneyPoolsCollectionReference
          .doc(moneyPool.moneyPoolId)
          .update(moneyPool.toJson());
    } catch (e) {
      log.e("Failed to update money pool document with error ${e.toString()}");
      rethrow;
    }
  }

  // deletes money pool documents
  Future deleteMoneyPool(String moneyPoolId) async {
    // probably we want to call a cloud function instead
    log.i("Deleting money pool with id: $moneyPoolId");
    // need to delete subcollections first
    await _moneyPoolsCollectionReference
        .doc(moneyPoolId)
        .collection(contributionsKey)
        .get()
        .then(
      (snp) {
        for (DocumentSnapshot ds in snp.docs) ds.reference.delete();
      },
    );
    await _moneyPoolsCollectionReference.doc(moneyPoolId).delete();

    // update local state
    moneyPools.removeWhere((element) => element.moneyPoolId == moneyPoolId);
  }

  // fetches existing money pools both created by the user
  // or contributed by the user by querying for contributingUserIDs
  Future fetchMoneyPools(String uid) async {
    List<MoneyPoolModel>? moneyPoolsContributingTo = <MoneyPoolModel>[];
    QuerySnapshot snapshot = await _moneyPoolsCollectionReference
        .where("contributingUserIds", arrayContains: uid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      try {
        moneyPoolsContributingTo.addAll(snapshot.docs
            .map((snapshot) => MoneyPoolModel.fromJson(snapshot.data()))
            .toList());
      } catch (e) {
        log.e(
            "Could not map firestore data into MoneyPoolModel due to error ${e.toString()}");
        rethrow;
      }
    }
    log.i(
        "Found ${moneyPoolsContributingTo.length} money pools the user is contributing to");
    return moneyPoolsContributingTo;
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
  // 2. Update state:
  //    A: remove money pool from moneyPoolsInvitedTo list
  //    B: add money pool to moneyPools list
  Future acceptInvitation(
      String uid, String name, MoneyPoolModel moneyPool) async {
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

    // update money pool
    // This call should be made with a cloud function!
    await updateMoneyPool(moneyPool);

    // 2. Update state
    moneyPoolsInvitedTo
        .removeWhere((element) => element.moneyPoolId == moneyPool.moneyPoolId);
    _updateNumberInvitedMoneyPools(moneyPoolsInvitedTo.length);

    moneyPools.add(moneyPool);
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
  Future declineInvitation(String uid, MoneyPoolModel moneyPool) async {
    // 1. Update Firestore
    moneyPool.invitedUsers.removeWhere((element) => element.uid == uid);
    moneyPool.invitedUserIds.removeWhere((element) => element == uid);
    await updateMoneyPool(moneyPool);

    // 2. Update state
    moneyPoolsInvitedTo
        .removeWhere((element) => element.moneyPoolId == moneyPool.moneyPoolId);
    _updateNumberInvitedMoneyPools(moneyPoolsInvitedTo.length);
  }

  // Gets and returns money pool from firestore
  Future getMoneyPool(String mpid) async {
    DocumentSnapshot snapshot =
        await _moneyPoolsCollectionReference.doc(mpid).get();
    if (snapshot.data() != null) {
      return MoneyPoolModel.fromJson(snapshot.data()!);
    } else {
      log.wtf(
          "Could not find data of money pool with id $mpid, returning empty pool");
      return MoneyPoolModel.empty();
    }
  }

  // returns list of money pool contributions
  Future getMoneyPoolContributions(String mpid) async {
    List<MoneyPoolContributionModel> returnList = [];
    QuerySnapshot snapshot = await _moneyPoolsCollectionReference
        .doc(mpid)
        .collection("contributions")
        .get();
    if (snapshot.docs.isNotEmpty) {
      returnList = snapshot.docs
          .map((element) => MoneyPoolContributionModel.fromJson(element.data()))
          .toList();
    }
    log.i("Fetched ${returnList.length} money pool contributions");
    return returnList;
  }

  // adds payout data to firestore which will trigger a cloud function
  // to update all the good wallets
  Future submitMoneyPoolPayout(MoneyPoolPayoutModel data) async {
    try {
      DocumentReference docRef = _moneyPoolPayoutsCollectionReference.doc();
      final newData = data.copyWith(payoutId: docRef.id);
      await docRef.set(newData.toJson());
    } catch (e) {
      log.e("Error when pushing data to firestore: ${e.toString()}");
      rethrow;
    }
  }

  void clearData() {
    moneyPools = [];
    moneyPoolsInvitedTo = [];
    log.i("Cleared lists of money pools");
  }
}
