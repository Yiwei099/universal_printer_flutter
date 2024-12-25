
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberActionWidget extends StatefulWidget {
  int value; // 默认值
  int min = 0; // 最小值
  int max = 100; // 最大值
  Function(int) listener;  // 回调

  NumberActionWidget(
      {super.key,
      required this.value,
      required this.listener,
      this.min = 0,
      this.max = 100});

  @override
  State<NumberActionWidget> createState() => _NumberActionWidgetState();
}

class _NumberActionWidgetState extends State<NumberActionWidget> {
  @override
  Widget build(BuildContext context) {
    return _convertContentWidget();
  }

  Widget _convertContentWidget() {
    bool enableRemove = widget.value > widget.min;
    bool enableAdd = widget.value < widget.max;

    return Row(
      children: [
        IconButton(
            onPressed: enableRemove ? () => {
              widget.listener(widget.value - 2)
            } : null,
            icon: Icon(Icons.remove_circle, color: enableRemove ? Get.theme.primaryColor : Colors.grey),),
        const SizedBox(
          width: 10,
        ),
        Text(widget.value.toString()),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: enableAdd ? () => {
              widget.listener(widget.value + 2)
            } : null,
            icon: Icon(Icons.add_circle, color: enableAdd ? Get.theme.primaryColor : Colors.grey)),
      ],
    );
  }
}
