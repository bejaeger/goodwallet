// Service taking care of all backend functionality
// for creating, deleting, disbursing, ... money pools
// Some of this will call cloud functions!

import 'dart:async';

import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/constants/constants.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/messages/message.dart';
import 'package:good_wallet/datamodels/money_pools/users/contributing_user.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/subjects.dart';

class MoneyPoolsService {
  final _firestoreApi = locator<FirestoreApi>();

  final log = getLogger("money_pool_service.dart");

  // map of list of money pools with money Pool id as key
  List<MoneyPool> moneyPools = [];
  StreamSubscription? _moneyPoolsStreamSubscription;

  List<MoneyPool> moneyPoolsInvitedTo = [];
  StreamSubscription? _moneyPoolsInvitedToStreamSubscription;
  BehaviorSubject<int> numberInvitedMoneyPoolsSubject =
      BehaviorSubject<int>.seeded(0);

  // list of money pool payouts and their subscriptions
  // String will become the money pool id
  Map<String, List<Message>> moneyPoolMessages = {};
  Map<String, StreamSubscription?> _moneyPoolMessagesStreamSubscriptions = {};

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
    await _firestoreApi.updateMoneyPool(moneyPool);
  }

  // adds listener to money pools the user is contributing to
  // allows to wait for the first emission of the stream via the completer
  Future<void>? listenToMoneyPools({required String uid}) async {
    if (_moneyPoolsStreamSubscription == null) {
      var completer = Completer<void>();
      _moneyPoolsStreamSubscription =
          _firestoreApi.getMoneyPoolsStream(uid: uid).listen((snapshot) {
        moneyPools = snapshot;
        if (!completer.isCompleted) {
          completer.complete();
        }
        log.v("Listened to ${moneyPools.length} moneyPools");
      });
      return completer.future;
    } else {
      log.w(
          "Already listening to list of Money pools, not adding another listener");
    }
  }

  Stream<MoneyPool> getMoneyPoolStream({required String mpid}) {
    return _firestoreApi.getMoneyPoolStream(mpid: mpid);
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
  // 2. listeners will update the local state
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

  void clearData() {
    moneyPools = [];
    moneyPoolsInvitedTo = [];
    _moneyPoolsStreamSubscription?.cancel();
    _moneyPoolsStreamSubscription = null;

    _moneyPoolsInvitedToStreamSubscription?.cancel();
    _moneyPoolsInvitedToStreamSubscription = null;

    log.i("Cleared lists of money pools");
  }

  ////////////////////////////////////////////////////////////
  // Message board

  Future addMessageToMoneyPool(
      {required String mpid, required Message message}) async {
    try {
      await _firestoreApi.addMessageToMoneyPool(mpid: mpid, message: message);
    } catch (e) {
      rethrow;
    }
  }

  // adds listener to money pool message collection
  // allows to wait for the first emission of the stream via the completer
  void addMoneyPoolMessagesListener(
      {required String mpid,
      required Completer<void> completer,
      void Function()? callback}) {
    if (_moneyPoolMessagesStreamSubscriptions[mpid] == null) {
      final snapshot = _firestoreApi.getMoneyPoolMessagesStream(mpid: mpid);
      //var completer = Completer<void>();
      _moneyPoolMessagesStreamSubscriptions[mpid] = snapshot.listen((snapshot) {
        snapshot.sort((a, b) {
          if (b.createdAt != null && a.createdAt != null) {
            return b.createdAt.compareTo(a.createdAt);
          } else {
            return 0;
          }
        });
        moneyPoolMessages[mpid] = snapshot;
        if (!completer.isCompleted) {
          completer.complete();
        }
        if (callback != null) callback();
        log.v(
            "Listened to ${moneyPoolMessages[mpid]!.length} moneyPoolMessages");
      });
      //return completer.future;
    } else {
      log.w(
          "Money pool payout stream already listened to, not adding another listener");
      completer.complete();
    }
  }

  // Get transfers for config. Using this function makes only sense
  // if a listener has been added with addTransferDataListener, seebe low
  List<Message> getMoneyPoolMessages({required String mpid}) {
    if (!moneyPoolMessages.containsKey(mpid)) {
      log.w(
          "Did not find any messages for money pool with id $mpid. If you expect any messsages you probably forgot to add a listener with 'addMoneyPoolMessagesListener()'. Returning empty list");
      return [];
    } else {
      return moneyPoolMessages[mpid]!;
    }
  }

  // pause the listener
  void cancelMoneyPoolMessageListener({required String mpid}) {
    log.v("Pause transfer data listener with config: '$mpid'");
    _moneyPoolMessagesStreamSubscriptions[mpid]?.cancel();
    _moneyPoolMessagesStreamSubscriptions[mpid] = null;
  }
}
