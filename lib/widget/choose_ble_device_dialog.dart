import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/ble/ble_devices.dart';
import 'package:universal_printer_flutter/utils/channel_utils.dart';

import 'com_choose_option.dart';

class ChooseBleDeviceDialog extends StatefulWidget {
  final String? defaultChooseKey;
  final Function(String) onItemClick;

  const ChooseBleDeviceDialog(
      {super.key, this.defaultChooseKey, required this.onItemClick});

  @override
  State<ChooseBleDeviceDialog> createState() => _ChooseBleDeviceDialogState();
}

class _ChooseBleDeviceDialogState extends State<ChooseBleDeviceDialog> {
  late String tempChooseKey;
  bool scanning = false;
  final Set<BleDevices> devices = {};

  @override
  void initState() {
    super.initState();
    tempChooseKey = widget.defaultChooseKey ?? "";
    //注册 Channel 回调
    ChannelUtils.setupMethodCallHandler((call) async {
      if (call.method == ChannelUtils.ON_DEVICE_FOUND) {
        // Navigate 返回扫描到的设备
        setState(() {
          devices.add(BleDevices.fromJson(json.decode(call.arguments)));
        });
      } else if (call.method == ChannelUtils.BLE_DISCOVERY_STATE_CALL_BACK) {
        // Navigate 返回的 BLE 扫描状态
        setState(() {
          scanning = call.arguments;
        });
      }
    });

    //注册 BLE 服务
    ChannelUtils.onRegisterBleService()
        .then((value) async => {
              //注册成功开始扫描
              await ChannelUtils.discoveryBleDevices(),
            })
        .catchError((onError) => debugPrint(onError));
  }

  /// 开始扫描或停止扫描
  void _changeDiscovery() async {
    bool result = scanning;
    if (scanning) {
      result = await ChannelUtils.stopDiscoveryBleDevices();
    } else {
      result = await ChannelUtils.startDiscoveryBleDevices();
    }

    if(result != scanning) {
      //状态改变成功才执行
      setState(() {
        scanning = result;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    //移除 Channel 回调
    ChannelUtils.clearMethodCallHandler();
    // 销毁 BLE 服务
    ChannelUtils.unRegisterBleService()
        .then((value) => {debugPrint("unRegisterBleService：$value")})
        .catchError((onError) => {debugPrint(onError)});
  }

  /// 将 ble 设备 转换为 Widget
  Widget _convertListDataToWidget() {
    if (devices.isEmpty) {
      return const Text('Not discovery bleTooth devices');
    }
    List<BleDevices> bleDevices = devices.toList();
    return ListView.builder(
        itemCount: bleDevices.length,
        itemBuilder: (BuildContext context, int index) {
          BleDevices item = bleDevices[index];
          return InkWell(
            onTap: () => {
              setState(() {
                tempChooseKey = item.address;
              }),
              widget.onItemClick(item.address)
            },
            child: ComChooseOption(
                name: '${item.deviceName}-${item.address}',
                choose: tempChooseKey == item.address),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () => {_changeDiscovery()},
            icon: Icon(scanning ? Icons.stop : Icons.play_arrow),
          ),
          const Expanded(
            child: Text(
              '选择蓝牙设备',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 16.0),
          IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: const Icon(Icons.close))
          // _convertBottomSheetWidget(data),
        ],
      ),
      Expanded(
        child: _convertListDataToWidget(),
      ),
    ]);
  }
}
