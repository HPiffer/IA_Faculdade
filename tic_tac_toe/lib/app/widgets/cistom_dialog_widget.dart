import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/utils/constants.dart';

class CustomDialog extends StatelessWidget {
  // =========================================== //
  // Declarations
  // =========================================== //
  final String title;
  final String message;
  final Function onPressed;

  // =========================================== //
  // Functions
  // =========================================== //
  const CustomDialog({
    required this.title,
    required this.message,
    required this.onPressed,
  });

  // =========================================== //
  // Screen
  // =========================================== //
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
