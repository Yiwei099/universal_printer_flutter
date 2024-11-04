import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/MyPrinterPage.dart';

import 'ModifyPrinterPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const MyPrinterPage(),
    // const ModifyPrinterPage(),
  ];

  // 添加打印机
  void _onAddPrinter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ModifyPrinterPage()),
    );
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
        children: _pages,
      ),
      floatingActionButton: Transform.scale(
        scale: 0.6,
        child: ElevatedButton(
          onPressed: _onAddPrinter,
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
