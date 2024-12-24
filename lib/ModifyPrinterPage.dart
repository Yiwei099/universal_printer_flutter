import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/Item.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';
import 'package:universal_printer_flutter/bean/ble/BleDevices.dart';
import 'package:universal_printer_flutter/bean/usb/UsbDevices.dart';
import 'package:universal_printer_flutter/utils/StringUtils.dart';
import 'package:universal_printer_flutter/utils/ChannelUtils.dart';
import 'package:universal_printer_flutter/utils/ToastUtils.dart';
import 'package:universal_printer_flutter/widget/ComOption.dart';
import 'package:universal_printer_flutter/widget/chooseBleDeviceDialog.dart';

import 'constant/Constant.dart';
import 'utils/PrinterBeanUtils.dart';
import 'widget/BottomSheetChooseDialog.dart';
import 'widget/ChooseUsbDeviceDialog.dart';
import 'dart:math';

import 'widget/CodeBlock.dart';

class ModifyPrinterPage extends StatefulWidget {
  final MyPrinter myPrinter;

  const ModifyPrinterPage({super.key, required this.myPrinter});

  @override
  State<StatefulWidget> createState() => _ModifyPrinterPageState();
}

class _ModifyPrinterPageState extends State<ModifyPrinterPage> {
  UsbDevices? _devices = null;
  BleDevices? _bleDevices = null;
  String wifiDevicesIp = "192.168.";
  bool showCode = false;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = wifiDevicesIp;
  }

  @override
  void dispose() {
    _controller.dispose();
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
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_ios), // 自定义返回按钮图标
              onPressed: () => _onBackPressed(context),
            ),
            // centerTitle: true,
            titleSpacing: 0,
            // title: const Text(
            //   '打印机详情',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 16,
            //   ),
            // ),
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
            child: _convertPrinterStatus(),
          ),
          // const SizedBox(height: 10),
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
          onPressed: () => {
            setState(() {
              showCode = !showCode;
            })
          },
          label: const Text('详细实现'),
          icon: const Icon(Icons.code_outlined, color: Colors.white),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 40, right: 40),
              disabledForegroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white),
        ),
        TextButton.icon(
          onPressed: _isPrinterConnected() ? () => {} : null,
          label: const Text('发起打印'),
          icon: const Icon(Icons.send, color: Colors.white),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 40, right: 40),
              disabledForegroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white),
        ),
      ],
    );
  }

  /// 示例代码
  Widget _convertCodeEgView() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: showCode
          ? Column(
        key: ValueKey<bool>(showCode),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CodeBlock(code: StringUtils.getSampleCode(widget.myPrinter)),
          )
        ],
      )
          : Container(key: ValueKey<bool>(showCode)),
    );
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
          context: context, onItemClick: (item) => {_onCacheBleDevices(item)});
    } else {
      // 局域网
      _showWifiBottomSheet(context: context);
    }
  }

  /// 是否已经设置好打印机 true-是
  bool _isPrinterConnected() {
    return (widget.myPrinter.connect == ConnectType.usb && _devices != null) ||
        (widget.myPrinter.connect == ConnectType.ble && _bleDevices != null) ||
        (widget.myPrinter.connect == ConnectType.wifi &&
            StringUtils.isIpAddress(wifiDevicesIp));
  }

  /// 打印机状态
  Widget _convertPrinterStatus() {
    bool isConnect = _isPrinterConnected();
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
            backgroundColor: Colors.blue,
            child: Icon(Icons.print_outlined, size: 34, color: Colors.white)),
      ],
    );
  }

  /// 返回
  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  /// 缓存 IP 地址
  void _onSaveWifiIp(BuildContext context) {
    // if (!StringUtils.isIpAddress(_controller.text)) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('IP地址不正确')),
    //   );
    //   // ToastUtils.showToast('IP地址不正确');
    //   return;
    // }
    setState(() {
      wifiDevicesIp = _controller.text;
    });
    _onBackPressed(context);
  }

  /// 缓存USB设备
  void _onCacheUsbDevices(UsbDevices devices) {
    setState(() {
      _devices = devices;
    });
  }

  /// 缓存蓝牙设备
  void _onCacheBleDevices(BleDevices devices) {
    setState(() {
      _bleDevices = devices;
    });
  }

  /// 显示设置 wifi 设备 ip 地址
  void _showWifiBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return Column(
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
                  onPressed: () => {_onSaveWifiIp(context)},
                  child: const Text('确定', style: TextStyle(color: Colors.blue)),
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
                        controller: _controller,
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
        );
      },
    );
  }

  /// 显示 USB 设备列表
  void _showUsbDevicesBottomSheet({
    required BuildContext context,
    required onItemClick,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return ChooseUsbDeviceDialog(onItemClick: onItemClick);
      },
    );
  }

  /// 显示 蓝牙 设备列表
  void _showBleDevicesBottomSheet({
    required BuildContext context,
    required onItemClick,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return ChooseBleDeviceDialog(onItemClick: onItemClick);
      },
    );
  }
}
