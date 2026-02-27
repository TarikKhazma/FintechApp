import 'package:fintech_app/core/navigation/app_routes.dart';
import 'package:fintech_app/features/view/auth/data/repositories/auth_repository.dart';
import 'package:fintech_app/features/view/auth/login_screens/create_account_screen/create_account_screen.dart';
import 'package:fintech_app/features/view/auth/login_screens/create_account_screen_page_two/create_account_screen_page_two.dart';
import 'package:fintech_app/features/view/onborading/screens/onboarding_main.dart';
import 'package:fintech_app/features/view/splash_screens/splash_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [Provider(create: (_) => AuthRepository())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreens(),
        AppRoutes.onboarding: (_) => const OnboardingMain(),
        AppRoutes.createAccount: (_) => const CreateAccountScreen(),
        AppRoutes.singupemail: (_) => const CreateAccountScreenPageTwo(),
      },
    );
  }
}
