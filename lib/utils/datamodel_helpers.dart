// Some small helper functions

import 'package:flutter/foundation.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/utils/logger.dart';

String getInitialsFromName(String name) {
  List<String> splitName = name.split(" ");
  List<String> initials = [];
  for (var i = 0; i < 2; i++) {
    if (splitName[i].length > 0) {
      if (splitName.length >= i + 1)
        initials.add(splitName[i][0].toUpperCase());
    }
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
  CauseType cause;
  try {
    cause = CauseType.values.firstWhere((e) => describeEnum(e) == str);
  } catch (e) {
    final log = getLogger("datamodel_helpers.dart");
    log.e("Could not find matching element, error: ${e.toString()}");
    rethrow;
  }
  return cause;
}
