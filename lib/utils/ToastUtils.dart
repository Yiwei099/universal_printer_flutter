import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  //<editor-fold desc="单例的实现">
  static final ToastUtils _instance = ToastUtils._internal(); //唯一单例, _代表类私有,禁止外部直接访问
  factory ToastUtils() => _getInstance(); //使用工厂构造方法，通过Test()获取类时，返回唯一实例
  static ToastUtils get instance => _getInstance(); //通过静态变量instance获取实例

  static ToastUtils _getInstance(){
    //这里真正生成唯一实例
    return _instance;
  }

  ToastUtils._internal(){
    //命名构造函数
    //初始化
    // print('Channel 初始化啦');
  }
//</editor-fold desc="单例的实现">

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}