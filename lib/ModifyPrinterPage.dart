import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';
import 'package:universal_printer_flutter/widget/ComOption.dart';

import 'utils/PrinterBeanUtils.dart';

class ModifyPrinterPage extends StatefulWidget {
  const ModifyPrinterPage({super.key});

  @override
  State<StatefulWidget> createState() => _ModifyPrinterPageState();
}

class _ModifyPrinterPageState extends State<ModifyPrinterPage> {
  late MyPrinter myPrinter;

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onSavePressed(BuildContext context) {
    Navigator.pop(context, myPrinter);
  }

  @override
  void initState() {
    super.initState();
    myPrinter = MyPrinter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            leading: IconButton(
              iconSize: 18,
              color: Colors.white,
              icon: const Icon(Icons.arrow_back_ios), // 自定义返回按钮图标
              onPressed: () => _onBackPressed(context),
            ),
            centerTitle: true,
            titleSpacing: 0,
            title: const Text(
              '新建打印机',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.blue,
          )),
      body: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('1. 连接方式'),
                  const SizedBox(height: 4),
                  ComOption(
                      name: '选择连接方式',
                      value: PrinterBeanUtils.convertConnectName(
                          myPrinter.connect)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2. 打印模式'),
                  ComOption(
                      name: '选择打印模式',
                      value:
                          PrinterBeanUtils.convertModelName(myPrinter.model)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('3. SDK策略'),
                  ComOption(
                      name: '选择SDK策略',
                      value: PrinterBeanUtils.convertSDKName(myPrinter.sdk)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('4. 打印机'),
                  ComOption(
                      name: '选择设备',
                      value:
                          PrinterBeanUtils.convertModelName(myPrinter.model)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () => _onSavePressed(context),
            child: const Text(
              '保存并返回',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            )),
      ),
    );
  }
}
