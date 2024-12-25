import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/widget/draw/DrawReceiptWidget.dart';

import '../../widget/draw/DrawLabelWidget.dart';

class DarwingPage extends StatelessWidget {
  const DarwingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _convertDrawBodyWidget();
  }

  Widget _convertDrawBodyWidget() {
    List<Widget> tabs = const [Tab(text: '小票'), Tab(text: '标签')];
    List<Widget> tabsChildrenView = [
      const DrawReceiptWidget(),
      const DrawLabelWidget(),
    ];
    return DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: tabs),
            Expanded(child: TabBarView(children: tabsChildrenView))
          ],
        ));
  }
}
