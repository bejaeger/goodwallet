// Service taking care of all backend functionality
// for creating, deleting, disbursing, ... money pools
// Some of this will call cloud functions!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/base/concise_money_pool_info.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/money_pools/users/contributing_user.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/subjects.dart';

class MoneyPoolService {
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
  List<MoneyPool> moneyPoolsInvitedTo = [];
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
    List<MoneyPool>? moneyPoolsInvitedToTmp = <MoneyPool>[];
    QuerySnapshot snapshot = await _moneyPoolsCollectionReference
        .where("invitedUserIds", arrayContains: uid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      try {
        moneyPoolsInvitedToTmp.addAll(snapshot.docs
            .map((snapshot) => MoneyPool.fromJson(snapshot.data()))
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
      {required PublicUserInfo userInfo, required MoneyPool moneyPool}) async {
    // also updates local state!
    moneyPool.invitedUserIds.add(userInfo.uid);
    moneyPool.invitedUsers.add(userInfo);
    updateMoneyPool(moneyPool);
  }

  // Adds document to moneypools collection
  Future<MoneyPool> createAndReturnMoneyPool(
      MoneyPool moneyPool, String uid, String name) async {
    // probably we want to call a cloud function instead
    try {
      DocumentReference docRef = _moneyPoolsCollectionReference.doc();
      var newMoneyPool = moneyPool.copyWith(moneyPoolId: docRef.id);
      await docRef.set(newMoneyPool.toJson());
      // update local money pool list
      moneyPools.add(newMoneyPool);
      log.i("Created money pool: ${newMoneyPool.toJson()}");
      return newMoneyPool;
    } catch (e) {
      log.e("Could not create money pool, error thrown: ${e.toString()}");
      rethrow;
    }
  }

  // Updates money pool document
  Future updateMoneyPool(MoneyPool moneyPool) async {
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
    List<MoneyPool>? moneyPoolsContributingTo = <MoneyPool>[];
    QuerySnapshot snapshot = await _moneyPoolsCollectionReference
        .where("contributingUserIds", arrayContains: uid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      try {
        moneyPoolsContributingTo.addAll(snapshot.docs
            .map((snapshot) => MoneyPool.fromJson(snapshot.data()))
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
  Future declineInvitation(String uid, MoneyPool moneyPool) async {
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
      return MoneyPool.fromJson(snapshot.data()!);
    } else {
      log.wtf(
          "Could not find data of money pool with id $mpid, returning null empty pool");
      return null;
    }
  }

  // returns list of user money pool contributions
  Future<List<MoneyTransfer>> getMoneyPoolContributions(String mpid) async {
    List<MoneyTransfer> returnList = [];
    QuerySnapshot snapshot = await _paymentsCollectionReference
        .where("moneyPoolInfo.moneyPoolId", isEqualTo: mpid)
        .where("type", isEqualTo: "MoneyPoolContribution")
        .get();
    if (snapshot.docs.isNotEmpty) {
      returnList = snapshot.docs
          .map((element) => MoneyTransfer.fromJson(element.data()))
          .toList();
    }
    log.i("Fetched ${returnList.length} money pool contributions");
    return returnList;
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
              moneyPoolInfo:
                  ConciseMoneyPoolInfo.fromJson(data.moneyPool.toJson()),
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
    log.i("Cleared lists of money pools");
  }
}
