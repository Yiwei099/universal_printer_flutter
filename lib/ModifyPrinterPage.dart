import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/Item.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';
import 'package:universal_printer_flutter/utils/StringUtils.dart';
import 'package:universal_printer_flutter/widget/ComOption.dart';

import 'constant/Constant.dart';
import 'utils/PrinterBeanUtils.dart';
import 'widget/BottomSheetChooseDialog.dart';

class ModifyPrinterPage extends StatefulWidget {
  final MyPrinter? myPrinter;

  const ModifyPrinterPage({super.key, this.myPrinter});

  @override
  State<StatefulWidget> createState() => _ModifyPrinterPageState();
}

class _ModifyPrinterPageState extends State<ModifyPrinterPage> {
  late MyPrinter myPrinter;

  @override
  void initState() {
    super.initState();
    myPrinter =
        widget.myPrinter ?? MyPrinter(name: StringUtils.getChineseString(3));
  }

  void _notifyPrinterConnect(ConnectType item) {
    setState(() {
      myPrinter.connect = item;
    });
  }

  void _notifyPrinterCommand(CommandType item) {
    setState(() {
      myPrinter.model = item;
    });
  }

  void _notifyPrinterSDK(SDK item) {
    setState(() {
      myPrinter.sdk = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
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
            title: Text(
              myPrinter.name.isNotEmpty ? myPrinter.name : '新建打印机',
              style: const TextStyle(
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
                  InkWell(
                    onTap: () => {
                      _showBottomSheet<ConnectType>(
                          context,
                          '选择连接方式',
                          myPrinter.connect,
                          PrinterBeanUtils.getConnectItemList(),
                          (item) => {
                                _notifyPrinterConnect(item),
                                Navigator.pop(context)
                              })
                    },
                    child: ComOption(
                        name: '选择连接方式',
                        value: PrinterBeanUtils.convertConnectName(
                            myPrinter.connect)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2. 打印模式'),
                  InkWell(
                    onTap: () => {
                      _showBottomSheet<CommandType>(
                          context,
                          '选择打印模式',
                          myPrinter.model,
                          PrinterBeanUtils.getModelItemList(),
                          (item) => {
                                _notifyPrinterCommand(item),
                                Navigator.pop(context)
                              })
                    },
                    child: ComOption(
                      name: '选择打印模式',
                      value: PrinterBeanUtils.convertModelName(myPrinter.model),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('3. SDK策略'),
                  InkWell(
                    onTap: () => {
                      _showBottomSheet<SDK>(
                          context,
                          '选择SDK策略',
                          myPrinter.sdk,
                          PrinterBeanUtils.getSDKItemList(),
                          (item) =>
                              {_notifyPrinterSDK(item), Navigator.pop(context)})
                    },
                    child: ComOption(
                        name: '选择SDK策略',
                        value: PrinterBeanUtils.convertSDKName(myPrinter.sdk)),
                  ),
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

  /// 返回
  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  /// 保存并返回
  void _onSavePressed(BuildContext context) {
    Navigator.pop(context, myPrinter);
  }

  void _showBottomSheet<T>(
    BuildContext context,
    String title,
    T chooseKey,
    List<Item<T>> data,
    onItemClick,
  ) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return BottomSheetChooseListDialog<T>(
            title: title,
            defaultChooseKey: chooseKey,
            data: data,
            onItemClick: onItemClick);
      },
    );
  }
}
