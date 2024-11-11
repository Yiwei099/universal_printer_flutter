import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';
import 'package:universal_printer_flutter/utils/PrinterBeanUtils.dart';

import 'constant/Constant.dart';

class MyPrinterPage extends StatefulWidget {
  final List<MyPrinter> initialPrinter;
  final go2AddPrinter;

  const MyPrinterPage(
      {super.key, required this.initialPrinter, required this.go2AddPrinter});

  @override
  State<MyPrinterPage> createState() => _MyPrinterPageState();
}

class _MyPrinterPageState extends State<MyPrinterPage> {
  List<MyPrinter> printerList = [];

  @override
  void initState() {
    super.initState();
    //对象引用
    // printerList = widget.initialPrinter;

    List<MyPrinter> gPrinterList = PrinterBeanUtils.getDefaultGPrinter();

    if (gPrinterList.isNotEmpty) {
      printerList.add(MyPrinter(type: MyPrinter.TYPE_G));
      printerList.addAll(gPrinterList);
    }

    List<MyPrinter> ePrinterList = PrinterBeanUtils.getDefaultEPrinter();

    if (ePrinterList.isNotEmpty) {
      printerList.add(MyPrinter(type: MyPrinter.TYPE_E));
      printerList.addAll(ePrinterList);
    }
  }

  // 删除项的方法
  void _removeItem(int index) {
    setState(() {
      printerList.removeAt(index);
    });
  }

  Widget _convertMyPrinterWidget() {
    if (printerList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: const Text('先去添加一台打印机吧'),
      );
    }

    return ListView.builder(
        itemCount: printerList.length,
        itemBuilder: (context, index) {
          return Card(
            margin:
                const EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 10),
            child: InkWell(
              onTap: () => widget.go2AddPrinter(printerList[index]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 4, bottom: 4, right: 0),
                child: Row(
                  children: [
                    const Icon(Icons.print, size: 16),
                    const SizedBox(width: 10),
                    Expanded(child: Text(printerList[index].name)),
                    IconButton(
                        onPressed: () => {_removeItem(index)},
                        iconSize: 16,
                        icon: const Icon(Icons.delete))
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _convertPrinterListWidget() {
    return ListView.builder(
        itemCount: printerList.length,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
              child: _convertPrinterClass(printerList[index]));
        });
  }

  Widget _convertPrinterClass(MyPrinter item) {
    if (item.type == MyPrinter.TYPE_G) {
      return Row(
        children: [
          Container(
              width: 4,
              height: 20,
              color: Colors.blue,
              padding: const EdgeInsets.only(right: 10)),
          const SizedBox(width: 6, height: 0),
          const Text('佳博', style: TextStyle(fontSize: 18))
        ],
      );
    } else if (item.type == MyPrinter.TYPE_E) {
      return Row(
        children: [
          Container(
              width: 4,
              height: 20,
              color: Colors.blue,
              padding: const EdgeInsets.only(right: 10)),
          const SizedBox(width: 6, height: 0),
          const Text('爱普森', style: TextStyle(fontSize: 18))
        ],
      );
    } else {
      bool esc = item.model == CommandType.esc;
      return Row(
        children: [
          Text(item.name, style: const TextStyle(fontSize: 18)),
          const SizedBox(
            width: 20,
          ),
          Text(
            esc ? '小票' : '标签',
            style: TextStyle(
                backgroundColor: esc ? Colors.orange : Colors.green,
                foreground: Paint()..color = Colors.white),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (printerList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: const Text('先去添加一台打印机吧'),
      );
    } else {
      return _convertPrinterListWidget();
    }
  }
}
