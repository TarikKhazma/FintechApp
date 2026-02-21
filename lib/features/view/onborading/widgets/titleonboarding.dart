import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class TitleOnboarding extends StatelessWidget {
  final OnboardingPage page;

  const TitleOnboarding({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(page.title, textAlign: TextAlign.center, style: titleOnboarding),
        SizedBox(height: 10),
        Text(
          page.description,
          textAlign: TextAlign.center,
          style: descriptionOnboarding,
        ),
      ],
    );
  }
}
