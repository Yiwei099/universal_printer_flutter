import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // 添加打印机
  void _onAddPrinter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '添加一台打印机试试吧',
            ),
          ],
        ),
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
      ),
    );
  }
}
