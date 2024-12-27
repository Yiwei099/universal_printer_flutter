import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_printer_flutter/bean/ble/ble_devices.dart';
import 'package:universal_printer_flutter/bean/usb/usb_devices.dart';

class ChannelUtils {

  static const String NAME = 'AndroidSupports';

  static const String ON_DEVICE_FOUND = 'scanBleDevicesResult';
  static const String BLE_DISCOVERY_STATE_CALL_BACK = 'bleDiscoveryStateCallBack';

  //<editor-fold desc="单例的实现">
  static final ChannelUtils _instance = ChannelUtils._internal(); //唯一单例, _代表类私有,禁止外部直接访问
  factory ChannelUtils() => _getInstance(); //使用工厂构造方法，通过Test()获取类时，返回唯一实例
  static ChannelUtils get instance => _getInstance(); //通过静态变量instance获取实例

  static ChannelUtils _getInstance(){
    //这里真正生成唯一实例
    return _instance;
  }

  ChannelUtils._internal(){
    //命名构造函数
    //初始化
    // print('Channel 初始化啦');
  }
  //</editor-fold desc="单例的实现">

  //<editor-fold desc="定义Channel">
  static const MethodChannel _channel = MethodChannel(NAME);

  static void setupMethodCallHandler(Future<dynamic> Function(MethodCall call) call) {
    _channel.setMethodCallHandler(call);
  }

  static void clearMethodCallHandler() {
    _channel.setMethodCallHandler(null);
  }
  //</editor-fold desc="定义Channel">

  //<editor-fold desc="USB方法">
  /// 注册 USB 服务
  static Future<bool> onRegisterUsbService() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('registerUsbService');
    }catch(e){
      debugPrint(e.toString());
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
  //</editor-fold desc="USB方法">

  //<editor-fold desc="Ble方法">
  /// 注册 BLE 服务
  static Future<bool> onRegisterBleService() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('registerBleService');
    }catch(e){
      print(e);
    }
    return result;
  }

  /// 销毁 BLE 服务
  static Future<bool> unRegisterBleService() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('unRegisterBleService');
    }catch(e){
      print(e);
    }
    return result;
  }

  static Future<bool> discoveryBleDevices() async {
    bool result = false;
    try {
       result = await _channel.invokeMethod('discoveryBleDevices');
      // result = BleDevices.fromJson(json.decode(devices));
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<bool> stopDiscoveryBleDevices() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('stopDiscoveryBleDevices');
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<bool> startDiscoveryBleDevices() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('startDiscoveryBleDevices');
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<BleDevices?> onBleDeviceScanCallBack() async {
    BleDevices? result;
    try {
      String resultStr = await _channel.invokeMethod('scanBleDevicesResult');
      print(resultStr);
      // result = BleDevices.fromJson(json.decode(resultStr));
    } catch (e) {
      print(e);
    }

    return result;
  }
  //</editor-fold desc="Ble方法">

  //<editor-fold desc="绘制数据源相关">
  static Future<bool> addDrawElement(String data) async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('addDrawElement', data);
    }catch(e){
      print(e);
    }
    return result;
  }
  //</editor-fold desc="绘制数据源相关">
}