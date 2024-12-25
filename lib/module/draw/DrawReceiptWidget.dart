import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/draw/canvas/CanvasOptionController.dart';
import 'package:universal_printer_flutter/module/draw/canvas/CanvasOptionWidget.dart';
import 'package:universal_printer_flutter/module/draw/source/DrawElementController.dart';
import 'package:universal_printer_flutter/module/draw/source/DrawElementWidget.dart';

class DrawReceiptWidget extends StatefulWidget {
  const DrawReceiptWidget({super.key});

  @override
  State<DrawReceiptWidget> createState() => _DrawReceiptWidgetState();
}

class _DrawReceiptWidgetState extends State<DrawReceiptWidget>
    with AutomaticKeepAliveClientMixin {
  late CanvasOptionController _canvasOptionController;
  late DrawElementController _drawElementController;

  @override
  void initState() {
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
    try {
      if (!Platform.isAndroid) {
        return const Text('此平台暂不支持预览绘制效果');
      } else {
        return const SizedBox();
      }
    } catch (e) {
      debugPrint('获取平台异常：${e.toString()}');
      // web 报错： Unsupported operation: Platform._operatingSystem 据说要使用 kIsWeb
      return const Text('此平台暂不支持预览绘制效果');
    }
  }

  void _showOptionBottomSheet({required BuildContext context}) {
    Get.bottomSheet(
      const DrawElementWidget(),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      barrierColor: Get.isDarkMode ? Colors.white24 : Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }

  void _showCanvasBottomSheet({required BuildContext context}) {
    Get.bottomSheet(
      const CanvasOptionWidget(),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      barrierColor: Get.isDarkMode ? Colors.white24 : Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
