import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class SignInTitle extends StatelessWidget {
  const SignInTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // top: MediaQuery.of(context).padding.top + 50,
      left: 14,
      child: Text(SIGNACCOUNT, style: text),
    );
  }
}
