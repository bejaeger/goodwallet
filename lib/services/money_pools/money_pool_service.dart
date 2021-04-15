// Service taking care of all backend functionality
// for creating, deleting, disbursing, ... money pools
// Some of this will call cloud functions!
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/utils/logger.dart';

class MoneyPoolService {
  final CollectionReference _moneyPoolsCollectionReference =
      FirebaseFirestore.instance.collection("moneypools");

  final log = getLogger("money_pool_service.dart");

  List<MoneyPoolModel> _moneyPools = [];

  Future getMoneyPools(String uid, [bool force = false]) async {
    if (_moneyPools.isEmpty || force) {
      _moneyPools = await fetchMoneyPools(uid);
      // add an empty money pool which trigger displaying a CTA to create a new money pool
      // this is rather hacky!
      _moneyPools.add(MoneyPoolModel.empty());
    }
    return _moneyPools;
  }

  Future createMoneyPool(MoneyPoolModel moneyPool) async {
    // probably we want to call a cloud function instead
    log.i("Creating money pool: ${moneyPool.toJson()}");
    await _moneyPoolsCollectionReference.add(moneyPool.toJson());
  }

  Future updateMoneyPool(MoneyPoolModel moneyPool) async {
    // probably we want to call a cloud function instead
    log.i("Updating money pool: ${moneyPool.toJson()}");
    await _moneyPoolsCollectionReference.add(moneyPool.toJson());
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
