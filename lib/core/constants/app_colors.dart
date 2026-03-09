import 'package:flutter/material.dart';

// Legacy global variables — kept for backward compatibility
Color bluelight = const Color(0xff108EE9);
Color bluedark = const Color(0xff1677FF);
Color bluewhite = const Color(0xffE7F0FF);
Color orangedark = const Color(0xffEA4E0D);
Color orange = const Color(0xffFD9A16);
Color yellow = const Color(0xffFDD504);
Color pink = const Color(0xffF95654);
Color white = const Color(0xffF8F8F8);
Color whitep = const Color(0xffFFFFFF);
Color blacklight = const Color(0xff242424);
Color black = const Color(0xff000000);
Color grey = const Color(0xffCDD4D9);
Color red = const Color(0xffDD4B39);

/// Light theme class-based constants.
abstract final class AppColors {
  static const Color primary       = Color(0xff1677FF);
  static const Color primaryLight  = Color(0xff108EE9);
  static const Color primaryBg     = Color(0xffE7F0FF);
  static const Color error         = Color(0xffDD4B39);
  static const Color warning       = Color(0xffFD9A16);
  static const Color success       = Color(0xff52C41A);
  static const Color textPrimary   = Color(0xff242424);
  static const Color textSecondary = Color(0xff8C8C8C);
  static const Color background    = Color(0xffF8F8F8);
  static const Color surface       = Color(0xffFFFFFF);
  static const Color white         = Color(0xffFFFFFF);
  static const Color border        = Color(0xffCDD4D9);
  static const Color divider       = Color(0xffF0F0F0);

  static const List<Color> balanceGradient = [
    Color(0xff1677FF),
    Color(0xff0050CC),
  ];
}

/// Dark theme color constants.
abstract final class AppColorsDark {
  static const Color primary       = Color(0xff4096FF);
  static const Color primaryLight  = Color(0xff91CAFF);
  static const Color primaryBg     = Color(0xff111D2C);
  static const Color error         = Color(0xffFF4D4F);
  static const Color warning       = Color(0xffFFA940);
  static const Color success       = Color(0xff73D13D);
  static const Color textPrimary   = Color(0xffF5F5F5);
  static const Color textSecondary = Color(0xff8C8C8C);
  static const Color background    = Color(0xff0D0D0D);
  static const Color surface       = Color(0xff1A1A1A);
  static const Color border        = Color(0xff2C2C2C);
  static const Color divider       = Color(0xff1F1F1F);

  static const List<Color> balanceGradient = [
    Color(0xff1D3557),
    Color(0xff0A1628),
  ];
}
