import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/bean/my_printer.dart';
import 'package:universal_printer_flutter/bean/ble/ble_devices.dart';
import 'package:universal_printer_flutter/bean/usb/usb_devices.dart';
import 'package:universal_printer_flutter/module/printer/printer_controller.dart';
import 'package:universal_printer_flutter/utils/string_utils.dart';
import 'package:universal_printer_flutter/widget/choose_ble_device_dialog.dart';

import '../../../constant/constant.dart';
import '../../../widget/choose_usb_device_dialog.dart';
import '../../../widget/code_block.dart';

class ModifyPrinterPage extends StatefulWidget {
  final MyPrinter myPrinter;

  const ModifyPrinterPage({super.key, required this.myPrinter});

  @override
  State<StatefulWidget> createState() => _ModifyPrinterPageState();
}

class _ModifyPrinterPageState extends State<ModifyPrinterPage> {
  late PrinterController _controller;

  @override
  void initState() {
    _controller = Get.put(PrinterController());
    _controller.setCurrentPrinter(widget.myPrinter);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<PrinterController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            leading: IconButton(
              iconSize: 24,
              icon: const Icon(Icons.arrow_back_ios), // 自定义返回按钮图标
              onPressed: () => _onBackPressed(context),
            ),
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
          )),
      body: SizedBox.expand(
        child: _convertBodyView(context),
      ),
    );
  }

  Widget _convertBodyView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () => {_bindPrinter(context)},
            child: Obx(() {
              return _convertPrinterStatus();
            }),
          ),
          _covertActionView(),
          const SizedBox(height: 10),
          _convertCodeEgView(),
        ],
      ),
    );
  }

  /// 操作按钮区域
  Widget _covertActionView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: () => {_controller.toggleShowCode()},
          label: const Text('详细实现'),
          icon: const Icon(Icons.code_outlined),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 40, right: 40)),
        ),
        TextButton.icon(
          onPressed: _controller.isPrinterConnected() ? () => {} : null,
          label: const Text('发起打印'),
          icon: const Icon(Icons.send),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 40, right: 40),
              disabledForegroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey),
        ),
      ],
    );
  }

  /// 示例代码
  Widget _convertCodeEgView() {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _controller.showCode.value
            ? Column(
                key: ValueKey<bool>(_controller.showCode.value),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CodeBlock(
                        code: StringUtils.getSampleCode(widget.myPrinter)),
                  )
                ],
              )
            : Container(key: ValueKey<bool>(_controller.showCode.value)),
      );
    });
  }

  /// 绑定打印机
  void _bindPrinter(BuildContext context) {
    MyPrinter printer = widget.myPrinter;
    if (printer.connect == ConnectType.usb) {
      // usb
      _showUsbDevicesBottomSheet(
          context: context, onItemClick: (item) => {_onCacheUsbDevices(item)});
    } else if (printer.connect == ConnectType.ble) {
      // 蓝牙
      _showBleDevicesBottomSheet(
          context: context,
          onItemClick: (item) => {_onCacheBleDevices(item), Get.back()});
    } else {
      // 局域网
      _showWifiBottomSheet(context: context);
    }
  }

  /// 打印机状态
  Widget _convertPrinterStatus() {
    bool isConnect = _controller.isPrinterConnected();
    IconData statusIcon = Icons.usb;
    double angle = 0.0;
    if (widget.myPrinter.connect == ConnectType.ble) {
      statusIcon = Icons.bluetooth;
    } else if (widget.myPrinter.connect == ConnectType.wifi) {
      statusIcon = Icons.wifi;
    } else {
      statusIcon = Icons.usb;
      angle = pi / 2;
    }
    String tips = isConnect ? '已绑定' : '未绑定';
    Color statusColor = isConnect ? Colors.blue : Colors.red;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: statusColor,
          child: Transform.rotate(
            angle: angle,
            child: Icon(statusIcon, size: 34, color: Colors.white),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  tips,
                  style: TextStyle(
                      fontSize: 16,
                      color: isConnect ? Colors.green : Colors.red),
                ),
                const Text('···', style: TextStyle(fontSize: 20))
              ],
            )),
        const CircleAvatar(
            radius: 40,
            child: Icon(Icons.print_outlined, size: 34, color: Colors.white)),
      ],
    );
  }

  /// 返回
  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  /// 缓存USB设备
  void _onCacheUsbDevices(UsbDevices devices) {
    _controller.cacheUsbDevices(devices);
  }

  /// 缓存蓝牙设备
  void _onCacheBleDevices(String mac) {
    _controller.cacheBleDevices(mac);
  }

  /// 显示设置 wifi 设备 ip 地址
  void _showWifiBottomSheet({required BuildContext context}) {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => {_onBackPressed(context)},
                child: const Text('取消'),
              ),
              const Expanded(
                child: Text(
                  'Wifi 设备',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () => {_controller.saveWifiIp()},
                child: const Text('确定'),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 40, right: 40, bottom: 100),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _controller.wifiIpController,
                      decoration: const InputDecoration(
                        labelText: '请输入IP地址',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '支持IPv6',
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    )
                  ]))
        ],
      ),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      barrierColor: Colors.white54,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }

  /// 显示 USB 设备列表
  void _showUsbDevicesBottomSheet({
    required BuildContext context,
    required onItemClick,
  }) {
    Get.bottomSheet(
      ChooseUsbDeviceDialog(onItemClick: onItemClick),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      barrierColor: Colors.white54,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }

  /// 显示 蓝牙 设备列表
  void _showBleDevicesBottomSheet({
    required BuildContext context,
    required onItemClick,
  }) {
    Get.bottomSheet(
      ChooseBleDeviceDialog(onItemClick: onItemClick,defaultChooseKey: _controller.bleDevicesMac,),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      barrierColor: Colors.white54,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }
}
