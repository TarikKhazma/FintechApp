import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
