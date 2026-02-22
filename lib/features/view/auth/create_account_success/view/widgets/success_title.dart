import 'package:flutter/material.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_strings.dart';

class SuccessTitle extends StatelessWidget {
  const SuccessTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(SUCCESS, style: textTitleLarge, textAlign: TextAlign.center);
  }
}
