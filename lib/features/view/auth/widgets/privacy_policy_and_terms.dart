import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyAndTerms extends StatelessWidget {
  const PrivacyPolicyAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(PRIVACYPOLICYANDTERMS, style: textPPT));
  }
}
