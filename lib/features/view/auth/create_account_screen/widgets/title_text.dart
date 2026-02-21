import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250, // 👈 تحت الصورة
      left: 0,
      right: 0,
      child: Center(child: Text(CREATEANACCOUNT, style: text)),
    );
  }
}
