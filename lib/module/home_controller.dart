import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../utils/shared_preferences_utils.dart';

class HomeController extends GetxController {
  var localThemeMode = 0.obs;
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

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