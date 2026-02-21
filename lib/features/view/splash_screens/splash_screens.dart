import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:fintech_app/features/view/splash_screens/widgets/background.dart';
import 'package:flutter/material.dart';

class SplashScreens extends StatelessWidget {
  const SplashScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(child: Center(child: Image.asset(PngImages.logoquikpay)));
  }
}
