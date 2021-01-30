// Some small helper functions

dynamic returnIfAvailable(dynamic map, String key) {
  if (map.containsKey(key)) {
    return map[key];
  } else {
    return null;
  }
}
