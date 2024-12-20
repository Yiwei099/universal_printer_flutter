import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';
import 'package:universal_printer_flutter/utils/PrinterBeanUtils.dart';

import 'constant/Constant.dart';

class MyPrinterPage extends StatelessWidget {
  const MyPrinterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _convertPrinterListWidget();
  }

  Widget _convertPrinterGridItem(MyPrinter printer, int index) {
    String fullName = PrinterBeanUtils.convertModelName(printer.model);
    IconData icons = Icons.usb;
    if (printer.connect == ConnectType.ble) {
      icons = Icons.bluetooth;
    } else if (printer.connect == ConnectType.wifi) {
      icons = Icons.wifi;
    } else {
      icons = Icons.usb;
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // 设置圆角半径
        ),
        elevation: 5.0, // 设置阴影高度
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icons,
              size: 26,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              fullName,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget _convertPrinterGridView(List<MyPrinter> printerList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 每行显示2个网格项
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: printerList.length,
      itemBuilder: (context, index) {
        return _convertPrinterGridItem(printerList[index], index);
      },
    );
  }

  Widget _convertPrinterListWidget() {
    List<Widget> tabs = const [Tab(text: '佳博'), Tab(text: '爱普森')];

    List<Widget> tabsChildrenView = [
      _convertPrinterGridView(PrinterBeanUtils.getDefaultGPrinter()),
      _convertPrinterGridView(PrinterBeanUtils.getDefaultEPrinter())
    ];

    return DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(tabs: tabs),
            Expanded(child: TabBarView(children: tabsChildrenView))
          ],
        ));
  }
}
