import 'dart:math';

import 'package:universal_printer_flutter/bean/my_printer.dart';
import 'package:universal_printer_flutter/constant/constant.dart';

class StringUtils {
  static String getChineseString(int length) {
    final random = Random();
    const int minCodePoint = 0x4e00; // 中文字符的起始 Unicode 编码
    const int maxCodePoint = 0x9fa5; // 中文字符的结束 Unicode 编码

    return List.generate(length, (index) {
      int codePoint = minCodePoint + random.nextInt(maxCodePoint - minCodePoint + 1);
      return String.fromCharCode(codePoint);
    }).join();
  }

  static bool isIpAddress(String ip) {
    return isIpv4(ip) || isIpv6(ip);
  }

  static bool isIpv4(String ip) {
    String ipv4Pattern = r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';
    return RegExp(ipv4Pattern).hasMatch(ip);
  }

  static bool isIpv6(String ip) {
    String ipv6PatternFull = r'^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$';
    return RegExp(ipv6PatternFull).hasMatch(ip);
  }

  static String getSampleCode(MyPrinter p) {
    if (p.sdk == SDK.GPrinter) {
      return '''
//局域网通讯
val key = "192.168.100.150"
//打印Esc
val printer = EscNetGPrinter(context, netKey)
//打印Tsc
val printer = TscNetGPrinter(context,netKey)

//USB通讯(SerialNumber为可选)
val usbKey = "vendorId+productId+SerialNumber"
//打印Esc
val printer = EscUsbGPrinter(context,vendorId,productId,serialNumber)
//打印Tsc
val printer = TscUsbGPrinter(context,vendorId,productId,serialNumber)

//蓝牙通讯
val macAddress = "66:22:E2:4C:CB:DD"
//打印Esc
val printer = EscBtGPrinter(context,macAddress)
//打印Tsc
val printer = TscBtGPrinter(context,macAddress)

//未明确指令类型

//自己打印机校验指令的指令
val command :ByteArray = ByteArray()
val unknowBtPrinter = UnKnowBtGPrinter(context,address,command){
    //...解析打印机返回数据，获取指令类型，并返回指令类型告知打印机
    return when(data){
        ...-> Command.Esc
        ...-> Command.Tsc
        else-> null
    }
}

// 释放资源
printer.onDestroy()
                    ''';
    }

    if (p.sdk == SDK.EPson) {
      return '''
//通讯方式：局域网/USB/蓝牙
val interface = Net/Usb/BlueTooth

//通讯地址：局域网IP/USB地址/蓝牙地址
val target = "192.168.0.1"

//创建打印机，必要时可指定Epson打印机的型号
val printer = EpsonPrinter(context,interface,target)

//以图片的形式打印
//从 1.2.0 或1.2.0-Alpha版本开始，如果您的标签内容高度非自适应则需要指定标签高度
val mission = GraphicMission(
                bitmapArray,
                bitmapHeight:Int = 30,//标签高度
                bitmapWidth:Int = 40,//标签宽度
                selfAdaptionHeight:Boolean = false,//固定高度
              )

//以SDK指令形式打印
val mission = EpsonMission(
                mutableListOf<BaseEpsonMissionParam>().apply {
                    add(CommandMissionParam(getOpenBoxCommandByByteArray()))
                }
              )

//调用addMission即可
printer.addMission(mission)

// 释放资源
printer.onDestroy()
      ''';
    }
    return '''''';
  }

  static String getSampleCodePrintSupport() {
    return '''
仓库及更详细说明地址：
https://github.com/Yiwei099/PrintSupport

//必须
com.github.Yiwei099.PrintSupport:libcommon:releaseVersion
//只使用佳博SDK
com.github.Yiwei099.PrintSupport:GPrinter:releaseVersion
//只使用爱普森SDK
com.github.Yiwei099.PrintSupport:Epson:releaseVersion
//只是用必胜龙SDK
com.github.Yiwei099.PrintSupport:Bixolon:releaseVersion
//以上三个都使用
com.github.Yiwei099.PrintSupport:releaseVersion
    ''';
  }

  static String getSampleCodeDrawSupport() {
    return '''
仓库及更详细说明地址：
https://github.com/Yiwei099/DrawingSupport

com.github.Yiwei099:DrawingSupport:releaseVersion
    ''';
  }

}