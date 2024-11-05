import 'package:universal_printer_flutter/constant/Constant.dart';

class PrinterBeanUtils {

  static String convertModelName(CommandType model) {
    if(model == CommandType.esc) {
      return '小票';
    } else if (model == CommandType.tsc) {
      return '标签';
    } else {
      return '';
    }
  }

  static String convertConnectName(ConnectType type) {
    if(type == ConnectType.usb) {
      return 'USB';
    } else if (type == ConnectType.ble) {
      return '蓝牙';
    } else if (type == ConnectType.wifi) {
      return '局域网';
    }
    return '';
  }

  static String convertSDKName(SDK sdk) {
    if(sdk == SDK.GPrinter) {
      return '佳博';
    } else if (sdk == SDK.EPson) {
      return '爱普生';
    }
    return '';
  }
}