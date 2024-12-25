import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_printer_flutter/utils/SharedPreferencesUtils.dart';

import '../../utils/StringUtils.dart';
import '../../widget/CodeBlock.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return _convertPrinterView();
  }

  Widget _convertPrinterView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _convertHeaderView(),
          const SizedBox(
            height: 10,
          ),
          const Text('Yiwei099'),
          const SizedBox(
            height: 20,
          ),
          const Text('打印机SDK使用需知'),
          Padding(
              padding: const EdgeInsets.all(10),
              child: CodeBlock(code: StringUtils.getSampleCodePrintSupport())),
          const SizedBox(
            height: 20,
          ),
          const Text('数据源绘制SDK使用需知'),
          Padding(
              padding: const EdgeInsets.all(10),
              child: CodeBlock(code: StringUtils.getSampleCodeDrawSupport())),
        ],
      ),
    );
  }

  Widget _convertHeaderView() {
    return Stack(
      children: [
        Positioned(
            right: 10,
            child: IconButton(
                onPressed: () => {
                  debugPrint('mode before = ${Get.isDarkMode}'),
                  Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
                  debugPrint('mode after = ${Get.isDarkMode}')
                },
                icon:
                Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light_mode))),
        Align(
          alignment: Alignment.center,
          child: ClipOval(
            child: Image.asset(
              'assets/mine_logo.jpeg',
              width: 120, // 确保宽度和高度相同以保持圆形
              height: 120,
              fit: BoxFit.cover, // 确保图片覆盖整个圆形区域
            ),
          ),
        )
      ],
    );
  }
}
