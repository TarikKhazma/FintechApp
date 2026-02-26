import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SvgPicture.asset(
      SvgImages.success,
      width: size.width * 0.28,
      height: size.width * 0.28,
    );
  }
}
