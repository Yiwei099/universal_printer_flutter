import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_printer_flutter/bean/ble/BleDevices.dart';
import 'package:universal_printer_flutter/utils/ChannelUtils.dart';

import 'ComChooseOption.dart';

class ChooseBleDeviceDialog extends StatefulWidget {
  String? defaultChooseKey;
  final onItemClick;

  ChooseBleDeviceDialog(
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

    ChannelUtils.setupMethodCallHandler((call) async {
      if (call.method == ChannelUtils.ON_DEVICE_FOUND) {
        setState(() {
          devices.add(BleDevices.fromJson(json.decode(call.arguments)));
        });
      } else if (call.method == ChannelUtils.BLE_DISCOVERY_STATE_CALL_BACK) {
        setState(() {
          scanning = call.arguments;
        });
      }
    });

    ChannelUtils.onRegisterBleService()
        .then((value) async => {
              await ChannelUtils.discoveryBleDevices(),
            })
        .catchError((onError) => {debugPrint(onError)});
  }

  void _changeDiscovery() async {
    bool result = scanning;
    if (scanning) {
      result = await ChannelUtils.stopDiscoveryBleDevices();
    } else {
      result = await ChannelUtils.startDiscoveryBleDevices();
    }

    setState(() {
      scanning = result;
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
    ChannelUtils.clearMethodCallHandler();
    ChannelUtils.unRegisterBleService()
        .then((value) => {debugPrint("unRegisterBleService：$value")})
        .catchError((onError) => {debugPrint(onError)});
  }

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
              onPressed: () => {
                _changeDiscovery()
              },
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
