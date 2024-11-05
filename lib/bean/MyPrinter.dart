import 'package:universal_printer_flutter/constant/Constant.dart';

class MyPrinter {
  String name; //打印机名称
  CommandType model; //指令模式
  ConnectType connect; //连接方式
  String? wifiIp; //局域网IP
  SDK sdk; //SDK策略


  MyPrinter({
    this.name = '',
    this.model = CommandType.esc,
    this.connect = ConnectType.usb,
    this.sdk = SDK.GPrinter,
  });
}