// The following defines the Firestore collection setup!
import 'package:cloud_firestore/cloud_firestore.dart';

// when running on production backend
const String AUTHORITYDEV =
    "us-central1-gooddollarsmarketplace.cloudfunctions.net";
const String URIPATHPREPENDDEV = "";

// when running on production backend
const String AUTHORITYPROD =
    "us-central1-the-good-wallet-test-env.cloudfunctions.net";
const String URIPATHPREPENDPROD = "";

// Limit of number of messages that are read from database in money pools
const int kNumberOfMessagesLimit = 50;

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');
final String userStatisticsCollectionKey = "statistics";
final String userSummaryStatisticsDocumentKey = "summaryStats";
final CollectionReference paymentsCollection =
    FirebaseFirestore.instance.collection('transfers');
final CollectionReference moneyPoolPayoutsCollection =
    FirebaseFirestore.instance.collection("moneyPoolPayouts");
final CollectionReference moneyPoolsCollection =
    FirebaseFirestore.instance.collection('moneyPools');
final String moneyPoolMessagesDocumentKey = "messages";

final CollectionReference projectsCollection =
    FirebaseFirestore.instance.collection('projects');
final appName = 'The Good Wallet';
final CollectionReference globalStatsCollection =
    FirebaseFirestore.instance.collection("globalStats");
////////////////////////////////////////////////////////