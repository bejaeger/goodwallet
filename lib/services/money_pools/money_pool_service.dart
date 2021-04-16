// Service taking care of all backend functionality
// for creating, deleting, disbursing, ... money pools
// Some of this will call cloud functions!
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class MoneyPoolService {
  final CollectionReference _moneyPoolsCollectionReference =
      FirebaseFirestore.instance.collection("moneypools");
  final log = getLogger("money_pool_service.dart");

  List<MoneyPoolModel> _moneyPools = [];

  Future getMoneyPools(String uid, [bool force = false]) async {
    if (_moneyPools.isEmpty || force) {
      _moneyPools = await fetchMoneyPools(uid);
    }
    return _moneyPools;
  }

  // Future pushMoneyPool(MoneyPoolModel moneyPool) async {
  //   if (moneyPool.moneyPoolId == null) {
  //     DocumentReference docRef = _moneyPoolsCollectionReference.doc();
  //     moneyPool.moneyPoolId = docRef.id;
  //     await docRef.set(moneyPool.toJson());
  //   } else {
  //     _moneyPoolsCollectionReference
  //         .doc(moneyPool.moneyPoolId)
  //         .set(moneyPool.toJson());
  //   }
  // }

  Future createMoneyPool(MoneyPoolModel moneyPool) async {
    // probably we want to call a cloud function instead
    log.i("Creating money pool: ${moneyPool.toJson()}");
    //pushMoneyPool(moneyPool);
    //
    try {
      DocumentReference docRef = _moneyPoolsCollectionReference.doc();
      moneyPool.moneyPoolId = docRef.id;
      await docRef.set(moneyPool.toJson());
    } catch (e) {
      log.e("Could not create document");
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
      log.e("Failed to update money pool document");
      rethrow;
    }
  }

  Future deleteMoneyPool(String moneyPoolId) async {
    // probably we want to call a cloud function instead
    log.i("Deleting money pool with id: $moneyPoolId");
    await _moneyPoolsCollectionReference.doc(moneyPoolId).delete();
  }

  Future fetchMoneyPools(String uid) async {
    // fetches existing money pools both created by the user
    // or contributed by the user with user id uid

    List<MoneyPoolModel>? returnList = <MoneyPoolModel>[];
    QuerySnapshot snapshot = await _moneyPoolsCollectionReference
        .where("adminUID", isEqualTo: uid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      try {
        returnList.addAll(snapshot.docs
            .map((s) => MoneyPoolModel.fromJson(s.data()))
            .toList());
      } catch (e) {
        log.e("For an unknown reason, couldn't fetch existing money pools");
        rethrow;
      }
    } else {
      log.e(
          "Snapshot of money pools is empty, user has no current money pools active");
    }
    log.i("Fetched ${returnList.length} money pools from firestore!");
    return returnList;
  }
}
