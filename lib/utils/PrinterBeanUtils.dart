import 'package:universal_printer_flutter/bean/Item.dart';
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

  static List<Item<CommandType>> getModelItemList() {
    return [
      Item<CommandType>(key: CommandType.esc, name: '小票'),
      Item<CommandType>(key: CommandType.tsc, name: '标签'),
    ];
  }

  static List<Item<ConnectType>> getConnectItemList() {
    return [
      Item<ConnectType>(key: ConnectType.usb, name: 'USB'),
      Item<ConnectType>(key: ConnectType.ble, name: '蓝牙'),
      Item<ConnectType>(key: ConnectType.wifi, name: '局域网'),
    ];
  }

  static List<Item<SDK>> getSDKItemList() {
    return [
      Item<SDK>(key: SDK.GPrinter, name: '佳博'),
      Item<SDK>(key: SDK.EPson, name: '爱普生'),
    ];
  }
}