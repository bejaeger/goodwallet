// The following defines the Firestore collection setup!
import 'package:cloud_firestore/cloud_firestore.dart';

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

////////////////////////////////////////////////////////