import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconArrowLeft extends StatelessWidget {
  const IconArrowLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: SvgPicture.asset(IconImages.iconarrowleft, width: 24, height: 24),
    );
  }
}
