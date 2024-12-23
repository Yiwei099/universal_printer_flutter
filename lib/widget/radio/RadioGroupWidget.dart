import 'package:flutter/material.dart';

import '../../bean/Item.dart';

class RadioGroupWidget extends StatefulWidget {
  List<Item<int>> itemList;
  int defaultValue = 0;
  String hint;
  Function(int) listener;

  RadioGroupWidget({super.key,
    required this.itemList,
    required this.hint,
    required this.listener,
    this.defaultValue = 0});

  @override
  State<RadioGroupWidget> createState() => _RadioGroupWidgetState();
}

class _RadioGroupWidgetState extends State<RadioGroupWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.hint),
        Row(
          children: _convertItemList(),
        )
      ],
    );
  }

  List<Widget> _convertItemList() {
    List<Widget> result = [];
    for (int i = 0; i < widget.itemList.length; i++) {
      Item<int> item = widget.itemList[i];
      bool isChoose = widget.defaultValue == item.key;
      result.add(
        GestureDetector(
          onTap: () => {
            setState(() {
              widget.listener(item.key);
            })
          },
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: isChoose ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: i == 0 ? const Radius.circular(8) : Radius.zero,
                bottomLeft: i == 0 ? const Radius.circular(8) : Radius.zero,
                topRight: i == widget.itemList.length - 1 ? const Radius.circular(8) : Radius.zero,
                bottomRight: i == widget.itemList.length - 1 ? const Radius.circular(8) : Radius.zero,
              ),
            ),
            child: Text(
              item.name,
              style: TextStyle(color: isChoose ? Colors.white : Colors.black),
            ),
          ),
        )
      );
    }
    return result;
  }
}
