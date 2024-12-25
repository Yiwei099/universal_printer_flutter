import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/draw/canvas/CanvasOptionController.dart';
import 'package:universal_printer_flutter/module/draw/canvas/CanvasOptionWidget.dart';
import 'package:universal_printer_flutter/widget/draw/DrawElementWidget.dart';

class DrawReceiptWidget extends StatefulWidget {
  const DrawReceiptWidget({super.key});

  @override
  State<DrawReceiptWidget> createState() => _DrawReceiptWidgetState();
}

class _DrawReceiptWidgetState extends State<DrawReceiptWidget> with AutomaticKeepAliveClientMixin{
  late CanvasOptionController _canvasOptionController;

  @override
  void initState() {
    _canvasOptionController = Get.put(CanvasOptionController());
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
    } catch(e) {
      debugPrint('获取平台异常：${e.toString()}');
      // web 报错： Unsupported operation: Platform._operatingSystem 据说要使用 kIsWeb
      return const Text('此平台暂不支持预览绘制效果');
    }
  }

  void _showOptionBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return const DrawBottomSheetWidget();
      },
    );
  }

  void _showCanvasBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return const CanvasOptionWidget();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
