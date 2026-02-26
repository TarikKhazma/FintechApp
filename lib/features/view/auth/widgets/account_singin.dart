import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:fintech_app/features/view/auth/singin_screens/sign_in_page.dart';
import 'package:fintech_app/features/view/widgets/account_check_text.dart';
import 'package:flutter/material.dart';

class AccountSingIn extends StatelessWidget {
  const AccountSingIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AccountCheckText(
        questionText: ALREADYHAVEANACCOUNT,
        actionText: SINGIN,
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SignInPage()),
          );
        },
      ),
    );
  }
}
