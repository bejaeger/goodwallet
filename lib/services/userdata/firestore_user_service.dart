// Service to connect to user data stored on firestore
// Functionalities
//  - adding/retrieving user data from user model to firestore

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:good_wallet/models/user.dart';

class FirestoreUserService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  dynamic getUserData(String uid) {
    return _usersCollectionReference
        .doc(uid)
        .snapshots()
        .map((snap) => snap.data);
  }

  // User ------------------------------------------------->>
  Future createUser(MyUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson(true));
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      MyUser user = MyUser.fromData(userData.data());
      print("INFO: Found user with name: ${user.fullName}");
      return user;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      print("return error sting: ${e.toString()}");
      return e.toString();
    }
  }
}
