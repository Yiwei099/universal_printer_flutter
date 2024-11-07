import 'package:flutter/material.dart';

class ComChooseOption extends StatefulWidget {
  final String name;
  bool choose = false;

  ComChooseOption({super.key, required this.name, required this.choose});

  @override
  State<ComChooseOption> createState() => _ComChooseOptionState();
}

class _ComChooseOptionState extends State<ComChooseOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: Text(widget.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14))),
            Icon(
              widget.choose ? Icons.check_circle : null,
              size: 18,
              color: Colors.blue[400],
            )
          ],
        ));
  }
}
