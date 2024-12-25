import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/bean/draw/DrawCanvas.dart';

class CanvasOptionController extends GetxController {
  final DrawCanvas canvas = DrawCanvas();
  // final Function(DrawCanvas canvas) callback;

  // CanvasOptionController({required this.callback, required this.canvas})



  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController topController = TextEditingController();
  final TextEditingController bottomController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final TextEditingController startController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (canvas.maxWidth > 0) {
      widthController.text = canvas.maxWidth.toString();
    }
    if (canvas.maxHeight > 0) {
      heightController.text = canvas.maxHeight.toString();
    }
    if (canvas.topIndentation > 0) {
      topController.text = canvas.topIndentation.toString();
    }
    if (canvas.bottomBlankHeight > 0) {
      bottomController.text = canvas.bottomBlankHeight.toString();
    }
    if (canvas.startIndentation > 0) {
      startController.text = canvas.startIndentation.toString();
    }
    if (canvas.endIndentation > 0) {
      endController.text = canvas.endIndentation.toString();
    }
  }

  @override
  void onClose() {
    widthController.dispose();
    heightController.dispose();
    topController.dispose();
    bottomController.dispose();
    startController.dispose();
    endController.dispose();
    super.onClose();
  }

  void updateCanvas() {
    if (widthController.text.isNotEmpty) {
      canvas.maxWidth.value = int.parse(widthController.text);
    }
    if (heightController.text.isNotEmpty) {
      canvas.maxHeight.value = int.parse(heightController.text);
    }
    if (startController.text.isNotEmpty) {
      canvas.startIndentation.value = double.parse(startController.text);
    }
    if (topController.text.isNotEmpty) {
      canvas.topIndentation.value = double.parse(topController.text);
    }
    if (endController.text.isNotEmpty) {
      canvas.endIndentation.value = double.parse(endController.text);
    }
    if (bottomController.text.isNotEmpty) {
      canvas.bottomBlankHeight.value = double.parse(bottomController.text);
    }
    // callback(canvas);
    Get.back();
  }

  void setPageType(int value) {
    int newWidth = 0;
    if (value == 0) {
      newWidth = 576;
    } else if (value == 1) {
      newWidth = 384;
    }
    canvas.maxWidth.value = newWidth;
    widthController.text = newWidth.toString();
    update();
  }

  void setAlignmentType(int value) {
    canvas.gravity.value = value;
    update();
  }

  void setAntiAlias(bool value) {
    canvas.antiAlias.value = value;
    update();
  }

  void setFollowEffect(bool value) {
    canvas.followEffectItem.value = value;
    update();
  }
}
