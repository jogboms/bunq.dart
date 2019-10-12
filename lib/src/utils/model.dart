import 'dart:convert' show json;

abstract class ModelInterface {
  Map<String, dynamic> toMap();

  Map<String, dynamic> toJson() => toMap();

  @override
  String toString() => Model.mapToString(toMap());
}

abstract class Model implements ModelInterface {
  @override
  Map<String, dynamic> toMap();

  Model clone() => null;

  static int parseInt(dynamic value) {
    return int.tryParse(value.toString());
  }

  static double parseDouble(dynamic value) {
    return double.tryParse(value.toString());
  }

  static DateTime parseTimestamp(String timestamp) {
    try {
      return DateTime.tryParse(timestamp);
    } catch (e) {
      return null;
    }
  }

  static List<T> generator<T>(List<dynamic> items, T Function(dynamic) cb) {
    return List<T>.generate(
      items != null ? items.length : 0,
      (int index) => cb(items[index]),
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();

  static String mapToString(Map<String, dynamic> map) {
    assert(map != null);
    try {
      return json.encode(map);
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic> stringToMap(String string) {
    if (string == null || string.isEmpty) {
      return null;
    }
    try {
      return json.decode(string);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() => mapToString(toMap());

  dynamic operator [](String key) => toMap()[key];
}
