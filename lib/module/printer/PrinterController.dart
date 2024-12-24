import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';

import '../../bean/ble/BleDevices.dart';
import '../../bean/usb/UsbDevices.dart';
import '../../constant/Constant.dart';
import '../../utils/SharedPreferencesUtils.dart';
import '../../utils/StringUtils.dart';

class PrinterController extends GetxController {
  final _currentPrinter = MyPrinter(id: 0).obs;
  final Rx<UsbDevices?> _devices = Rx(null);
  final Rx<BleDevices?> _bleDevices = Rx(null);
  final TextEditingController wifiIpController = TextEditingController();
  var showCode = false.obs;

  @override
  void onClose() {
    wifiIpController.dispose();
    super.onClose();
  }

  void setCurrentPrinter(MyPrinter printer) {
    if (printer.connect == ConnectType.wifi) {
      //获取已保存的IP地址
      ShapedPreferencesUtils.instance
          .getString(key: printer.id.toString(), defaultValue: '192.168.')
          .then((value) => {
                printer.wifiIp.value = value,
                _currentPrinter.value = printer,
                wifiIpController.text = value
              });
    } else {
      _currentPrinter.value = printer;
    }
  }

  void setWifiIp(String ip) {
    _currentPrinter.value.wifiIp.value = ip;
    ShapedPreferencesUtils.instance
        .putString(_currentPrinter.value.id.toString(), ip);
  }

  void cacheUsbDevices(UsbDevices devices) {
    _devices.value = devices;
  }

  void cacheBleDevices(BleDevices devices) {
    _bleDevices.value = devices;
  }

  bool haveUsbDevices() {
    return _devices.value != null;
  }

  bool haveBleDevices() {
    return _bleDevices.value != null;
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
