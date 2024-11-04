import 'package:flutter/material.dart';

class ModifyPrinterPage extends StatelessWidget {
  const ModifyPrinterPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSavePressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            leading: IconButton(
              iconSize: 18,
              color: Colors.white,
              icon: const Icon(Icons.arrow_back_ios), // 自定义返回按钮图标
              onPressed: () => _onBackPressed(context),
            ),
            centerTitle: true,
            titleSpacing: 0,
            title: const Text(
              '新建打印机',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.blue,
          )),
      body: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: const [
              Column(
                children: [
                  Text('连接方式'),
                  Row(
                    children: [
                      Text('1. 选择连接方式'),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text('打印模式'),
                  Row(
                    children: [
                      Text('2. 选择打印模式'),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text('SDK策略'),
                  Row(
                    children: [
                      Text('3. 选择SDK策略'),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text('打印机'),
                  Row(
                    children: [
                      Text('4. 选择 USB 设备'),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text('连接方式'),
                  Row(
                    children: [
                      Text('1. 选择连接方式'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () => _onSavePressed(context),
            child: const Text(
              '保存并返回',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            )),
      ),
    );
  }
}
