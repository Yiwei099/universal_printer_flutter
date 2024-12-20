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
              '开发者捷印',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.transparent,
          )),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          MyPrinterPage(),
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
