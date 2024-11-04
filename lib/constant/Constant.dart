enum CommandType {
  esc, //小票
  tsc, //标签
}

enum CommandBuild {
  command, //指令模式
  image, //图片模式
}

enum ConnectType {
  usb, //usb
  ble, //蓝牙
  wifi, //局域网
}

enum Paper {
  esc58, // 58 mm
  esc80, // 80mm
  tsc3020, //30*20
  tsc4030, //40*30
  tsc4060, //40*60
  tsc4080, //40*80
  tsc6040, //60*40
}

enum SDK {
  GPrinter, //佳博
  EPson, //爱普生
}
