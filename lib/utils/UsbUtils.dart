import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:universal_printer_flutter/bean/usb/UsbDevices.dart';

class UsbUtils {

  //<editor-fold desc="单例的实现">
  static final UsbUtils _instance = UsbUtils._internal(); //唯一单例, _代表类私有,禁止外部直接访问
  factory UsbUtils() => _getInstance(); //使用工厂构造方法，通过Test()获取类时，返回唯一实例
  static UsbUtils get instance => _getInstance(); //通过静态变量instance获取实例

  static UsbUtils _getInstance(){
    //这里真正生成唯一实例
    return _instance;
  }

  UsbUtils._internal(){
    //命名构造函数
    //初始化
  }
  //</editor-fold desc="单例的实现">

  //<editor-fold desc="定义Channel">
  static const MethodChannel _channel = const MethodChannel('usb_channel');
  //</editor-fold desc="定义Channel">

  //<editor-fold desc="Channel方法">
  /// 注册 USB 服务
  static Future<bool> onRegisterUsbService() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('registerUsbService');
    }catch(e){
      print(e);
    }
    return result;
  }

  /// 销毁 USB 服务
  static Future<bool> unRegisterUsbService() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('unRegisterUsbService');
    }catch(e){
      print(e);
    }
    return result;
  }

  /// 获取USB设备
  static Future<List<UsbDevices>> getDevices() async {
    List<UsbDevices> result = List.empty();
    try {
      String devices = await _channel.invokeMethod('getUsbDevices');
      // 处理获取到的USB设备
      if(devices.isNotEmpty) {
        List<dynamic> jsonList = json.decode(devices);
        // 将 List<Map<String, dynamic>> 转换为 List<UsbDevice>
        result = jsonList.map((json) => UsbDevices.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
  //<editor-fold desc="Channel方法">
}