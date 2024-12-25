import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/Constant.dart';
import '../../utils/SharedPreferencesUtils.dart';

class AboutController extends GetxController {
  var localThemeMode = 0.obs;

  void changeThemeMode() {
    localThemeMode.value = localThemeMode.value == 0 ? 1 : 0;
    ShapedPreferencesUtils.putInt(Constant.SP_THEME_MODE, localThemeMode.value);
    Get.changeThemeMode(localThemeMode.value == 0 ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  void onInit() {
    super.onInit();
    localThemeMode.value = ShapedPreferencesUtils.getInt(key: Constant.SP_THEME_MODE);
  }
}