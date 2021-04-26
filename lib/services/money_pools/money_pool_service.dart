// Service taking care of all backend functionality
// for creating, deleting, disbursing, ... money pools
// Some of this will call cloud functions!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/subjects.dart';

class MoneyPoolService {
  final CollectionReference _moneyPoolsCollectionReference =
      FirebaseFirestore.instance.collection("moneypools");

  final String contributingUsersKey = "contributingUsers";
  final String invitedUsersKey = "invitedUsers";
  final Query _invitedUsersCollectionGroup =
      FirebaseFirestore.instance.collectionGroup("invitedUsers");
  final Query _contributingUsersCollectionGroup =
      FirebaseFirestore.instance.collectionGroup("contributingUsers");
  final log = getLogger("money_pool_service.dart");

  List<MoneyPoolModel> moneyPools = [];
  List<MoneyPoolModel> moneyPoolsInvitedTo = [];
  BehaviorSubject<int> numberInvitedMoneyPoolsSubject =
      BehaviorSubject<int>.seeded(0);

  Future init(String uid) async {
    // This function is called in startup logic viewmodel
    loadMoneyPoolsInvitedTo(uid);
  }

  Future loadMoneyPoolsInvitedTo(String uid) async {
    // collection group query to search for money pools the user has been invited to
    QuerySnapshot snapshot =
        await _invitedUsersCollectionGroup.where("uid", isEqualTo: uid).get();

    // Get money pool data for each invited one!
    moneyPoolsInvitedTo = await Future.wait(snapshot.docs.map((element) async {
      DocumentReference? moneyPoolDocRef = element.reference.parent.parent;
      if (moneyPoolDocRef == null) {
        log.e(
            "Something went severely wrong, did your Firestore collection setup change?");
        return MoneyPoolModel.empty();
      } else {
        DocumentSnapshot? docSnapshot = await moneyPoolDocRef.get();
        if (docSnapshot.data() != null) {
          try {
            MoneyPoolModel moneyPool =
                MoneyPoolModel.fromJson(docSnapshot.data()!);
            log.i(
                "User has been invited to money pool with name ${moneyPool.name}");
            return moneyPool;
          } catch (e) {
            log.e(
                "Could not load data into MoneyPoolModel due to error: ${e.toString()}");
            rethrow;
          }
        } else {
          log.e(
              "Somehow no data was found in money pool document snapshot. This is very unexpected and needs fixed!");
          return MoneyPoolModel.empty();
        }
      }
    }).toList());
    _updateNumberInvitedMoneyPools(moneyPoolsInvitedTo.length);
    log.i(
        "Found ${moneyPoolsInvitedTo.length} money pools the user is invited to");
  }

  void _updateNumberInvitedMoneyPools(int number) {
    numberInvitedMoneyPoolsSubject.add(number);
  }

// (snapshot.docs.isNotEmpty) {
//       try {
//         returnList.addAll(snapshot.docs
//             .map((s) => MoneyPoolModel.fromJson(s.data()))
//             .toList());
//       } catch (e) {
//         log.e(
//             "For an unknown reason, couldn't fetch existing money pools, error: ${e.toString()}");
//         rethrow;
//       }

  Future loadMoneyPools(String uid, [bool force = false]) async {
    if (moneyPools.isEmpty || force) {
      moneyPools = await fetchMoneyPools(uid);
    }
  }

  Future<List<PublicUserInfo>> getInvitedUsers(String mpid) async {
    QuerySnapshot snapshot = await _moneyPoolsCollectionReference
        .doc(mpid)
        .collection(invitedUsersKey)
        .get();
    var returnList =
        snapshot.docs.map((s) => PublicUserInfo.fromJson(s.data())).toList();
    log.i("Fetched ${returnList.length} invited users");
    return returnList;
  }

  Future<List<ContributingUser>> getContributingUsers(String mpid) async {
    QuerySnapshot snapshot = await _moneyPoolsCollectionReference
        .doc(mpid)
        .collection(contributingUsersKey)
        .get();
    var returnList =
        snapshot.docs.map((s) => ContributingUser.fromJson(s.data())).toList();
    log.i("Fetched ${returnList.length} contributing users");
    return returnList;
  }

  Future addInviteUserDocument(String mpid, PublicUserInfo userInfo) async {
    await _moneyPoolsCollectionReference
        .doc(mpid)
        .collection(invitedUsersKey)
        .doc(userInfo.uid)
        .set(userInfo.toJson());
    log.i(
        "Added document to invitedUsers collection with info ${userInfo.toJson()}");
  }

  Future addContributingUserDocument(
      String mpid, ContributingUser userInfo) async {
    await _moneyPoolsCollectionReference
        .doc(mpid)
        .collection(contributingUsersKey)
        .doc(userInfo.uid)
        .set(userInfo.toJson());
    log.i(
        "Added document to contributingUsers collection with info ${userInfo.toJson()}");
  }

  Future createMoneyPool(
      MoneyPoolModel moneyPool, String uid, String name) async {
    // probably we want to call a cloud function instead
    log.i("Creating money pool: ${moneyPool.toJson()}");
    try {
      DocumentReference docRef = _moneyPoolsCollectionReference.doc();
      moneyPool.moneyPoolId = docRef.id;
      await docRef.set(moneyPool.toJson());
      await docRef
          .collection(contributingUsersKey)
          .add(ContributingUser(uid: uid, name: name).toJson());
      // update local money pool list
      moneyPools.add(moneyPool);
    } catch (e) {
      log.e("Could not create document, exiting with error ${e.toString()}");
      rethrow;
    }
  }

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

  Future deleteMoneyPool(String moneyPoolId) async {
    // probably we want to call a cloud function instead
    log.i("Deleting money pool with id: $moneyPoolId");
    // need to delete subcollections first
    await _moneyPoolsCollectionReference
        .doc(moneyPoolId)
        .collection(contributingUsersKey)
        .get()
        .then(
      (snp) {
        for (DocumentSnapshot ds in snp.docs) ds.reference.delete();
      },
    );
    await _moneyPoolsCollectionReference
        .doc(moneyPoolId)
        .collection(invitedUsersKey)
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

  Future fetchMoneyPools(String uid) async {
    // fetches existing money pools both created by the user
    // or contributed by the user by querying for contributingUsers
    // collection in a collectionGroup query.

    List<MoneyPoolModel>? returnList = <MoneyPoolModel>[];

    // collection group query to search for money pools the user contributes to
    QuerySnapshot snapshot2 = await _contributingUsersCollectionGroup
        .where("uid", isEqualTo: uid)
        .get();

    var moneyPoolsContributingTo =
        await Future.wait(snapshot2.docs.map((element) async {
      DocumentReference? moneyPoolDocRef = element.reference.parent.parent;
      if (moneyPoolDocRef == null) {
        log.e(
            "Something went severely wrong, did your Firestore collection setup change?");
        return MoneyPoolModel.empty();
      } else {
        DocumentSnapshot? docSnapshot = await moneyPoolDocRef.get();
        if (docSnapshot.data() != null) {
          try {
            MoneyPoolModel moneyPool =
                MoneyPoolModel.fromJson(docSnapshot.data()!);
            log.i(
                "User is contributing to money pool with name ${moneyPool.name}");
            return moneyPool;
          } catch (e) {
            log.e(
                "Could not load data into MoneyPoolModel due to error: ${e.toString()}");
            rethrow;
          }
        } else {
          log.e(
              "Somehow no data was found in money pool document snapshot. This is very unexpected and needs to be fixed!");
          return MoneyPoolModel.empty();
        }
      }
    }).toList());
    log.i(
        "Found ${moneyPoolsContributingTo.length} money pools the user is contributing to");
    // TODO: probably we have to remove duplicates ?
    returnList.addAll(moneyPoolsContributingTo);

    log.i("Fetched ${returnList.length} money pools from firestore!");
    return returnList;
  }

  Future acceptInvitation(
      String uid, String name, MoneyPoolModel moneyPool) async {
    // Called when an invitation to a money view has been accepted
    // What needs to happen?
    // 1. Update Firestore:
    //    A: delete invitedUsers document
    //    B: Add contributingUsers document
    // 2. Update state:
    //    A: remove money pool from moneyPoolsInvitedTo list
    //    B: add money pool to moneyPools list

    // 1. Update Firestore
    await _moneyPoolsCollectionReference
        .doc(moneyPool.moneyPoolId)
        .collection(invitedUsersKey)
        .doc(uid)
        .delete();
    ContributingUser contributingUser = ContributingUser(name: name, uid: uid);
    await _moneyPoolsCollectionReference
        .doc(moneyPool.moneyPoolId)
        .collection(contributingUsersKey)
        .doc(uid)
        .set(contributingUser.toJson());

    // 2. Update state
    moneyPoolsInvitedTo
        .removeWhere((element) => element.moneyPoolId == moneyPool.moneyPoolId);
    _updateNumberInvitedMoneyPools(moneyPoolsInvitedTo.length);

    moneyPools.add(moneyPool);
  }

  Future declineInvitation(String uid, MoneyPoolModel moneyPool) async {
    // Called when an invitation to a money view has been accepted
    // What needs to happen?
    // 1. Update Firestore:
    //    delete invitedUsers document
    // 2. Update state:
    //    remove money pool from moneyPoolsInvitedTo list

    // 1. Update Firestore
    await _moneyPoolsCollectionReference
        .doc(moneyPool.moneyPoolId)
        .collection(invitedUsersKey)
        .doc(uid)
        .delete();

    // 2. Update state
    moneyPoolsInvitedTo
        .removeWhere((element) => element.moneyPoolId == moneyPool.moneyPoolId);
    _updateNumberInvitedMoneyPools(moneyPoolsInvitedTo.length);
  }

  void clearData() {
    moneyPools = [];
    moneyPoolsInvitedTo = [];
    log.i("Cleared lists of money pools");
  }
}
