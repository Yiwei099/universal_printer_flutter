import 'package:universal_printer_flutter/constant/Constant.dart';

class MyPrinter {
  static final int TYPE_G = 1;
  static final int TYPE_E = 2;

  String name; //打印机名称
  CommandType model; //指令模式
  ConnectType connect; //连接方式
  String? wifiIp; //局域网IP
  SDK sdk; //SDK策略
  int type = 0;


  MyPrinter({
    this.name = '',
    this.model = CommandType.esc,
    this.connect = ConnectType.usb,
    this.sdk = SDK.GPrinter,
    this.type = 0
  });
}