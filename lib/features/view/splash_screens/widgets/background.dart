import 'package:fintech_app/core/navigation/app_navigator.dart';
import 'package:fintech_app/core/navigation/app_routes.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      AppNavigator.replace(context, AppRoutes.onboarding);
    });
    return Scaffold(
      body: Stack(
        children: [
          /// SVG Background
          Positioned.fill(
            child: SvgPicture.asset(SvgImages.landingscreen, fit: BoxFit.cover),
          ),

          /// Content فوق الخلفية
          child,
        ],
      ),
    );
  }
}
