// Some small helper functions

import 'package:good_wallet/enums/causes_type.dart';

String getInitialsFromName(String name) {
  List<String> splitName = name.split(" ");
  List<String> initials = [];
  for (var i = 0; i < 2; i++) {
    if (splitName.length >= i + 1) initials.add(splitName[i][0].toUpperCase());
  }
  return initials.join("");
}

dynamic returnIfAvailable(dynamic map, String key) {
  if (map.containsKey(key)) {
    return map[key];
  } else {
    return null;
  }
}

CauseType getCauseTypeFromString(String str) {
  return CauseType.values.firstWhere((e) => e.toString() == str);
}
