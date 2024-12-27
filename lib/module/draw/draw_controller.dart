import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/utils/channel_utils.dart';

class DrawController extends GetxController {
  RxList<int> bitmapArray = RxList<int>();

  @override
  void onInit() {
    super.onInit();
    notifyBitmapArray();
  }

  void notifyBitmapArray(){
    ChannelUtils.buildDrawData('').then((value) => {
      bitmapArray.value = value ?? List.empty()
    }).catchError((onError) {
      debugPrint(onError);
    });
  }
}