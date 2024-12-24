import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShapedPreferencesUtils {
  //<editor-fold desc="单例的实现">
  factory ShapedPreferencesUtils() => _instance;
  static final ShapedPreferencesUtils _instance =
      ShapedPreferencesUtils._internal();

  static late SharedPreferences _preferences;

  static Future<ShapedPreferencesUtils> getInstance() async {
    //这里真正生成唯一实例
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  ShapedPreferencesUtils._internal();

//</editor-fold desc="单例的实现">

  static Future<bool> putInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  static Future<bool> putString(String key, String value) {
    return _preferences.setString(key, value);
  }

  static Future<bool> putBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  static Future<bool> putDouble(String key, double value) {
    return _preferences.setDouble(key, value);
  }

  static putData<T>(String key, T value) {
    String type = value.runtimeType.toString();
    switch (type) {
      case 'String':
        putString(key, value as String);
        break;
      case 'int':
        putInt(key, value as int);
        break;
      case 'bool':
        putBool(key, value as bool);
        break;
      case 'double':
        putDouble(key, value as double);
        break;
      default:
        debugPrint('不支持的类型');
        break;
    }
  }

  static int getInt({required String key, int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  static String getString({required String key, String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }
}
