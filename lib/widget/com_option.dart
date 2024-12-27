import 'package:flutter/material.dart';

class ComOption extends StatefulWidget {
  final String name;
  final String value;

  const ComOption({super.key, required this.name, this.value = ''});

  @override
  State<ComOption> createState() => _ComOptionState();
}

class _ComOptionState extends State<ComOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.name, style: const TextStyle(fontSize: 12)),
            Expanded(
              child: Text(
                widget.value,
                textAlign: TextAlign.end,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey[400],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Divider(
            height: 0.1,
            indent: 2,
            endIndent: 4,
            color: Colors.grey[350],
          ),
        )
      ],
    );
  }
}
