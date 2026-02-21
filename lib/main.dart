// import 'package:fintech_app/core/constants/app_theme.dart';
// import 'package:fintech_app/features/view/screens/onboarding/onboarding_one.dart';
import 'package:fintech_app/features/view/auth/create_account_screen/create_account_screen.dart';
// import 'package:fintech_app/core/constants/app_theme.dart';
// import 'package:fintech_app/features/view/auth/create_account_screen_page_two/create_account_screen_page_two.dart';
import 'package:fintech_app/features/view/onborading/screens/onboarding_main.dart';
// import 'package:fintech_app/features/view/screens/onboarding/onboarding_two.dart';
// import 'package:fintech_app/features/view/screens/splash/splash_screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: OnboardingMain(),
    );
  }
}
