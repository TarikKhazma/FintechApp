import 'package:flutter/material.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_strings.dart';

class SuccessSubtitle extends StatelessWidget {
  const SuccessSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(CHECKEMAIL, style: textBody, textAlign: TextAlign.center),
    );
  }
}
