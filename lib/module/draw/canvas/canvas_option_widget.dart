import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/draw/canvas/canvas_option_controller.dart';

import '../../../bean/item.dart';
import '../../../widget/radio/radio_group_widget.dart';

class CanvasOptionWidget extends StatefulWidget {
  const CanvasOptionWidget({super.key});

  // DrawCanvas canvas;
  // Function(DrawCanvas canvas) callBack;

  // CanvasOptionWidget({super.key, required this.callBack, required this.canvas});

  @override
  State<CanvasOptionWidget> createState() =>
      _CanvasOptionBottomSheetWidgetState();
}

class _CanvasOptionBottomSheetWidgetState extends State<CanvasOptionWidget> {
  late final CanvasOptionController _controller;

  @override
  void initState() {
    _controller =
        Get.find<CanvasOptionController>(tag: CanvasOptionController.RECEIPT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: SingleChildScrollView(
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
      )),
      TextButton.icon(
        onPressed: () => {_controller.updateCanvas()},
        label: const Text('保存'),
        icon: const Icon(Icons.save),
        style: TextButton.styleFrom(
            padding:
                const EdgeInsets.only(top: 14, bottom: 14, left: 40, right: 40),
            side: const BorderSide(color: Colors.grey, width: 1)),
      ),
      const SizedBox(height: 10)
    ]);
  }

  Widget _convertPageType() {
    return Obx(() {
      int defaultValue = -1;
      if (_controller.bitmapOption.value.maxWidth == 576) {
        defaultValue = 0;
      } else if (_controller.bitmapOption.value.maxWidth == 384) {
        defaultValue = 1;
      }
      return RadioGroupWidget(
          itemList: [
            Item(key: -1, name: '自定义'),
            Item(key: 0, name: '80mm'),
            Item(key: 1, name: '58mm'),
          ],
          listener: (int value) {
            _controller.setPageType(value);
          },
          defaultValue: defaultValue,
          hint: '小票宽度');
    });
  }

  Widget _convertAlignmentType() {
    return Obx(() {
      return RadioGroupWidget(
          itemList: [
            Item(key: 0, name: '顶部'),
            Item(key: 1, name: '居中'),
            Item(key: 2, name: '底部'),
            Item(key: 3, name: '分散'),
          ],
          listener: (int value) {
            _controller.setAlignmentType(value);
          },
          defaultValue: _controller.bitmapOption.value.gravity,
          hint: '对齐方式');
    });
  }

  Widget _convertAliasState() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('抗锯齿'),
          Switch(
            value: _controller.bitmapOption.value.antiAlias,
            onChanged: (value) => {_controller.setAntiAlias(value)},
            activeTrackColor: Get.theme.primaryColor,
            activeColor: Colors.white,
          )
        ],
      );
    });
  }

  Widget _convertFollowEffectState() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('高度不足时终止绘制'),
          Switch(
            value: _controller.bitmapOption.value.followEffectItem,
            onChanged: (value) => {_controller.setFollowEffect(value)},
            activeTrackColor: Get.theme.primaryColor,
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
        Column(
          children: [
            Row(
              children: [
                _convertInputBox(_controller.topController, 3, '上'),
                const SizedBox(width: 10),
                _convertInputBox(_controller.endController, 3, '右'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _convertInputBox(_controller.bottomController, 3, '下'),
                const SizedBox(width: 10),
                _convertInputBox(_controller.startController, 3, '左'),
              ],
            )
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
        _convertInputBox(_controller.widthController, 3, '宽度'),
        const Text('x'),
        _convertInputBox(_controller.heightController, 3, '高度'),
      ],
    );
  }

  Widget _convertInputBox(
      TextEditingController controller, int maxLength, String hint) {
    return SizedBox(
      width: 60,
      height: 50,
      child: TextField(
        maxLength: maxLength,
        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: hint,
          counterText: '',
          labelStyle: const TextStyle(
            color: Colors.grey, // 设置标签文本颜色
          ),
          border: const OutlineInputBorder(),
        ),
      ),
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
          onPressed: () => {_controller.updateCanvas()},
          child: const Text('确定'),
        ),
      ],
    );
  }
}
