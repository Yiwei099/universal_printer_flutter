import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/MyPrinterPage.dart';

import 'ModifyPrinterPage.dart';
import 'bean/MyPrinter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<MyPrinter> printer = [];

  void _onAddPrinterResult({MyPrinter? myPrinter, int index = 0}) {
    setState(() {
      if (myPrinter != null) {
        printer.add(myPrinter);
      } else {
        printer.removeAt(index);
      }
    });
  }

  // 添加打印机
  void _onAddPrinter({required BuildContext context, MyPrinter? printer}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ModifyPrinterPage(myPrinter: printer)),
    );
    if (result != null) {
      _onAddPrinterResult(myPrinter: result);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            centerTitle: true,
            titleSpacing: 0,
            title: const Text(
              '掌上打印',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.blue,
          )),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MyPrinterPage(
            initialPrinter: printer,
            go2AddPrinter: (printer) => {
              _onAddPrinter(context: context,printer: printer)
            },
          ),
          // const ModifyPrinterPage(),
        ],
      ),
      floatingActionButton: Transform.scale(
        scale: 0.6,
        child: ElevatedButton(
          onPressed: () => _onAddPrinter(context: context),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.blue, // 按钮背景颜色
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '打印机',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            label: '数据源',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '关于',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
