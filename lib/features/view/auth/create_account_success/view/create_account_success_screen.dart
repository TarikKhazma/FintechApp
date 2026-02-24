import 'package:flutter/material.dart';
import 'widgets/success_background.dart';
import 'widgets/success_icon.dart';
import 'widgets/success_title.dart';
import 'widgets/success_subtitle.dart';
// import 'widgets/success_button.dart';

class CreateAccountSuccessScreen extends StatelessWidget {
  const CreateAccountSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const SuccessIcon(),
            const SizedBox(height: 24),

            const SuccessTitle(),
            const SizedBox(height: 12),

            const SuccessSubtitle(),

            const Spacer(),

            // SuccessButton(
            //   onPressed: () {
            //     // Navigator.pushReplacementNamed(context, AppRoutes.login);
            //   },
            // ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
