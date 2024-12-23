import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/draw/element/TextElement.dart';
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
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    _chooseDrawType = DrawType.text;
    _drawTypeList = DrawBeanUtils.getDrawTypeList();
    super.initState();
  }

  @override
  void dispose() {
    _lineSpacController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isText = _chooseDrawType == DrawType.text;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _convertWidgetHeader(),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  _convertDrawTypeWidget(),
                  const SizedBox(height: 20),
                  _convertLineSpacItem(),
                  if (isText) ...{
                    const SizedBox(height: 20),
                    _convertInputTextItem(),
                    const SizedBox(height: 20),
                    _convertAlignmentType(),
                    const SizedBox(height: 20),
                    _convertFontSize(),
                  },
                  const SizedBox(height: 20),
                  _convertActionBar(),
                ])))
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
          onPressed: () => {_buildElement()},
          child: const Text('确定', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  void _buildElement() {
    switch (_chooseDrawType) {
      case DrawType.text:
        if (textEditingController.text.isEmpty) {
          debugPrint('文本内容不能为空');
          return;
        }
        int lineSpac = 10;
        if (_lineSpacController.text.isNotEmpty) {
          lineSpac = int.parse(_lineSpacController.text);
        }

        debugPrint(jsonEncode(TextElement(
            text: textEditingController.text,
            alignment: alignment,
            fontSize: fontSize,
            perLineSpac: lineSpac)));
        break;
      default:
        break;
    }
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

  Widget _convertInputTextItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('内容'),
        const SizedBox(width: 80),
        Expanded(
            child: TextField(
          textAlign: TextAlign.end,
          controller: textEditingController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '文本内容',
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

  Widget _convertActionBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: () => {},
          label: const Text('元素(0)'),
          icon: const Icon(Icons.list, color: Colors.white),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 40, right: 40),
              disabledForegroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white),
        ),
        TextButton.icon(
          onPressed: () => {},
          label: const Text('预览'),
          icon: const Icon(Icons.build_circle_outlined, color: Colors.white),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 40, right: 40),
              disabledForegroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white),
        ),
      ],
    );
  }

  /// 返回
  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }
}
