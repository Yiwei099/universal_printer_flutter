
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/draw/DrawCanvas.dart';

import '../../bean/Item.dart';
import '../radio/RadioGroupWidget.dart';

class CanvasOptionWidget extends StatefulWidget {
  DrawCanvas canvas;
  Function(DrawCanvas canvas) callBack;

  CanvasOptionWidget({super.key,required this.callBack,required this.canvas });

  @override
  State<CanvasOptionWidget> createState() =>
      _CanvasOptionBottomSheetWidgetState();
}

class _CanvasOptionBottomSheetWidgetState extends State<CanvasOptionWidget> {
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  TextEditingController topController = TextEditingController();
  TextEditingController bottomController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController startController = TextEditingController();

  @override
  void initState() {
    if (widget.canvas.maxWidth > 0) {
      widthController.text = widget.canvas.maxWidth.toString();
    }
    if (widget.canvas.maxHeight > 0) {
      heightController.text = widget.canvas.maxHeight.toString();
    }
    if (widget.canvas.topIndentation > 0) {
      topController.text = widget.canvas.topIndentation.toString();
    }
    if (widget.canvas.bottomBlankHeight > 0) {
      bottomController.text = widget.canvas.bottomBlankHeight.toString();
    }
    if (widget.canvas.startIndentation > 0) {
      startController.text = widget.canvas.startIndentation.toString();
    }
    if (widget.canvas.endIndentation > 0) {
      endController.text = widget.canvas.endIndentation.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    widthController.dispose();
    heightController.dispose();
    topController.dispose();
    bottomController.dispose();
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _convertWidgetHeader(),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          _convertPageType(),
          const SizedBox(height: 10),
          _convertCanvasSize(),
          const SizedBox(height: 10),
          _convertPadding(),
          const SizedBox(height: 10),
          _convertAlignmentType(),
          const SizedBox(height: 10),
          _convertAliasState(),
          const SizedBox(height: 10),
          _convertFollowEffectState(),
        ]),
      )
    ]);
  }

  Widget _convertPageType() {
    int defaultValue = -1;
    if (widget.canvas.maxWidth == 576) {
      defaultValue = 0;
    } else if (widget.canvas.maxWidth == 384) {
      defaultValue = 1;
    }
    return RadioGroupWidget(
        itemList: [
          Item(key: -1, name: '自定义'),
          Item(key: 0, name: '80mm'),
          Item(key: 1, name: '58mm'),
        ],
        listener: (int value) {
          setState(() {
            int newWidth = 0;
            if (value == 0) {
              newWidth = 576;
            } else if (value == 1) {
              newWidth = 384;
            }
            widget.canvas.maxWidth = newWidth;
            widthController.text = newWidth.toString();
          });
        },
        defaultValue: defaultValue,
        hint: '小票宽度');
  }

  Widget _convertAlignmentType() {
    return RadioGroupWidget(
        itemList: [
          Item(key: 0, name: '顶部'),
          Item(key: 1, name: '居中'),
          Item(key: 2, name: '底部'),
          Item(key: 3, name: '分散'),
        ],
        listener: (int value) {
          setState(() {
            widget.canvas.gravity = value;
          });
        },
        defaultValue: widget.canvas.gravity,
        hint: '对齐方式');
  }

  Widget _convertAliasState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('抗锯齿'),
        Switch(
          value: widget.canvas.antiAlias,
          onChanged: (value) => {
            setState(() {
              widget.canvas.antiAlias = value;
            })
          },
          activeTrackColor: Colors.blue,
          activeColor: Colors.white,
        )
      ],
    );
  }

  Widget _convertFollowEffectState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('高度不足时终止绘制'),
        Switch(
          value: widget.canvas.followEffectItem,
          onChanged: (value) => {
            setState(() {
              widget.canvas.followEffectItem = value;
            })
          },
          activeTrackColor: Colors.blue,
          activeColor: Colors.white,
        )
      ],
    );
  }

  Widget _convertPadding() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('边距'),
        Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: TextField(
                maxLength: 2,
                textAlign: TextAlign.center,
                controller: topController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '上',
                  counterText: '',
                  labelStyle: TextStyle(
                    color: Colors.grey, // 设置标签文本颜色
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 50,
              height: 50,
              child: TextField(
                maxLength: 2,
                textAlign: TextAlign.center,
                controller: endController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '右',
                  counterText: '',
                  labelStyle: TextStyle(
                    color: Colors.grey, // 设置标签文本颜色
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 50,
              height: 50,
              child: TextField(
                maxLength: 2,
                textAlign: TextAlign.center,
                controller: bottomController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '下',
                  counterText: '',
                  labelStyle: TextStyle(
                    color: Colors.grey, // 设置标签文本颜色
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 50,
              height: 50,
              child: TextField(
                maxLength: 2,
                textAlign: TextAlign.center,
                controller: startController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '左',
                  counterText: '',
                  labelStyle: TextStyle(
                    color: Colors.grey, // 设置标签文本颜色
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _convertCanvasSize() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('尺寸'),
        const SizedBox(width: 80),
        SizedBox(
          width: 60,
          height: 40,
          child: TextField(
            maxLength: 3,
            textAlign: TextAlign.center,
            controller: widthController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '宽度',
              counterText: '',
              labelStyle: TextStyle(
                color: Colors.grey, // 设置标签文本颜色
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const Text('x'),
        SizedBox(
          width: 60,
          height: 40,
          child: TextField(
            maxLength: 3,
            textAlign: TextAlign.center,
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '高度',
              counterText: '',
              labelStyle: TextStyle(
                color: Colors.grey, // 设置标签文本颜色
              ),
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
    );
  }

  Widget _convertWidgetHeader() {
    return Row(
      children: [
        TextButton(
          onPressed: () => {_onBackPressed()},
          child: const Text('取消'),
        ),
        const Expanded(
          child: Text(
            '画布参数',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 16.0),
        TextButton(
          onPressed: () => {
            _cacheDataAndCallBack(),
          },
          child: const Text('确定', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  void _cacheDataAndCallBack() {
    if(widthController.text.isNotEmpty) {
      widget.canvas.maxWidth = int.parse(widthController.text);
    }
    if(heightController.text.isNotEmpty) {
      widget.canvas.maxHeight = int.parse(heightController.text);
    }
    if(startController.text.isNotEmpty) {
      widget.canvas.startIndentation = double.parse(startController.text);
    }
    if(topController.text.isNotEmpty) {
      widget.canvas.topIndentation = double.parse(topController.text);
    }
    if(endController.text.isNotEmpty) {
      widget.canvas.endIndentation = double.parse(endController.text);
    }
    if(bottomController.text.isNotEmpty) {
      widget.canvas.bottomBlankHeight = double.parse(bottomController.text);
    }
    debugPrint(jsonEncode(widget.canvas));

    _onBackPressed();
  }

  /// 返回
  void _onBackPressed() {
    Navigator.pop(context);
  }
}
