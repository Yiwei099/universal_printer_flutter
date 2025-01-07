import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/draw/canvas/canvas_option_widget.dart';
import 'package:universal_printer_flutter/module/draw/source/draw_element_widget.dart';

class DrawOptionsScreen extends StatelessWidget {
  const DrawOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            leading: IconButton(
              iconSize: 24,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
            centerTitle: true,
            title: const Text('参数设置', style: TextStyle(fontSize: 16)),
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
          )),
      body: SizedBox.expand(
        child: _convertDrawBodyWidget(),
      ),
    );
  }

  Widget _convertDrawBodyWidget() {
    List<Widget> tabs = const [Tab(text: '图像'), Tab(text: '元素')];
    List<Widget> tabsChildrenView = [
      const CanvasOptionWidget(),
      const DrawElementWidget(),
    ];
    return DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(indicatorSize: TabBarIndicatorSize.tab, tabs: tabs),
            Expanded(child: TabBarView(children: tabsChildrenView))
          ],
        ));
  }
}
