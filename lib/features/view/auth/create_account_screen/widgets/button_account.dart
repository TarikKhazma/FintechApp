import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:fintech_app/features/view/auth/widgets/account_singin.dart';
import 'package:fintech_app/features/view/auth/widgets/privacy_policy_and_terms.dart';
import 'package:flutter/material.dart';

class ButtonAccount extends StatelessWidget {
  const ButtonAccount({super.key, required this.bottomPadding});

  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 300,
      left: 20,
      right: 20,
      // bottom: bottomPadding,
      child: Column(
        children: [
          /// زر 1
          Theme(
            data: Theme.of(context).copyWith(
              elevatedButtonTheme: AppTheme.buttonTheme(backgroundColor: red),
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(COUNITNUEWITHGOOGLE, style: textButton),
            ),
          ),

          const SizedBox(height: 12),

          /// زر 2
          Theme(
            data: Theme.of(context).copyWith(
              elevatedButtonTheme: AppTheme.buttonTheme(backgroundColor: black),
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(COUNITNUEWITHAPPLE, style: textButton),
            ),
          ),

          const SizedBox(height: 12),

          /// زر 3
          Theme(
            data: Theme.of(context).copyWith(
              elevatedButtonTheme: AppTheme.buttonTheme(
                backgroundColor: bluedark,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(SIGNUPWITHEMAIL, style: textButton),
            ),
          ),

          SizedBox(height: 40),

          /// 🔹 Account Singin
          AccountSingIn(),
          SizedBox(height: 30),

          /// 🔹 Text Privecy
          PrivacyPolicyAndTerms(),
        ],
      ),
    );
  }
}
