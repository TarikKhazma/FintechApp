import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Photo extends StatelessWidget {
  final String pSvg;
  const Photo({super.key, required this.pSvg});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: SvgPicture.asset(pSvg, fit: BoxFit.fitWidth),
    );
  }
}
