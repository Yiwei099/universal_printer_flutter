import 'package:flutter/material.dart';

import '../bean/Item.dart';
import 'ComChooseOption.dart';


class BottomSheetChooseListDialog<T> extends StatefulWidget {
  final String title;
  final List<Item<T>> data;
  T? defaultChooseKey;
  final onItemClick;

  BottomSheetChooseListDialog({super.key,
    required this.title,
    required this.data,
    this.defaultChooseKey,
    required this.onItemClick});

  @override
  State<BottomSheetChooseListDialog> createState() =>
      _BottomSheetChooseListDialogState<T>();
}

class _BottomSheetChooseListDialogState<T>
    extends State<BottomSheetChooseListDialog> {
  late T tempChooseKey;

  @override
  void initState() {
    super.initState();
    tempChooseKey = widget.defaultChooseKey;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () => {}, icon: const SizedBox()),
          Expanded(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 16.0),
          IconButton(
              onPressed: () =>
              {
                Navigator.pop(context)
              },
              icon: const Icon(Icons.close))
          // _convertBottomSheetWidget(data),
        ],
      ),
      Expanded(
        child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () =>
                {
                  setState(() {
                    tempChooseKey = widget.data[index].key;
                  }),
                  widget.onItemClick(widget.data[index].key)
                },
                child: ComChooseOption(
                    name: widget.data[index].name,
                    choose: tempChooseKey == widget.data[index].key),
              );
            }),
      ),
    ]);
  }
}
