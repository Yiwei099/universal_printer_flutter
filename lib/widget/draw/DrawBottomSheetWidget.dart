import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/widget/number/NumberActionWidget.dart';
import 'package:universal_printer_flutter/widget/radio/RadioGroupWidget.dart';

import '../../bean/Item.dart';
import '../../constant/Constant.dart';
import '../../utils/DrawBeanUtils.dart';

class DrawBottomSheetWidget extends StatefulWidget {
  const DrawBottomSheetWidget({super.key});

  @override
  State<DrawBottomSheetWidget> createState() => _DrawBottomSheetWidgetState();
}

class _DrawBottomSheetWidgetState extends State<DrawBottomSheetWidget> {
  late List<Item<DrawType>> _drawTypeList;
  late DrawType _chooseDrawType;
  int alignment = 0;
  int fontSize = 16;
  final TextEditingController _lineSpacController = TextEditingController();

  @override
  void initState() {
    _chooseDrawType = DrawType.text;
    _drawTypeList = DrawBeanUtils.getDrawTypeList();
    super.initState();
  }

  @override
  void dispose() {
    _lineSpacController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isText = _chooseDrawType == DrawType.text;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _convertWidgetHeader(),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              _convertDrawTypeWidget(),
              const SizedBox(height: 20),
              _convertLineSpacItem(),
              if (isText) ... {
                const SizedBox(height: 20),
                _convertAlignmentType(),
                const SizedBox(height: 20),
                _convertFontSize(),
              }
            ]))
      ],
    );
  }

  Widget _convertDrawTypeWidget() {
    return Row(
      children: [
        const Text('类型'),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: _convertTypeItem(),
        ))
      ],
    );
  }

  Widget _convertWidgetHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => {_onBackPressed(context)},
          child: const Text('取消'),
        ),
        const Expanded(
          child: Text(
            '添加元素',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 16.0),
        TextButton(
          onPressed: () => {},
          child: const Text('确定', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  List<Widget> _convertTypeItem() {
    List<Widget> result = [];
    for (Item<DrawType> item in _drawTypeList) {
      bool isChoose = _chooseDrawType == item.key;
      result.add(InkWell(
        onTap: () {
          setState(() {
            _chooseDrawType = item.key;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: isChoose ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            item.name,
            style: TextStyle(color: isChoose ? Colors.white : Colors.black),
          ),
        ),
      ));
    }

    return result;
  }

  Widget _convertLineSpacItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('行距'),
        const SizedBox(width: 80),
        Expanded(
            child: TextField(
          textAlign: TextAlign.end,
          controller: _lineSpacController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '请输入行距',
            border: OutlineInputBorder(),
          ),
        ))
      ],
    );
  }

  Widget _convertAlignmentType() {
    return RadioGroupWidget(
        itemList: [
          Item(key: 0, name: '居左'),
          Item(key: 1, name: '居中'),
          Item(key: 2, name: '居右'),
        ],
        listener: (int value) {
          setState(() {
            alignment = value;
          });
        },
        defaultValue: alignment,
        hint: '对齐方式');
  }

  Widget _convertFontSize() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('字号'),
        NumberActionWidget(
          value: fontSize,
          min: 2,
          listener: (int value) => {
            setState(() {
              fontSize = value;
            })
          },
        ),
      ],
    );
  }

  /// 返回
  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }
}
