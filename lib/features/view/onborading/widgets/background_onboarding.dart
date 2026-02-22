import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundOnboarding extends StatelessWidget {
  final String bSvg;
  final Widget child;

  const BackgroundOnboarding({
    super.key,
    required this.child,
    required this.bSvg,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// SVG Background
          Positioned.fill(child: SvgPicture.asset(bSvg, fit: BoxFit.cover)),

          /// Content فوق الخلفية
          child,
        ],
      ),
    );
  }
}
