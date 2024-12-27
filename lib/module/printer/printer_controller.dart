import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/bean/my_printer.dart';

import '../../bean/ble/ble_devices.dart';
import '../../bean/usb/usb_devices.dart';
import '../../constant/constant.dart';
import '../../utils/shared_preferences_utils.dart';
import '../../utils/string_utils.dart';

class PrinterController extends GetxController {
  final _currentPrinter = MyPrinter(id: 0).obs;
  final Rx<UsbDevices?> _devices = Rx(null);
  final _bleDevicesMac = ''.obs;
  final TextEditingController wifiIpController = TextEditingController();
  var showCode = false.obs;

  get bleDevicesMac => _bleDevicesMac.value;

  @override
  void onClose() {
    wifiIpController.dispose();
    super.onClose();
  }

  void setCurrentPrinter(MyPrinter printer) {
    if (printer.connect == ConnectType.wifi) {
      //获取已保存的IP地址
      String value = ShapedPreferencesUtils.getString(
          key: printer.id.toString(), defaultValue: '192.168.');
      printer.wifiIp.value = value;
      _currentPrinter.value = printer;
      wifiIpController.text = value;
    } else {
      _currentPrinter.value = printer;
    }
  }

  void setWifiIp(String ip) {
    _currentPrinter.value.wifiIp.value = ip;
    ShapedPreferencesUtils.putString(_currentPrinter.value.id.toString(), ip);
  }

  void cacheUsbDevices(UsbDevices devices) {
    _devices.value = devices;
  }

  void cacheBleDevices(String devices) {
    _bleDevicesMac.value = devices;
  }

  bool haveUsbDevices() {
    return _devices.value != null;
  }

  bool haveBleDevices() {
    return _bleDevicesMac.value.isNotEmpty;
  }

  /// 是否已经设置好打印机 true-是
  bool isPrinterConnected() {
    var printer = _currentPrinter.value;
    return (printer.connect == ConnectType.usb && haveUsbDevices()) ||
        (printer.connect == ConnectType.ble && haveBleDevices()) ||
        (printer.connect == ConnectType.wifi &&
            StringUtils.isIpAddress(printer.wifiIp.value));
  }

  void toggleShowCode() {
    showCode.value = !showCode.value;
  }

  void saveWifiIp() {
    setWifiIp(wifiIpController.text);
    Get.back(); // 返回上一页
  }
}
