import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/bean/draw/bitmap_option.dart';
import 'package:universal_printer_flutter/utils/db_utils.dart';

class CanvasOptionController extends GetxController {
  final bitmapOption = BitmapOption().obs;

  static final RECEIPT = 'receipt';
  static final Label = 'label';

  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController topController = TextEditingController();
  final TextEditingController bottomController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final TextEditingController startController = TextEditingController();

  int bitmapType = 0;

  CanvasOptionController({required this.bitmapType});

  @override
  void onInit() {
    super.onInit();
    _initDataFromDB();
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

  void _initDataFromDB() {
    DBUtil.instance.getBitmapOptionByType(bitmapType).then((value) {
      // 小票纸参数
      if (value != null) {
        bitmapOption.value = value;
      } else {
        // 不存在则新建插入
        BitmapOption option = BitmapOption(
          bitmapType: bitmapType,
        );
        bitmapOption.value = option;
        DBUtil.instance.saveOptionItem(option);
      };
      _initDataToTextController();
    });
  }

  void _initDataToTextController() {
    if (bitmapOption.value.maxWidth > 0) {
      widthController.text = bitmapOption.value.maxWidth.toString();
    }
    if (bitmapOption.value.maxHeight > 0) {
      heightController.text = bitmapOption.value.maxHeight.toString();
    }
    if (bitmapOption.value.topIndentation > 0) {
      topController.text = bitmapOption.value.topIndentation.toString();
    }
    if (bitmapOption.value.bottomBlankHeight > 0) {
      bottomController.text = bitmapOption.value.bottomBlankHeight.toString();
    }
    if (bitmapOption.value.startIndentation > 0) {
      startController.text = bitmapOption.value.startIndentation.toString();
    }
    if (bitmapOption.value.endIndentation > 0) {
      endController.text = bitmapOption.value.endIndentation.toString();
    }
  }

  void updateCanvas() {
    bitmapOption.update((option) {
      if (option != null) {
        if (int.tryParse(widthController.text) != null) {
          option.maxWidth = int.parse(widthController.text);
        }
        if (int.tryParse(heightController.text) != null) {
          option.maxHeight = int.parse(heightController.text);
        }
        if (double.tryParse(startController.text) != null) {
          option.startIndentation = double.parse(startController.text);
        }
        if (double.tryParse(endController.text) != null) {
          option.endIndentation = double.parse(endController.text);
        }
        if (double.tryParse(topController.text) != null) {
          option.topIndentation = double.parse(topController.text);
        }
        if (double.tryParse(bottomController.text) != null) {
          option.bottomBlankHeight = double.parse(bottomController.text);
        }

        DBUtil.instance.updateOptionItem(option);
      }
    });
    Get.back();
  }

  void setPageType(int value) {
    int newWidth = 0;
    if (value == 0) {
      newWidth = 576;
    } else if (value == 1) {
      newWidth = 384;
    }
    widthController.text = newWidth.toString();
    bitmapOption.update((option) {
      option?.maxWidth = newWidth;
    });
  }

  void setAlignmentType(int value) {
    bitmapOption.update((option) {
      option?.gravity = value;
    });
  }

  void setAntiAlias(bool value) {
    bitmapOption.update((option) {
      option?.antiAlias = value;
    });
  }

  void setFollowEffect(bool value) {
    bitmapOption.update((option) {
      option?.followEffectItem = value;
    });
  }
}
