import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({Key? key}) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        width: 75,
        padding: const EdgeInsets.all(5),
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 5,
            child: const Icon(Icons.qr_code_scanner, size: 30),
            onPressed: () {
              // Handle onPressed event
            },
          ),
        )
    );
  }
}