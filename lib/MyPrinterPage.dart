import 'package:flutter/material.dart';

class MyPrinterPage extends StatefulWidget {
  const MyPrinterPage({super.key});

  @override
  State<MyPrinterPage> createState() => _MyPrinterPageState();
}

class _MyPrinterPageState extends State<MyPrinterPage> {


  @override
  Widget build(BuildContext context) {
    return const Text('打印机列表');
  }
}
