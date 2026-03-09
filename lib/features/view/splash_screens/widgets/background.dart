import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Pure visual wrapper — navigation is handled by [SplashScreens].
class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(SvgImages.landingscreen, fit: BoxFit.cover),
          ),
          child,
        ],
      ),
    );
  }
}
