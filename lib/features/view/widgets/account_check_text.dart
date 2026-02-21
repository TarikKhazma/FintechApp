// import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AccountCheckText extends StatelessWidget {
  final String questionText;
  final String actionText;
  final Function() onTap;

  const AccountCheckText({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: questionText,
        style: textNormal,
        children: [
          TextSpan(
            text: actionText,
            style: textButtonSingin,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
