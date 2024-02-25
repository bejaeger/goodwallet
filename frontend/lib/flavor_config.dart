import 'constants/constants.dart';

enum Flavor { unknown, dev, prod }

class FlavorConfigProvider {
  Flavor flavor = Flavor.unknown;
  void configure(Flavor flavorIn) {
    flavor = flavorIn;
  }

  String get appName {
    switch (this.flavor) {
      case Flavor.dev:
        return "The Good Wallet - Dev";
      case Flavor.prod:
        return "The Good Wallet";
      default:
        return "The Good Wallet - Dev";
    }
  }

  String get authority {
    switch (this.flavor) {
      case Flavor.dev:
        return AUTHORITYDEV;
      case Flavor.prod:
        return AUTHORITYPROD;
      default:
        return AUTHORITYDEV;
    }
  }

  String get uripathprepend {
    switch (this.flavor) {
      case Flavor.dev:
        return URIPATHPREPENDDEV;
      case Flavor.prod:
        return URIPATHPREPENDPROD;
      default:
        return URIPATHPREPENDDEV;
    }
  }

  String get testUserEmail {
    return "test@gmail.com";
  }

  String get testUserPassword {
    return "m1m1m1";
  }

  String get testUserId {
    switch (this.flavor) {
      case Flavor.dev:
        return "ptWSWNPX4xRyVsb6jwjPfff5C2B3";
      case Flavor.prod:
        return "EnicDcqIZkfRcYwJEZngM8ittaN2";
      default:
        return "ptWSWNPX4xRyVsb6jwjPfff5C2B3";
    }
  }

  String get releaseName {
    switch (this.flavor) {
      case Flavor.dev:
        return "Dev";
      case Flavor.prod:
        return "Alpha v1.0";
      default:
        return "Dev";
    }
  }
}
