// Service to connect to user data stored on firestore
// Functionalities
//  - adding/retrieving user data from user model to firestore

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/datamodels/user.dart';

class FirestoreUserService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  // User ------------------------------------------------->>
  Future createUser(User user, [String fullName]) async {
    // create a new user profile on firestore`
    num balance = 0;
    num implicitDonations = 0;
    num donations = 0;
    MyUser myuser = MyUser(
      id: user.uid,
      email: user.email,
      fullName: fullName != null ? fullName : user.displayName,
      balance: balance,
      implicitDonations: implicitDonations,
      donations: donations,
    );
    try {
      await _usersCollectionReference.doc(user.uid).set(myuser.toJson(true));
      return myuser;
    } catch (e) {
      print("ERROR: ${e.toString()}");
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      MyUser user = MyUser.fromData(userData.data());
      return user;
    } catch (e) {
      print("ERROR: ${e.toString()}");
      return e.toString();
    }
  }
}
