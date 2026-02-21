import 'package:fintech_app/core/resources/app_strings.dart';
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
          // Navgiter
        },
      ),
    );
  }
}
