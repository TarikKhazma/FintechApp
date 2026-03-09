import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/features/view/auth/bloc/bloc_auth/auth_bloc.dart';
import 'package:fintech_app/features/view/auth/data/repositories/auth_repository.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/back_icon.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/form_widgets/sign_in_view_model.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/or_divider.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/sign_in_social_buttons.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/sign_in_title.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/signin_form_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SignInViewModel())],
      child: BlocProvider(
        create: (_) => AuthBloc(AuthRepository()),
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
                      const SizedBox(height: 24),
                      SignInTitle(),
                      const SizedBox(height: 32),
                      SignInFormTextfields(),
                      const SizedBox(height: 12),
                      OrDivider(),
                      const SizedBox(height: 24),
                      SignInSocialButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
