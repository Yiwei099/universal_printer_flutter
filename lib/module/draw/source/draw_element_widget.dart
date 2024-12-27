import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/draw/source/element_list_widget.dart';
import 'package:universal_printer_flutter/widget/number/number_action_widget.dart';
import 'package:universal_printer_flutter/widget/radio/radio_group_widget.dart';

import '../../../bean/item.dart';
import '../../../constant/constant.dart';
import 'draw_element_controller.dart';

class DrawElementWidget extends StatefulWidget {
  const DrawElementWidget({super.key});

  @override
  State<DrawElementWidget> createState() => _DrawElementWidgetState();
}

class _DrawElementWidgetState extends State<DrawElementWidget> {
  late DrawElementController _drawElementController;

  @override
  void initState() {
    _drawElementController = Get.find<DrawElementController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  _convertTextElementParamWidget(),
                  const SizedBox(height: 20),
                  _convertActionBar(),
                ])))
      ],
    );
  }

  /// 绘制 文本组件专有组件
  Widget _convertTextElementParamWidget() {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0.0, // 0.0 表示垂直方向
            child: child,
          );
        },
        child: _drawElementController.isTextElement()
            ? Column(
                key: ValueKey<DrawType>(_drawElementController.chooseDrawType),
                children: [
                  const SizedBox(height: 20),
                  _convertInputTextItem(),
                  const SizedBox(height: 20),
                  _convertAlignmentType(),
                  const SizedBox(height: 20),
                  _convertFontSize(),
                ],
              )
            : Container(
                key: ValueKey<DrawType>(_drawElementController.chooseDrawType)),
      );
    });
  }

  /// 绘制元素类型
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

  /// 绘制顶部操作栏
  Widget _convertWidgetHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => {_drawElementController.resetData(), Get.back()},
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
          onPressed: () => {_drawElementController.buildElement()},
          child: const Text('确定'),
        ),
      ],
    );
  }

  /// 绘制元素类型子项
  List<Widget> _convertTypeItem() {
    List<Widget> result = [];
    for (Item<DrawType> item in _drawElementController.drawTypeList) {
      result.add(Obx(() {
        bool isChoose = _drawElementController.chooseDrawType == item.key;
        return InkWell(
          onTap: () {
            _drawElementController.setChooseDrawType(item.key);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: isChoose ? Get.theme.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              item.name,
              style: TextStyle(color: isChoose ? Colors.white : Colors.black),
            ),
          ),
        );
      }));
    }

    return result;
  }

  /// 绘制行距输入组件
  Widget _convertLineSpacItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('行距'),
        const SizedBox(width: 80),
        Expanded(
            child: TextField(
          textAlign: TextAlign.end,
          controller: _drawElementController.lineSpacController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '请输入行距',
            border: OutlineInputBorder(),
          ),
        ))
      ],
    );
  }

  /// 绘制文本内容数组组件
  Widget _convertInputTextItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('内容'),
        const SizedBox(width: 80),
        Expanded(
            child: TextField(
          textAlign: TextAlign.end,
          controller: _drawElementController.textEditingController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '文本内容',
            border: OutlineInputBorder(),
          ),
        ))
      ],
    );
  }

  /// 绘制文本对齐方式组件
  Widget _convertAlignmentType() {
    return Obx(() {
      return RadioGroupWidget(
          itemList: [
            Item(key: 0, name: '居左'),
            Item(key: 1, name: '居中'),
            Item(key: 2, name: '居右'),
          ],
          listener: (int value) {
            _drawElementController.setAlignment(value);
          },
          defaultValue: _drawElementController.alignment.value,
          hint: '对齐方式');
    });
  }

  /// 绘制字体大小组件
  Widget _convertFontSize() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('字号'),
          NumberActionWidget(
            value: _drawElementController.fontSize.value,
            min: 2,
            listener: (int value) =>
                {_drawElementController.setFontSize(value)},
          ),
        ],
      );
    });
  }

  /// 绘制底部操作栏
  Widget _convertActionBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: () => {_showElementListDialog()},
          label: Obx(() {
            return Text('元素(${_drawElementController.sourceList.length})');
          }),
          icon: const Icon(Icons.list, color: Colors.white),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 40, right: 40),
              disabledForegroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey,
              backgroundColor: Get.theme.primaryColor,
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
              backgroundColor: Get.theme.primaryColor,
              foregroundColor: Colors.white),
        ),
      ],
    );
  }

  void _showElementListDialog() {
    if (_drawElementController.isEmptySource()) {
      debugPrint('未添加元素');
      return;
    }
    Get.bottomSheet(
      const ElementListWidget(),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      barrierColor: Colors.white24,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }
}
