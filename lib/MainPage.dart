import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:universal_printer_flutter/module/about/AboutScreen.dart';
import 'package:universal_printer_flutter/module/printer/list/PrinterListScreen.dart';
import 'package:universal_printer_flutter/utils/SharedPreferencesUtils.dart';

import 'module/draw/DrawingScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

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
            backgroundColor: Colors.transparent,
            title: const Text(
              '开发者捷印',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          MyPrinterPage(),
          DarwingPage(),
          AboutPage(),
          // const ModifyPrinterPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            label: '打印机',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_object),
            label: '数据源',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: '关于',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
