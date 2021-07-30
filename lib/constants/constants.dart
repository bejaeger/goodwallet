// The following defines the Firestore collection setup!
import 'package:cloud_firestore/cloud_firestore.dart';

// when running on production backend
const String AUTHORITY =
    "us-central1-gooddollarsmarketplace.cloudfunctions.net";
const String URIPATHPREPEND = "";

// When running with the firebase emulator
// const String AUTHORITY = "192.168.1.69:5001";
// const String URIPATH = "gooddollarsmarketplace/us-central1";

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
final CollectionReference projectsCollection =
    FirebaseFirestore.instance.collection('projects');
final appName = 'The Good Dollars Marketplace';
final CollectionReference globalStatsCollection =
    FirebaseFirestore.instance.collection("globalStats");
////////////////////////////////////////////////////////