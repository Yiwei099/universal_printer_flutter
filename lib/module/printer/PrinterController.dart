import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';

import '../../bean/ble/BleDevices.dart';
import '../../bean/usb/UsbDevices.dart';
import '../../constant/Constant.dart';
import '../../utils/StringUtils.dart';

class PrinterController extends GetxController {
  final _currentPrinter = MyPrinter().obs;
  var wifiIp = '192.168.'.obs;
  final Rx<UsbDevices?> _devices = Rx(null);
  final Rx<BleDevices?> _bleDevices = Rx(null);

  void setCurrentPrinter(MyPrinter printer) {
    _currentPrinter.value = printer;
  }

  void setWifiIp(String ip) {
    wifiIp.value = ip;
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
            StringUtils.isIpAddress(wifiIp.value));
  }
}