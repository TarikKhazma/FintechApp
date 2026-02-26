import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/features/view/auth/login_screens/create_account_screen_page_two/services/bloc/singup_bloc.dart';
import 'package:fintech_app/features/view/auth/login_screens/create_account_screen_page_two/widgets/form_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'widgets/icon_arrow_left.dart';
import 'widgets/text_create_an_account.dart';
import 'widgets/form_widget/create_account_view_model.dart';

class CreateAccountScreenPageTwo extends StatelessWidget {
  const CreateAccountScreenPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreateAccountViewModel()),
      ],
      child: BlocProvider(
        create: (_) => AuthBloc(),
        child: const _CreateAccountView(),
      ),
    );
  }
}

class _CreateAccountView extends StatelessWidget {
  const _CreateAccountView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: AppTheme.textFieldsTheme,
        child: Stack(
          children: const [
            IconArrowLeft(),
            TextCreateAnAccount(),
            FormTextfields(),
          ],
        ),
      ),
    );
  }
}
