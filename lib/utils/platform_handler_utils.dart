import 'dart:io';

import 'package:flutter/cupertino.dart';

class PlatformHandlerUtils {
  //<editor-fold desc="单例的实现">
  static final PlatformHandlerUtils _instance =
      PlatformHandlerUtils._internal(); //唯一单例, _代表类私有,禁止外部直接访问
  factory PlatformHandlerUtils() =>
      _getInstance(); //使用工厂构造方法，通过Test()获取类时，返回唯一实例
  static PlatformHandlerUtils get instance =>
      _getInstance(); //通过静态变量instance获取实例

  static PlatformHandlerUtils _getInstance() {
    //这里真正生成唯一实例
    return _instance;
  }

  PlatformHandlerUtils._internal() {
    //命名构造函数
    //初始化
    // print('Channel 初始化啦');
  }

//</editor-fold desc="单例的实现">

  static void getPlatformByHandler({
    Function()? androidCallBack,
    Function()? iosCallBack,
    Function()? otherCallBack,
    Function()? errorCallBack,
    required Function() defaultCallBack,
  }) {
    try {
      if (Platform.isAndroid) {
        debugPrint('初始化 Android 平台');
        androidCallBack != null ? androidCallBack() : defaultCallBack();
      } else if (Platform.isIOS) {
        debugPrint('初始化 Ios 平台');
        iosCallBack != null ? iosCallBack() : defaultCallBack();
      } else {
        debugPrint('初始化其他平台');
        otherCallBack != null ? otherCallBack() : defaultCallBack();
      }
    } catch (e) {
      debugPrint('获取平台失败');
      // web 报错： Unsupported operation: Platform._operatingSystem 据说要使用 kIsWeb
      errorCallBack != null ? errorCallBack() : defaultCallBack();
    }
  }

  static T getPlatformByHandlerAsync<T>({
    T Function()? androidCallBack,
    T Function()? iosCallBack,
    T Function()? otherCallBack,
    T Function()? errorCallBack,
    required T Function() defaultCallBack,
  }) {
    try {
      if (Platform.isAndroid) {
        debugPrint('初始化 Android 平台');
        return androidCallBack == null ? defaultCallBack() : androidCallBack();
      } else if (Platform.isIOS) {
        debugPrint('初始化 Ios 平台');
        return iosCallBack == null ? defaultCallBack() : iosCallBack();
      } else {
        debugPrint('初始化其他平台');
        return otherCallBack == null ? defaultCallBack() : otherCallBack();
      }
    } catch (e) {
      debugPrint('async 获取平台失败');
      // web 报错： Unsupported operation: Platform._operatingSystem 据说要使用 kIsWeb
      return errorCallBack == null ? defaultCallBack() : errorCallBack();
    }
  }
}
