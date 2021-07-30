import 'package:good_wallet/enums/user_status.dart';

class UserState {
  UserStatus? status;
  dynamic value;

  UserState({this.value}) {
    this.status = value == "undefined"
        ? UserStatus.Unknown
        : value == null
            ? UserStatus.SignedOut
            : UserStatus.SignedIn;
    this.value = value;
  }
}
