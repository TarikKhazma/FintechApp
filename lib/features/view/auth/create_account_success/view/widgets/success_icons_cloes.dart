import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessIconsClose extends StatelessWidget {
  final VoidCallback? onTap;

  const SuccessIconsClose({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => Navigator.pop(context),
      icon: SvgPicture.asset(IconImages.iconionicclose, width: 20, height: 20),
    );
  }
}
