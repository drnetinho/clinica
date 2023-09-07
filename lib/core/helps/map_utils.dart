Map<String, dynamic> addMapId(Map<String, dynamic> map, String id) {
  final data = map;
  data.addAll({'id': id});
  return data;
}

Map<String, dynamic> addMapKey(Map<String, dynamic> map, String value, String key) {
  final data = map;
  data.addAll({key: value});
  return data;
}

Map<String, dynamic> refreshMapKey({
  required Map<String, dynamic> map,
  required String newValue,
  required String key,
}) {
  final data = map;
  data.remove(key);
  data.addAll({key: newValue});
  return data;
}
