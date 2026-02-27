import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/back_icon.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/form_widgets/sign_in_view_model.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/or_divider.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/signin_form_textfields.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/sign_in_social_buttons.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/sign_in_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInViewModel(),
      child: Theme(
        data: AppTheme.textFieldsTheme,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconArrowLeft(),
                    SizedBox(height: 24),
                    SignInTitle(),
                    SizedBox(height: 32),
                    SignInFormTextfields(),
                    SizedBox(height: 12),
                    OrDivider(),
                    SizedBox(height: 24),
                    SignInSocialButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
