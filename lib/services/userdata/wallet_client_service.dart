// Wallet service on the client side
// Functionalities:
//  - Retrieving current balances
//  - TODO: Keeping track of transactions/donations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

// Another Firestore service targeted to payments
class UserWalletService with ReactiveServiceMixin {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  RxValue<num> _balance = RxValue<num>(initial: 0);
  RxValue<num> _implicitDonations = RxValue<num>(initial: 0);
  RxValue<num> _donations = RxValue<num>(initial: 0);

  UserWalletService() {
    listenToReactiveValues([_balance, _implicitDonations, _donations]);
  }

  num get balance => _balance.value;
  num get implicitDonations => _implicitDonations.value;
  num get donations => _donations.value;

  Future updateBalancesLocal(String uid) async {
    var result = await _usersCollectionReference.doc(uid).get();
    if (result is String) {
      print("ERROR: An error occured when updating the balance, see below:");
      print("ERROR: $result");
      // TODO: Throw exception
    } else {
      _balance.value = result.data()["balance"];
      _implicitDonations.value = result.data()["implicitDonations"];
      _donations.value = result.data()["donations"];
    }
  }
}
