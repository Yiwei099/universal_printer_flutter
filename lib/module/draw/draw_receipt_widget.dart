import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/draw/canvas/canvas_option_controller.dart';
import 'package:universal_printer_flutter/module/draw/canvas/canvas_option_widget.dart';
import 'package:universal_printer_flutter/module/draw/source/draw_element_controller.dart';
import 'package:universal_printer_flutter/module/draw/source/draw_element_widget.dart';

import '../../utils/platform_handler_utils.dart';
import 'draw_controller.dart';

class DrawReceiptWidget extends StatefulWidget {
  const DrawReceiptWidget({super.key});

  @override
  State<DrawReceiptWidget> createState() => _DrawReceiptWidgetState();
}

class _DrawReceiptWidgetState extends State<DrawReceiptWidget>
    with AutomaticKeepAliveClientMixin {
  late CanvasOptionController _canvasOptionController;
  late DrawElementController _drawElementController;
  late DrawController _drawerController;

  @override
  void initState() {
    _drawerController = Get.put(DrawController());
    _canvasOptionController = Get.put(CanvasOptionController());
    _drawElementController = Get.put(DrawElementController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _convertBodyWidget();
  }

  Widget _convertBodyWidget() {
    return Stack(
      children: [
        Positioned(
          bottom: 20, // 距离底部的距离
          right: 16, // 距离右侧的距离
          child: FloatingActionButton(
            onPressed: () => {_showOptionBottomSheet(context: context)},
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 20, // 距离底部的距离
          left: 16, // 距离右侧的距离
          child: FloatingActionButton(
            onPressed: () => {_showCanvasBottomSheet(context: context)},
            child: const Icon(
              Icons.receipt_long_sharp,
              color: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: _convertContainer(),
        )
      ],
    );
  }

  Widget _convertContainer() {
    return PlatformHandlerUtils.getPlatformByHandlerAsync<Widget>(
        androidCallBack: () {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return _drawerController.bitmapArray.isNotEmpty ? Image.memory(
              Uint8List.fromList(_drawerController.bitmapArray)) : const SizedBox();
        }),
      );
    }, defaultCallBack: () {
      return const Text('此平台暂不支持预览绘制效果');
    });
  }

  void _showOptionBottomSheet({required BuildContext context}) {
    Get.bottomSheet(
      const DrawElementWidget(),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      barrierColor: Colors.white54,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }

  void _showCanvasBottomSheet({required BuildContext context}) {
    Get.bottomSheet(
      const CanvasOptionWidget(),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      barrierColor: Colors.white54,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
