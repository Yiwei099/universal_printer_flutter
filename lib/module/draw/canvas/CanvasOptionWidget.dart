
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/bean/draw/DrawCanvas.dart';
import 'package:universal_printer_flutter/module/draw/canvas/CanvasOptionController.dart';

import '../../../bean/Item.dart';
import '../../../widget/radio/RadioGroupWidget.dart';

class CanvasOptionWidget extends StatefulWidget {
  DrawCanvas canvas;
  Function(DrawCanvas canvas) callBack;

  CanvasOptionWidget({super.key, required this.callBack, required this.canvas});

  @override
  State<CanvasOptionWidget> createState() =>
      _CanvasOptionBottomSheetWidgetState();
}

class _CanvasOptionBottomSheetWidgetState extends State<CanvasOptionWidget> {
  late final CanvasOptionController controller;

  @override
  void initState() {
    controller = Get.put(CanvasOptionController(
        canvas: widget.canvas, callback: widget.callBack));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CanvasOptionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _convertWidgetHeader(),
      Expanded(child: SingleChildScrollView(
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
      ))
    ]);
  }

  Widget _convertPageType() {
    return Obx((){
      int defaultValue = -1;
      if (controller.canvas.maxWidth.value == 576) {
        defaultValue = 0;
      } else if (controller.canvas.maxWidth.value == 384) {
        defaultValue = 1;
      }
      return RadioGroupWidget(
          itemList: [
            Item(key: -1, name: '自定义'),
            Item(key: 0, name: '80mm'),
            Item(key: 1, name: '58mm'),
          ],
          listener: (int value) {
            controller.setPageType(value);
          },
          defaultValue: defaultValue,
          hint: '小票宽度');
    });

  }

  Widget _convertAlignmentType() {
    return Obx((){
      return RadioGroupWidget(
          itemList: [
            Item(key: 0, name: '顶部'),
            Item(key: 1, name: '居中'),
            Item(key: 2, name: '底部'),
            Item(key: 3, name: '分散'),
          ],
          listener: (int value) {
            controller.setAlignmentType(value);
          },
          defaultValue: controller.canvas.gravity.value,
          hint: '对齐方式');
    });
  }

  Widget _convertAliasState() {
    return Obx((){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('抗锯齿'),
          Switch(
            value: controller.canvas.antiAlias.value,
            onChanged: (value) => {controller.setAntiAlias(value)},
            activeTrackColor: Colors.blue,
            activeColor: Colors.white,
          )
        ],
      );
    });
  }

  Widget _convertFollowEffectState() {
    return Obx((){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('高度不足时终止绘制'),
          Switch(
            value: controller.canvas.followEffectItem.value,
            onChanged: (value) => {controller.setFollowEffect(value)},
            activeTrackColor: Colors.blue,
            activeColor: Colors.white,
          )
        ],
      );
    });
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
                controller: controller.topController,
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
                controller: controller.endController,
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
                controller: controller.bottomController,
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
                controller: controller.startController,
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
            controller: controller.widthController,
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
            controller: controller.heightController,
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
          onPressed: () => {Get.back()},
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
          onPressed: () => {controller.updateCanvas()},
          child: const Text('确定', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
