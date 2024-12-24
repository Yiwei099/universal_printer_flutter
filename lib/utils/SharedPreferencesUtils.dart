import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShapedPreferencesUtils {
  //<editor-fold desc="单例的实现">
  static final ShapedPreferencesUtils _instance =
      ShapedPreferencesUtils._internal(); //唯一单例, _代表类私有,禁止外部直接访问
  factory ShapedPreferencesUtils() =>
      _getInstance(); //使用工厂构造方法，通过Test()获取类时，返回唯一实例
  static ShapedPreferencesUtils get instance =>
      _getInstance(); //通过静态变量instance获取实例

  static ShapedPreferencesUtils _getInstance() {
    //这里真正生成唯一实例
    return _instance;
  }

  ShapedPreferencesUtils._internal() {
    //命名构造函数
    //初始化
    // print('Channel 初始化啦');
  }

//</editor-fold desc="单例的实现">

  Future<SharedPreferences> _getSPInstance() async {
    return await SharedPreferences.getInstance();
  }

  void putInt(String key, int value) {
    _getSPInstance().then((instance) async {
      bool result = await instance.setInt(key, value);
      debugPrint("putInt $key $value $result");
    });
  }

  Future<int> getInt({required String key,int defaultValue = 0}) async {
    return (await _getSPInstance()).getInt(key) ?? defaultValue;
  }

  void putString(String key, String value) {
    _getSPInstance().then((instance) async {
      bool result = await instance.setString(key, value);
      debugPrint("putString $key $value $result");
    });
  }

  Future<String> getString({required String key,String defaultValue = ''}) async {
    return (await _getSPInstance()).getString(key) ?? defaultValue;
  }
}
