import 'package:universal_printer_flutter/constant/Constant.dart';

class MyPrinter {
  String name; //打印机名称
  CommandType model; //指令模式
  ConnectType connect; //连接方式
  Paper paper; //纸张尺寸
  String? wifiIp; //局域网IP


  MyPrinter({
    required this.name,
    this.model = CommandType.esc,
    this.connect = ConnectType.usb,
    this.paper = Paper.esc58,

  });
}