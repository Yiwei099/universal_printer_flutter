import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';

class MyPrinterPage extends StatefulWidget {

  final List<MyPrinter> initialPrinter;
  final go2AddPrinter;

  const MyPrinterPage({super.key,
    required this.initialPrinter,
    required this.go2AddPrinter
  });

  @override
  State<MyPrinterPage> createState() => _MyPrinterPageState();
}

class _MyPrinterPageState extends State<MyPrinterPage> {
  List<MyPrinter> printerList = [];

  @override
  void initState() {
    super.initState();
    //对象引用
    printerList = widget.initialPrinter;
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
            margin: const EdgeInsets.only(left: 10,top: 4,bottom: 4,right: 10),
            child: InkWell(
              onTap: () => widget.go2AddPrinter(printerList[index]),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,top: 4,bottom: 4,right: 0),
                child: Row(
                  children: [
                    const Icon(Icons.print,size: 16),
                    const SizedBox(width: 10),
                    Expanded(child: Text(printerList[index].name)),
                    IconButton(
                        onPressed: () => {
                          _removeItem(index)
                        },
                        iconSize: 16,
                        icon: const Icon(Icons.delete)
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _convertMyPrinterWidget();
  }
}
