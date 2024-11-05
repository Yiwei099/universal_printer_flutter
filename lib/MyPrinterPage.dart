import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';

class MyPrinterPage extends StatefulWidget {
  late List<MyPrinter> printerList = [];

  MyPrinterPage({super.key});

  void addPrinter(MyPrinter printer) {
    printerList.add(printer);
  }

  @override
  State<MyPrinterPage> createState() => _MyPrinterPageState();
}

class _MyPrinterPageState extends State<MyPrinterPage> {

  void setPrinterList(List<MyPrinter> printerList) {
    setState(() {
      widget.printerList = printerList;
    });
  }

  Widget _convertMyPrinterWidget() {
    if (widget.printerList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: const Text('先去添加一台打印机吧'),
      );
    }

    return ListView.builder(
        itemCount: widget.printerList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text('$index 号打印机'),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _convertMyPrinterWidget();
  }
}
