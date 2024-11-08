import 'dart:async';

import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/usb/UsbDevices.dart';
import 'package:universal_printer_flutter/utils/UsbUtils.dart';

import 'ComChooseOption.dart';

class ChooseUsbDeviceDialog extends StatefulWidget {
  String? defaultChooseKey;
  final onItemClick;

  ChooseUsbDeviceDialog(
      {super.key, this.defaultChooseKey, required this.onItemClick});

  @override
  State<ChooseUsbDeviceDialog> createState() => _ChooseUsbDeviceDialogState();
}

class _ChooseUsbDeviceDialogState extends State<ChooseUsbDeviceDialog> {
  late String tempChooseKey;
  final StreamController<List<UsbDevices>> _streamController = StreamController<List<UsbDevices>>();

  @override
  void initState() {
    super.initState();
    tempChooseKey = widget.defaultChooseKey ?? "";
    UsbUtils.onRegisterUsbService().then((value) => {
      _fetchUserDevices()
    }).catchError((onError) => {
      debugPrint(onError)
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    UsbUtils.unRegisterUsbService().then((value) => {
      debugPrint("unRegisterUsbService：$value")
    }).catchError((onError) => {
      debugPrint(onError)
    });
  }

  void _fetchUserDevices() async {
    _streamController.add(List.empty());
    _streamController.add(await UsbUtils.getDevices());
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
              onPressed: () => {_fetchUserDevices()},
              icon: const Icon(Icons.refresh)),
          const Expanded(
            child: Text(
              '选择USB设备',
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
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Text('Data is empty');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      UsbDevices item = snapshot.data![index];
                      return InkWell(
                        onTap: () => {
                          setState(() {
                            tempChooseKey = item.deviceName;
                          }),
                          widget.onItemClick(item.deviceName)
                        },
                        child: ComChooseOption(
                            name: item.deviceName,
                            choose: tempChooseKey == item.deviceName),
                      );
                    });
              }
            }),
      ),
    ]);
  }
}
