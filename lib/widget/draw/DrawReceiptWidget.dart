import 'package:flutter/material.dart';
import 'package:universal_printer_flutter/bean/draw/DrawCanvas.dart';
import 'package:universal_printer_flutter/widget/draw/CanvasOptionWidget.dart';
import 'package:universal_printer_flutter/widget/draw/DrawBottomSheetWidget.dart';

class DrawReceiptWidget extends StatefulWidget {
  const DrawReceiptWidget({super.key});

  @override
  State<DrawReceiptWidget> createState() => _DrawReceiptWidgetState();
}

class _DrawReceiptWidgetState extends State<DrawReceiptWidget> {
  late DrawCanvas _drawCanvas;

  @override
  void initState() {
    _drawCanvas = DrawCanvas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.blue,
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
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.receipt_long_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
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
        return CanvasOptionWidget(
          canvas: _drawCanvas,
          callBack: (value) => {_drawCanvas = value},
        );
      },
    );
  }
}
