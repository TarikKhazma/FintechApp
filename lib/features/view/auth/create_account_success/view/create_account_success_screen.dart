import 'package:flutter/material.dart';
import 'widgets/success_background.dart';
import 'widgets/success_icon.dart';
import 'widgets/success_title.dart';
import 'widgets/success_subtitle.dart';

class CreateAccountSuccessScreen extends StatelessWidget {
  const CreateAccountSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            //     // TODO: Navigate to next page
            //   },
            // ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
