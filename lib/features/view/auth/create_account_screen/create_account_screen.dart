// import 'package:fintech_app/core/constants/app_colors.dart';
// import 'package:fintech_app/core/constants/app_text_styles.dart';
// import 'package:fintech_app/core/constants/app_theme.dart';
// import 'package:fintech_app/core/resources/app_images_assets.dart';
// import 'package:fintech_app/core/resources/app_strings.dart';
// import 'package:fintech_app/features/view/auth/widgets/account_singin.dart';
import 'package:fintech_app/features/view/auth/create_account_screen/widgets/backgroundcreatescreen.dart';
import 'package:fintech_app/features/view/auth/create_account_screen/widgets/button_account.dart';
import 'package:fintech_app/features/view/auth/create_account_screen/widgets/logo_welcome.dart';
// import 'package:fintech_app/features/view/auth/widgets/privacy_policy_and_terms.dart';
import 'package:fintech_app/features/view/auth/create_account_screen/widgets/title_text.dart';
// import 'package:fintech_app/features/view/widgets/account_check_text.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 20;

    return BackgroundCreateScreen(
      child: Stack(
        children: [
          /// 🔹 Logo
          LogoWelcome(),

          /// 🔹 Title
          TitleText(),

          /// 🔹 Buttons (أسفل الشاشة)
          ButtonAccount(bottomPadding: bottomPadding),
        ],
      ),
    );
  }
}
