
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/printer/detail/PrinterDetailScreen.dart';
import 'package:universal_printer_flutter/bean/MyPrinter.dart';
import 'package:universal_printer_flutter/utils/PrinterBeanUtils.dart';

import '../../../constant/Constant.dart';
import 'dart:math';

class MyPrinterPage extends StatelessWidget {
  const MyPrinterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _convertPrinterListWidget();
  }

  /// 绘制容器视图 - TabView
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
            TabBar(
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                tabs: tabs),
            Expanded(child: TabBarView(children: tabsChildrenView))
          ],
        ));
  }

  /// 绘制列表宫格
  Widget _convertPrinterGridView(List<MyPrinter> printerList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 每行显示2个网格项
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: printerList.length,
      itemBuilder: (context, index) {
        return _convertPrinterGridItem(context, printerList[index], index);
      },
    );
  }

  /// 绘制列表 Item
  Widget _convertPrinterGridItem(
      BuildContext context, MyPrinter printer, int index) {
    IconData icons = Icons.usb;
    double angle = 0.0;
    if (printer.connect == ConnectType.ble) {
      icons = Icons.bluetooth;
    } else if (printer.connect == ConnectType.wifi) {
      icons = Icons.wifi;
    } else {
      icons = Icons.usb;
      angle = pi / 2;
    }

    IconData icon2 = Icons.receipt_long_outlined;
    if (printer.model == CommandType.tsc) {
      icon2 = Icons.label_outline;
    }
    return Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => {go2PrinterDetail(printer)},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // 设置圆角半径
            ),
            elevation: 5.0, // 设置阴影高度
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: angle,
                  child: Icon(
                    icons,
                    size: 26,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('·', style: TextStyle(fontSize: 36)),
                ),
                Icon(
                  icon2,
                  size: 26,
                ),
              ],
            ),
          ),
        ));
  }

  /// 跳转到打印机详情
  void go2PrinterDetail(MyPrinter printer) {
    // 传递参数
    Get.to(ModifyPrinterPage(
      myPrinter: printer,
    ));
  }
}
