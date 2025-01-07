import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/main_page.dart';
import 'package:universal_printer_flutter/constant/constant.dart';
import 'package:universal_printer_flutter/utils/db_utils.dart';

import 'utils/platform_handler_utils.dart';
import 'utils/shared_preferences_utils.dart';

Future<void> main() async {
  //初始化 sharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  await ShapedPreferencesUtils.getInstance();
  PlatformHandlerUtils.getPlatformByHandler(androidCallBack: () async {
    await DBUtil().initDB();
    runApp(const MyApp());
  },defaultCallBack: () {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '开发者捷印',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ShapedPreferencesUtils.getInt(key: Constant.SP_THEME_MODE) == 0
          ? ThemeMode.light
          : ThemeMode.dark,
      home: const MainPage(),
      defaultTransition: Transition.rightToLeft,
    );
  }
}
