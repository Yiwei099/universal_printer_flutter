import 'package:get/get.dart';
import 'package:universal_printer_flutter/constant/Constant.dart';

class MyPrinter {
  static const int TYPE_G = 1;
  static const int TYPE_E = 2;

  int id;
  String name; //打印机名称
  CommandType model; //指令模式
  ConnectType connect; //连接方式
  RxString wifiIp = '192.168.'.obs; //局域网IP
  SDK sdk; //SDK策略
  int type = 0;


  MyPrinter({
    required this.id,
    this.name = '',
    this.model = CommandType.esc,
    this.connect = ConnectType.usb,
    this.sdk = SDK.GPrinter,
    this.type = 0
  });
}