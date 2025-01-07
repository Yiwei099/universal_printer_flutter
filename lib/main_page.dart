import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/about/about_screen.dart';
import 'package:universal_printer_flutter/module/home_controller.dart';
import 'package:universal_printer_flutter/module/printer/list/printer_list_screen.dart';

import 'module/draw/drawing_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late HomeController _controller;

  @override
  void initState() {
    _controller = Get.put(HomeController());
    super.initState();
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
        body: Obx(() {
          return IndexedStack(
            index: _controller.currentIndex.value,
            children: [
              const MyPrinterPage(),
              const DrawingPage(),
              AboutPage(),
              // const ModifyPrinterPage(),
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.print),
                label: '打印机',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.data_object),
                label: '预览',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts),
                label: '关于',
              ),
            ],
            currentIndex: _controller.currentIndex.value,
            onTap: _controller.changeIndex,
          );
        }));
  }
}
