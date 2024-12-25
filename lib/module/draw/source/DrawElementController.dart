import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../bean/Item.dart';
import '../../../bean/draw/element/TextElement.dart';
import '../../../constant/Constant.dart';
import '../../../utils/DrawBeanUtils.dart';

class DrawElementController extends GetxController {
  final RxList<dynamic> _sourceList = [].obs;

  final Rx<DrawType> _chooseDrawType = DrawType.text.obs;
  final Rx<int> alignment = 0.obs;
  final Rx<int> fontSize = 16.obs;

  late List<Item<DrawType>> _drawTypeList;
  final TextEditingController lineSpacController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();

  List<dynamic> get sourceList => _sourceList.value;

  DrawType get chooseDrawType => _chooseDrawType.value;

  List<Item<DrawType>> get drawTypeList => _drawTypeList;

  bool isTextElement() {
    return _chooseDrawType.value == DrawType.text;
  }

  void setChooseDrawType(DrawType value) {
    _chooseDrawType.value = value;
  }

  void setAlignment(int value) {
    alignment.value = value;
  }

  void setFontSize(int value) {
    fontSize.value = value;
  }

  void buildElement() {
    switch (_chooseDrawType.value) {
      case DrawType.text:
        if (textEditingController.text.isEmpty) {
          debugPrint('文本内容不能为空');
          return;
        }
        int lineSpac = 10;
        if (lineSpacController.text.isNotEmpty) {
          lineSpac = int.parse(lineSpacController.text);
        }
        _cacheElement(TextElement(
            text: textEditingController.text,
            alignment: alignment.value,
            fontSize: fontSize.value,
            perLineSpac: lineSpac));
        break;
      case DrawType.line:
        break;
      case DrawType.dashLine:
        break;
      default:
        break;
    }
  }

  void _cacheElement(dynamic element) {
    _sourceList.add(element);
    debugPrint(jsonEncode(element));
    resetData();
  }

  void resetData() {
    alignment.value = 0;
    fontSize.value = 16;
    lineSpacController.text = '';
    textEditingController.text = '';
    _chooseDrawType.value = DrawType.text;
  }

  @override
  void onInit() {
    super.onInit();
    _drawTypeList = DrawBeanUtils.getDrawTypeList();
  }

  @override
  void onClose() {
    lineSpacController.dispose();
    textEditingController.dispose();
    super.onClose();
  }
}
