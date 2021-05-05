// Some small helper functions

//////////////////////////
/// TODO: DEPRECATE THIS FILE
/// And create String utils class!
/// /////////////////////////////

String getInitialsFromName(String name) {
  List<String> splitName = name.split(" ");
  List<String> initials = [];
  for (var i = 0; i < 2; i++) {
    if (splitName.length >= i + 1) {
      if (splitName[i].length > 0) {
        initials.add(splitName[i][0].toUpperCase());
      }
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
