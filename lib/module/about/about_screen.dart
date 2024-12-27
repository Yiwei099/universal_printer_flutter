import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_printer_flutter/module/home_controller.dart';

import '../../utils/string_utils.dart';
import '../../widget/code_block.dart';

class AboutPage extends StatelessWidget {
  final HomeController _controller = Get.find<HomeController>();

  AboutPage({super.key});

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
                    _controller.changeThemeMode(),
                  },
              icon: Obx(() {
                return Icon(_controller.localThemeMode.value == 1
                    ? Icons.dark_mode
                    : Icons.light_mode);
              })),
        ),
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
