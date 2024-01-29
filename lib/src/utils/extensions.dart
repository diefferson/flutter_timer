import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension JsonUtils on Map<dynamic, dynamic> {
  T getSafeItem<T>(String key, {required T defaultValue}) {
    if (containsKey(key)) {
      return this[key];
    }
    return defaultValue;
  }

  T getValue<T>(String key, T defaultValue) {
    return jsonSafeValue(this, key, defaultValue);
  }

  T? getNestedValue<T>(List<String> keys) {
    return jsonNestedValue(this, keys);
  }

  String getString(String key) {
    return jsonSafeValue(this, key, '');
  }

  Color getColor(String key) {
    return HexColor.fromHex(jsonSafeValue(this, key, ''));
  }

  String? getStringNull(String key) {
    return jsonSafeValue<String?>(this, key, null);
  }

  String getStringFromKeys(List<String> keys) {
    String? value;
    for (final key in keys) {
      if (containsKey(key)) {
        value = getString(key);
        break;
      }
    }

    if (value != null) {
      return value;
    }

    return getString(keys[0]);
  }

  File? getFile(String key) {
    try {
      return File(getString(key));
    } catch (_) {
      return null;
    }
  }

  File? getFileFromKeys(List<String> keys) {
    File? value;
    for (var element in keys) {
      if (containsKey(element)) {
        value = getFile(element);
        continue;
      }
    }

    return value!;
  }

  int getInt(String key) {
    return jsonSafeValue(this, key, 0);
  }

  int? getIntNull(String key) {
    return jsonSafeValue<int?>(this, key, null);
  }

  int getIntFromKeys(List<String> keys) {
    int? value;
    for (var element in keys) {
      if (containsKey(element)) {
        value = getInt(element);
        continue;
      }
    }
    if (value != null) {
      return value;
    }
    return getInt(keys[0]);
  }

  double getDouble(String key) {
    try {
      return double.parse(this[key].toString());
    } catch (_) {
      return 0.0;
    }
  }

  double? getDoubleNull(String key) {
    return jsonSafeValue<double?>(this, key, null);
  }

  double getDoubleFromKeys(List<String> keys) {
    double? value;
    for (var element in keys) {
      if (containsKey(element)) {
        value = getDouble(element);
        continue;
      }
    }
    if (value != null) {
      return value;
    }
    return getDouble(keys[0]);
  }

  bool getBool(String key) {
    return jsonSafeValue(this, key, false);
  }

  bool? getBoolNull(String key) {
    return jsonSafeValue<bool?>(this, key, null);
  }

  bool getBoolFromKeys(List<String> keys) {
    bool? value;
    for (var element in keys) {
      if (containsKey(element)) {
        value = getBool(element);
        continue;
      }
    }
    if (value != null) {
      return value;
    }
    return getBool(keys[0]);
  }

  T? getObject<T>(String key, T Function(Map<dynamic, dynamic>) itemMap) {
    return jsonSafeMap(this, key, itemMap);
  }

  T getEnum<T>(String key, T Function(String?) enumMap) {
    return jsonSafeEnum(this, key, enumMap);
  }

  T getEnumFromKeys<T>(List<String> keys, T Function(String?) enumMap) {
    T? value;
    for (var element in keys) {
      if (containsKey(element)) {
        value = jsonSafeEnum(this, element, enumMap);
        continue;
      }
    }
    if (value != null) {
      return value;
    }
    return jsonSafeEnum(this, keys[0], enumMap);
  }

  List<T> getList<T>(String key, [T Function(Map<dynamic, dynamic>)? itemMap]) {
    return jsonListValue(this, key, itemMap);
  }

  DateTime? getDate(String key) {
    return jsonDateValue(this, key);
  }

  DateTime? getDateFromKeys(List<String> keys) {
    DateTime? value;
    for (var element in keys) {
      if (containsKey(element)) {
        value = getDate(element);
        continue;
      }
    }

    return value;
  }

  Map<dynamic, dynamic> removeNulls() {
    removeWhere((key, value) => value == null);
    return this;
  }
}

extension JsonListUtils on List<dynamic> {
  List<T> asList<T>(T Function(Map<dynamic, dynamic>) itemMap) {
    return jsonAsList(this, itemMap);
  }
}

DateTime? jsonDateValue(Map<dynamic, dynamic> json, String key) {
  if (json[key] is int) {
    return DateTime.fromMillisecondsSinceEpoch(json[key], isUtc: true);
  }
  return stringToDate((json[key] as String?) ?? "");
}

T jsonSafeValue<T>(Map<dynamic, dynamic> json, String key, T defaultValue) {
  try {
    final value = json[key];
    if (value != null) {
      return value;
    } else {
      return defaultValue;
    }
  } catch (e) {
    return defaultValue;
  }
}

T? jsonSafeMap<T>(Map<dynamic, dynamic> json, String key,
    T Function(Map<dynamic, dynamic>) itemMap) {
  if (json.containsKey(key)) {
    try {
      return itemMap(json[key]);
    } catch (e) {
      return null;
    }
  }
  return null;
}

T jsonSafeEnum<T>(
    Map<dynamic, dynamic> json, String key, T Function(String?) enumMap) {
  try {
    return enumMap(json[key]);
  } catch (e) {
    return enumMap(null);
  }
}

List<T> jsonListValue<T>(Map<dynamic, dynamic> json, String key,
    [T Function(Map<dynamic, dynamic>)? itemMap]) {
  try {
    final list = (json[key] as List<dynamic>)
      ..removeWhere((element) => element == null);

    if (itemMap != null) {
      return list.map((dynamic e) => itemMap(e)).toList();
    }
    return list.map((e) => e as T).toList();
  } catch (e) {
    return [];
  }
}

List<T> jsonAsList<T>(
    List<dynamic> json, T Function(Map<dynamic, dynamic>) itemMap) {
  try {
    return json.map((dynamic e) => itemMap(e)).toList();
  } catch (e) {
    return [];
  }
}

T? jsonNestedValue<T>(Map<dynamic, dynamic> json, List<String> nestedKeys) {
  try {
    if (nestedKeys.length == 1) {
      return json[nestedKeys[0]];
    } else if (nestedKeys.length == 2) {
      return json[nestedKeys[0]][nestedKeys[1]];
    } else if (nestedKeys.length == 3) {
      return json[nestedKeys[0]][nestedKeys[1]][nestedKeys[2]];
    } else if (nestedKeys.length == 4) {
      return json[nestedKeys[0]][nestedKeys[1]][nestedKeys[2]][nestedKeys[3]];
    } else if (nestedKeys.length == 5) {
      return json[nestedKeys[0]][nestedKeys[1]][nestedKeys[2]][nestedKeys[3]]
      [nestedKeys[4]];
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}


DateTime? stringToDate(String value) {
  final dateFormats = [
    "yyyy-MM-dd'T'HH:mm:ss.SSSz",
    "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
    "yyyy-MM-dd'T'HH:mm:ss'Z'",
    "yyyy-MM-dd'T'HH:mm:ss.SSS",
    "yyyy-MM-dd'T'HH:mm:ss",
    'yyyy-MM-dd HH:mm:ss',
    'yyyy-MM-dd',
    'dd/MM/yyyy',
    'dd-MM-yyyy',
  ];

  for (var format in dateFormats) {
    try {
      final date = DateFormat(format).parse(value);
      if (date.year < 1900) {
        throw Exception();
      }
      return date;
    } catch (e) {
      //nothing
    }
  }

  return null;
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension DateExtensions on DateTime {

  static const String dateDotsFormat = 'dd.MM.yyyy';
  static const String weekDayFormat = 'EEEE';

  String toDateString({String format = 'MM/dd/yyyy'}) {
    return DateFormat(format).format(this);
  }
}

String secondsToString(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;

  String hoursString = hours.toString().padLeft(2, '0');
  String minutesString = minutes.toString().padLeft(2, '0');

  return '$hoursString:$minutesString';
}

String secondsToCompleteString(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int remainingSeconds = seconds % 60;

  String hoursString = hours.toString().padLeft(2, '0');
  String minutesString = minutes.toString().padLeft(2, '0');
  String secondsString = remainingSeconds.toString().padLeft(2, '0');

  return '$hoursString:$minutesString:$secondsString';
}