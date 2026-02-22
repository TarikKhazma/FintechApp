import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      SvgImages.success, // مسار SVG لعلامة الصح
      width: 120,
      height: 120,
    );
  }
}
