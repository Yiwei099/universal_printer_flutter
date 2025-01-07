import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/draw/canvas/canvas_option_widget.dart';
import 'package:universal_printer_flutter/module/draw/draw_options_screen.dart';
import 'package:universal_printer_flutter/module/draw/source/draw_element_widget.dart';

import '../../utils/platform_handler_utils.dart';
import 'canvas/canvas_option_controller.dart';
import 'draw_controller.dart';
import 'source/draw_element_controller.dart';

class DrawReceiptWidget extends StatefulWidget {
  final type = 0;

  const DrawReceiptWidget({super.key});

  @override
  State<DrawReceiptWidget> createState() => _DrawReceiptWidgetState();
}

class _DrawReceiptWidgetState extends State<DrawReceiptWidget>
    with AutomaticKeepAliveClientMixin {
  late DrawController _drawerController;

  @override
  void initState() {
    _drawerController = Get.put(DrawController());
    Get.put(CanvasOptionController(bitmapType: 0),tag: CanvasOptionController.RECEIPT);
    Get.put(DrawElementController());
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
        Align(
          alignment: Alignment.center,
          child: _convertContainer(),
        ),
        Positioned(
          bottom: 20, // 距离底部的距离
          right: 16, // 距离右侧的距离
          child: FloatingActionButton(
            onPressed: () => {
              Get.to(const DrawOptionsScreen())
            },
            child: const Icon(
              Icons.settings,
            ),
          ),
        ),
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

  @override
  bool get wantKeepAlive => true;
}
