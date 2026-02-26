import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';

class LogoWelcome extends StatelessWidget {
  const LogoWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      left: 0,
      right: 0,
      child: Center(child: Image.asset(PngImages.welcomequickpay, height: 150)),
    );
  }
}
