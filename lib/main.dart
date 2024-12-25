import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/MainPage.dart';

import 'utils/SharedPreferencesUtils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '开发者捷印',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const MainPage(),
    );
    // return FutureBuilder(
    //     future: ShapedPreferencesUtils.getInstance(),
    //     builder: (context, snapshot) {
    //       return GetMaterialApp(
    //         title: '开发者捷印',
    //         theme: ThemeData.light(),
    //         darkTheme: ThemeData.dark(),
    //         themeMode: ShapedPreferencesUtils.getInt(key: 'themeMode') == 0 ? ThemeMode.light : ThemeMode.dark,
    //         home: const MainPage(),
    //       );
    //     });
  }
}
