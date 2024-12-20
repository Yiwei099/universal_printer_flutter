import 'package:flutter/material.dart';

import 'utils/StringUtils.dart';
import 'widget/CodeBlock.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _convertPrinterView();
  }

  Widget _convertPrinterView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20,),
          const Text('打印机SDK使用需知'),
          Padding(padding: const EdgeInsets.all(10),
              child: CodeBlock(code: StringUtils.getSampleCodePrintSupport())),
          const SizedBox(height: 20,),
          const Text('数据源绘制SDK使用需知'),
          Padding(padding: const EdgeInsets.all(10),
              child: CodeBlock(code: StringUtils.getSampleCodeDrawSupport())),
        ],
      ),
    );

  }
}
