import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/draw/source/draw_element_controller.dart';

class ElementListWidget extends StatefulWidget {
  const ElementListWidget({super.key});

  @override
  State<ElementListWidget> createState() => _ElementListWidgetState();
}

class _ElementListWidgetState extends State<ElementListWidget> {
  late DrawElementController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<DrawElementController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(onPressed: () => {}, icon: const SizedBox()),
          const Expanded(
            child: Text(
              '元素列表',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 16.0),
          IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: const Icon(Icons.close))
          // _convertBottomSheetWidget(data),
        ],
      ),
      Expanded(
        child: Obx(() {
          return _convertListDataToWidget();
        }),
      ),
    ]);
  }

  Widget _convertListDataToWidget() {
    return ListView.builder(
        itemCount: _controller.sourceList.length,
        itemBuilder: (BuildContext context, int index) {
          var item = _controller.sourceList[index];
          return SwipeActionCell(
            /// 这个key是必要的
            key: ValueKey(item),
            trailingActions: <SwipeAction>[
              SwipeAction(
                  title: "移除",
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 16,
                  ),
                  onTap: (CompletionHandler handler) async {
                    _controller.removeElementByIndex(index);
                  },
                  color: Colors.red),
            ],
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                _controller.getElementShowText(item),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        });
  }
}
