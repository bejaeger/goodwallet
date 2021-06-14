import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/datamodels/money_pools/base/concise_money_pool_info.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/datamodels/user/user_settings.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreApi {
  final log = getLogger('FirestoreApi');

  // The following defines the Firestore collection setup!
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final String userStatisticsCollectionKey = "statistics";
  final String userSummaryStatisticsDocumentKey = "summaryStats";
  final CollectionReference _paymentsCollection =
      FirebaseFirestore.instance.collection('transfers');
  final CollectionReference _moneyPoolPayoutsCollection =
      FirebaseFirestore.instance.collection("moneyPoolPayouts");
  final CollectionReference _moneyPoolsCollection =
      FirebaseFirestore.instance.collection('moneyPools');
  final CollectionReference _projectsCollection =
      FirebaseFirestore.instance.collection('projects');

  ////////////////////////////////////////////////////////
  // Create user documents

  Future<void> createUser(
      {required User user, required UserStatistics stats}) async {
    try {
      await createUserInfo(user: user);
      await createUserStatistics(uid: user.uid, stats: stats);
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new user',
        devDetails: '$error',
      );
    }
  }

  Future<void> createUserInfo({required User user}) async {
    final userDocument = _usersCollection.doc(user.uid);
    await userDocument.set(user.toJson());
    log.v('User document added to ${userDocument.path}');
  }

  Future<void> createUserStatistics(
      {required String uid, required UserStatistics stats}) async {
    final docRef = getUserSummaryStatisticsDocument(uid: uid);
    await docRef.set(stats.toJson());
    log.v('Stats document added to ${docRef.path}');
  }

  ////////////////////////////////////////////////////////
  // Get user if exists

  Future<User?> getUser({required String uid}) async {
    var userData = await _usersCollection.doc(uid).get();
    if (!userData.exists) {
      log.v("User does not exist");
      return null;
    }

    if (userData.data() == null) {
      log.wtf(
          "User data document could be found but it does not have any data! Something is seriously wrong");
      throw FirestoreApiException(
        message: 'Failed to get user',
        devDetails:
            "User data document could be found but it does not have any data! Something is seriously wrong",
      );
    }

    try {
      return User.fromJson(userData.data()!);
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to get user',
        devDetails: '$error',
      );
    }
  }

  ///////////////////////////////////////////////////////
  // Get user data streams
  Stream<UserStatistics> getUserSummaryStatisticsStream({required String uid}) {
    return getUserSummaryStatisticsDocument(uid: uid).snapshots().map((event) {
      if (!event.exists || event.data() == null) {
        throw FirestoreApiException(
            message: "User statistics document not valid!",
            devDetails:
                "Something must have failed before when creating user account. This is likely due to some backwards-compatibility-breaking updates to the data models or firestore collection setup.");
      }
      return UserStatistics.fromJson(event.data()!);
    });
  }

  ///////////////////////////////////////////////////////
  /// Get Money Transfer Stream
  Stream<List<MoneyTransfer>> getTransferDataStream(
      {required MoneyTransferQueryConfig config, required String uid}) {
    Query query;
    if (config.type == TransferType.AllInvolvingUser) {
      Query outgoing = _paymentsCollection
          .where("transferDetails.senderId", isEqualTo: uid)
          .orderBy("createdAt", descending: true);
      Query incoming = _paymentsCollection
          .where("transferDetails.recipientId", isEqualTo: uid)
          .orderBy("createdAt", descending: true);
      Stream<List<MoneyTransfer>> transfersStream =
          getCombinedMoneyTransfersStream(
              outgoing: outgoing,
              incoming: incoming,
              maxNumberReturns: config.maxNumberReturns);
      return transfersStream;
    } else if (config.type == TransferType.User2User) {
      if (config.senderId != null && config.recipientId == null) {
        query = _paymentsCollection
            .where("transferDetails.senderId", isEqualTo: config.senderId!)
            // document fields are the same so the type is User2User here
            .where("type", isEqualTo: "User2User")
            .orderBy("createdAt", descending: true);
      } else if (config.senderId == null && config.recipientId != null) {
        query = _paymentsCollection
            .where("transferDetails.recipientId", isEqualTo: config.recipientId)
            // document fields are the same so the type is User2User here
            .where("type", isEqualTo: "User2User")
            .orderBy("createdAt", descending: true);
      } else {
        throw throwNotSupportedException(config);
        // Example for checking timestamp
        // .where("createdAt",
        // isGreaterThan: Timestamp.fromDate(DateTime(2021, 5, 8)));
      }
    } else if (config.type == TransferType.User2Project) {
      if (config.senderId != null) {
        query = _paymentsCollection
            .where("transferDetails.senderId", isEqualTo: config.senderId)
            .where("type", isEqualTo: "User2Project")
            .orderBy("createdAt", descending: true);
      } else {
        throw throwNotSupportedException(config);
      }
    } else if (config.type == TransferType.MoneyPool2User) {
      if (config.recipientId != null) {
        query = _paymentsCollection
            .where("transferDetails.recipientId", isEqualTo: config.recipientId)
            .where("type", isEqualTo: "MoneyPool2User")
            .orderBy("createdAt", descending: true);
      } else {
        throw throwNotSupportedException(config);
      }
    } else if (config.type == TransferType.User2MoneyPool) {
      // transfers of particular user to all money pools
      if (config.senderId != null) {
        query = _paymentsCollection
            .where("transferDetails.senderId", isEqualTo: config.senderId)
            .where("type", isEqualTo: "User2MoneyPool")
            .orderBy("createdAt", descending: true);
      }
      // all transfers to a particular money pool
      else if (config.recipientId != null) {
        query = _paymentsCollection
            .where("transferDetails.recipientId", isEqualTo: config.recipientId)
            .where("type", isEqualTo: "User2MoneyPool")
            .orderBy("createdAt", descending: true);
      }
      // all transfers to a particular money pool
      else if (config.recipientId != null) {
        query = _paymentsCollection
            .where("transferDetails.recipientId", isEqualTo: config.recipientId)
            .where("type", isEqualTo: "User2MoneyPool")
            .orderBy("createdAt", descending: true);
      } else {
        throw throwNotSupportedException(config);
      }
    } else {
      log.e("Could not find stream corresponding to provided config '$config'");
      throw FirestoreApiException(
          message: "Could not find stream corresponding to config $config",
          devDetails:
              "You likely provided a type that is not referring to a MoneyTransfer. Maybe a MoneyPoolPayout document? Then use the 'getMoneyPoolPayoutsStream()' function please of the firestore_api.");
    }

    if (config.maxNumberReturns != null)
      query = query.limit(config.maxNumberReturns!);

    // convert Stream<QuerySnapshot> to Stream<List<MoneyTransfer>>
    Stream<List<MoneyTransfer>> returnStream = query.snapshots().map(
          (event) => event.docs
              .map(
                (doc) => MoneyTransfer.fromJson(doc.data()),
              )
              .toList(),
        );
    return returnStream;
  }

  FirestoreApiException throwNotSupportedException(
      MoneyTransferQueryConfig config) {
    return FirestoreApiException(
        message:
            "You tried to access a type of history of transfers that is not supported",
        devDetails:
            "Depending on the transfer type you might have to define either 'senderId' or 'recipientId'. Your config: ${config.toJson()}");
  }

  // Combines streams of transfers and returns a list of money transfers
  Stream<List<MoneyTransfer>> getCombinedMoneyTransfersStream(
      {required Query outgoing,
      required Query incoming,
      int? maxNumberReturns}) {
    // combine streams with rxdart
    Stream<QuerySnapshot> outSnapshot = maxNumberReturns == null
        ? outgoing.snapshots()
        : outgoing.limit(maxNumberReturns).snapshots();
    Stream<QuerySnapshot> inSnapshot = maxNumberReturns == null
        ? incoming.snapshots()
        : incoming.limit(maxNumberReturns).snapshots();

    return Rx.combineLatest2<QuerySnapshot, QuerySnapshot, List<MoneyTransfer>>(
        outSnapshot, inSnapshot,
        (QuerySnapshot outSnapshot, QuerySnapshot inSnapshot) {
      // list of transactions to be returned
      List<MoneyTransfer> transactions = [];
      if (outSnapshot.docs.isNotEmpty) {
        transactions.addAll(outSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList());
      }
      if (inSnapshot.docs.isNotEmpty) {
        List<MoneyTransfer> inTransactions = inSnapshot.docs
            .map((snapshot) => MoneyTransfer.fromJson(snapshot.data()))
            .toList();
        List<String> transactionIds =
            transactions.map((element) => element.transferId).toList();
        inTransactions.forEach((element) {
          // TODO: Resolve conflicts properly
          // Add logic to find top ups (transactions to own account!)
          // Can be deprecated once data is already stored accordingly with topUp = true!
          if (!transactionIds.contains(element.transferId)) {
            transactions.add(element);
          } else {
            transactions
                .removeWhere((el2) => el2.transferId == element.transferId);
            transactions.add(element);
          }
        });
      }
      // TODO: This sometimes causes an exeption. Simply catch it?
      transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return transactions;
    });
  }

  ///////////////////////////////////////////////////////
  // Push transfer document to firestore
  Future createMoneyTransfer({required MoneyTransfer moneyTransfer}) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('processMoneyTransfer');
      final HttpsCallableResult<dynamic> result =
          await callable(moneyTransfer.toJson());
      if (result.data["error"] == null) {
        log.i(
            "Added the following transfer document to ${result.data["data"]["transferId"]}: ${moneyTransfer.toJson()}");
      } else {
        log.e(
            "Error when creating money transfer: ${result.data["error"]["message"]}");
        throw FirestoreApiException(
            message:
                "An error occured in the cloud function 'processMoneyTransferCallable'",
            devDetails:
                "Error message from cloud function: ${result.data["error"]["message"]}",
            prettyDetails:
                "An internal error occured on our side, please apologize and try again later.");
      }
    } catch (e) {
      log.e("Couldn't process transfer: ${e.toString()}");
      throw FirestoreApiException(
          message:
              "Something failed when calling the https function processMoneyTransferCallable",
          devDetails:
              "This should not happen and is due to an error on the Firestore side or the datamodels that were being pushed!",
          prettyDetails:
              "An internal error occured on our side, please apologize and try again later.");
    }
  }

  // -> TODO: handle it in a cloud function?
  // This will add the money pool payout document and also
  // create single money transfer documents. This makes it easy
  // to bookkeep things
  Future createMoneyPoolPayout({required MoneyPoolPayout payout}) async {
    try {
      // make this a batch commit
      final batch = FirebaseFirestore.instance.batch();

      // add money pool payout to batch
      final docRef = _moneyPoolPayoutsCollection.doc();
      final newPayout = payout.copyWith(payoutId: docRef.id);
      batch.set(docRef, newPayout.toJson());

      // Construct single money transfer documents
      // Push each money pool payout transfer to payments collection
      List<MoneyTransfer> moneyTransfers = [];
      newPayout.transfersDetails.forEach((element) {
        moneyTransfers.add(
          MoneyTransfer.moneyPoolPayoutTransfer(
              transferDetails: element,
              moneyPoolInfo: ConciseMoneyPoolInfo(
                  moneyPoolId: newPayout.moneyPool.moneyPoolId,
                  name: newPayout.moneyPool.name,
                  total: newPayout.moneyPool.total),
              payoutId: docRef.id,
              createdAt: FieldValue.serverTimestamp()),
        );
      });

      // add each single money transfer to batch
      moneyTransfers.forEach((element) {
        DocumentReference newDocRef = _paymentsCollection.doc();
        var newElement = element.copyWith(transferId: newDocRef.id);
        batch.set(newDocRef, newElement.toJson());
      });

      await batch.commit();

      log.i(
          "Added the following money pool payout document to ${docRef.path}: ${newPayout.toJson()}");
    } catch (e) {
      log.e("Couldn't process money pool payout: ${e.toString()}");
      throw FirestoreApiException(
          message: "Something failed when pushing the data to Firestore",
          devDetails:
              "This should not happen and is due to an error on the Firestore side or the datamodels that were being pushed!",
          prettyDetails:
              "An internal error occured on our side, please apologize and try again later.");
    }
  }

  //////////////////////////////////////////////////////////
  /// Listen to money pools collection

  /// invitations
  Stream<List<MoneyPool>> getMoneyPoolsInvitedToStream({required String uid}) {
    try {
      final returnStream = _moneyPoolsCollection
          .where("invitedUserIds", arrayContains: uid)
          .snapshots()
          .map((event) =>
              event.docs.map((doc) => MoneyPool.fromJson(doc.data())).toList());
      return returnStream;
    } catch (e) {
      throw FirestoreApiException(
          message:
              "Unknown expection when listening to money pools the user is invited to",
          devDetails: '$e');
    }
  }

  ///  money pools the user is contributing to
  Stream<List<MoneyPool>> getMoneyPoolsStream({required String uid}) {
    try {
      final returnStream = _moneyPoolsCollection
          .where("contributingUserIds", arrayContains: uid)
          .snapshots()
          .map((event) =>
              event.docs.map((doc) => MoneyPool.fromJson(doc.data())).toList());
      return returnStream;
    } catch (e) {
      throw FirestoreApiException(
          message:
              "Unknown expection when listening to money pools the user is contributing to",
          devDetails: '$e');
    }
  }

  ///  get stream of single money pool
  Stream<MoneyPool> getMoneyPoolStream({required String mpid}) {
    try {
      final returnStream =
          _moneyPoolsCollection.doc(mpid).snapshots().map((event) {
        if (event.data() == null) {
          throw FirestoreApiException(
              message: "Unknown expection when listening to single money pool",
              devDetails:
                  "Somehow the document was not available anymore when it was tried to listen to it. Probably it has been deleted",
              prettyDetails:
                  "This money pool does not exist anymore. Please refer to the admin of that money pool, he might have closed it :)");
        } else {
          return MoneyPool.fromJson(event.data()!);
        }
      });
      return returnStream;
    } catch (e) {
      if (e is FirestoreApi) {
        rethrow;
      } else {
        throw FirestoreApiException(
            message:
                "Unknown expection when listening to single money pool the user is contributing to",
            devDetails: '$e');
      }
    }
  }

  /// Stream of payout documents of money pool
  Stream<List<MoneyPoolPayout>> getMoneyPoolPayoutsStream(
      {required String mpid}) {
    try {
      final returnStream = _moneyPoolPayoutsCollection
          .where("moneyPool.moneyPoolId", isEqualTo: mpid)
          .snapshots()
          .map((event) => event.docs
              .map((doc) => MoneyPoolPayout.fromJson(doc.data()))
              .toList());
      return returnStream;
    } catch (e) {
      throw FirestoreApiException(
          message: "Unknown expection when listening to money pool payouts",
          devDetails: '$e');
    }
  }

  /////////////////////////////////////////////////////////
  /// Money pool CRUD

  // Updates money pool document
  // Probably we want to call a cloud function instead
  Future updateMoneyPool(MoneyPool moneyPool) async {
    // probably we want to call a cloud function instead
    log.i("Updating money pool: ${moneyPool.toJson()}");
    try {
      _moneyPoolsCollection
          .doc(moneyPool.moneyPoolId)
          .update(moneyPool.toJson());
    } catch (e) {
      throw FirestoreApiException(
          message: "Unknown expection when updating money pool",
          devDetails: '$e');
    }
  }

  // Creates money pool and returns it
  // TODO: probably we want to call a cloud function instead
  Future<MoneyPool> createAndReturnMoneyPool(
      {required MoneyPool moneyPool}) async {
    try {
      DocumentReference docRef = _moneyPoolsCollection.doc();
      var newMoneyPool = moneyPool.copyWith(moneyPoolId: docRef.id);
      await docRef.set(newMoneyPool.toJson());
      log.i("Created money pool: ${newMoneyPool.toJson()}");
      return newMoneyPool;
    } catch (e) {
      throw FirestoreApiException(
          message: "Unusual expection when creating and returning money pool",
          devDetails: '$e');
    }
  }

  // Get money pool
  // Gets and returns money pool from firestore
  Future getMoneyPool(String mpid) async {
    try {
      DocumentSnapshot snapshot = await _moneyPoolsCollection.doc(mpid).get();
      if (snapshot.data() != null) {
        return MoneyPool.fromJson(snapshot.data()!);
      } else {
        log.wtf(
            "Could not find data of money pool with id $mpid, returning null");
        throw FirestoreApiException(
            message: "Unusual expection when trying to get Money Pool",
            devDetails:
                "This can happen if a user views a money pool while it is deleted by another user!",
            prettyDetails:
                "This money pool does not exist anymore. Please refer to the admin of that money pool, he might have closed it :)");
      }
    } catch (e) {
      if (e is FirestoreApiException)
        rethrow;
      else {
        throw FirestoreApiException(
            message: "Unusual expection when trying to get Money Pool",
            devDetails: '$e');
      }
    }
  }

  // deletes money pool documents
  // TODO: probably we want to call a cloud function instead
  Future deleteMoneyPool(String moneyPoolId) async {
    try {
      await _moneyPoolsCollection.doc(moneyPoolId).delete();
    } catch (e) {
      throw FirestoreApiException(
          message:
              "Unusual expection when trying to delete the money pool document",
          devDetails: '$e');
    }
  }

  ////////////////////////////////////////////////////////////
  /// Projects data

  ///  Get project with id
  Future<Project> getProjectWithId({required String id}) async {
    try {
      DocumentSnapshot snapshot = await _projectsCollection.doc(id).get();
      if (snapshot.data() != null) {
        return Project.fromJson(snapshot.data()!);
      } else {
        log.wtf("Could not find data of project with id $id, returning null");
        throw FirestoreApiException(
            message: "Unusual expection when trying to get Project",
            devDetails:
                "This can happen if a project has been deleted from the database!",
            prettyDetails:
                "Unfortunately, this project is not supported anymore.");
      }
    } catch (e) {
      if (e is FirestoreApiException)
        rethrow;
      else {
        throw FirestoreApiException(
            message: "Unusual expection when trying to get Project",
            devDetails: '$e');
      }
    }
  }

  ///  Listen to projects collection
  Stream<List<Project>> getProjectsStream({required String uid}) {
    try {
      final returnStream = _projectsCollection.snapshots().map((event) =>
          event.docs.map((doc) => Project.fromJson(doc.data())).toList());
      return returnStream;
    } catch (e) {
      throw FirestoreApiException(
          message: "Unknown expection when listening to projects collection",
          devDetails: '$e');
    }
  }

  ///  Listen to projects collection
  Future createProject({required Project project}) async {
    try {
      final docRef = _projectsCollection.doc();
      final newProject = project.copyWith(id: docRef.id);
      await docRef.set(newProject.toJson());
    } catch (e) {
      throw FirestoreApiException(
          message:
              "Unknown expection when adding project to projects collection",
          devDetails: '$e');
    }
  }

  // Functions handling project favorites
  Future updateUserSettings(
      {required String uid, required UserSettings settings}) async {
    try {
      await _usersCollection
          .doc(uid)
          .set(settings.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw FirestoreApiException(
          message:
              "Unknown expection when updating user settings in users collection",
          devDetails: '$e');
    }
  }

  /////////////////////////////////////////////////////////
  // Collection's getter
  CollectionReference getUserStatisticsCollection({required String uid}) {
    return _usersCollection.doc(uid).collection(userStatisticsCollectionKey);
  }

  DocumentReference getUserSummaryStatisticsDocument({required String uid}) {
    return _usersCollection
        .doc(uid)
        .collection(userStatisticsCollectionKey)
        .doc(userSummaryStatisticsDocumentKey);
  }
}
