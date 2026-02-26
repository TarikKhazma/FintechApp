import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class SignInSocialButtons extends StatelessWidget {
  const SignInSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            elevatedButtonTheme: AppTheme.buttonTheme(
              backgroundColor: bluewhite,
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(SIGNINWITHGOOGLE, style: textButtonSingin),
          ),
        ),

        const SizedBox(height: 12),

        Theme(
          data: Theme.of(context).copyWith(
            elevatedButtonTheme: AppTheme.buttonTheme(
              backgroundColor: bluewhite,
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(SIGNINWITHAPPLE, style: textButtonSingin),
          ),
        ),
      ],
    );
  }
}
