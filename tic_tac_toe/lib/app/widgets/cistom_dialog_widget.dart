import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/utils/constants.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function onPressed;

  const CustomDialog({
    required this.title,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text(RESET_BUTTON_LABEL),
          onPressed: () {
            onPressed();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
