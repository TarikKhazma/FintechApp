import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

// ========== إعدادات الخط ==========
const String _fontFamily = 'Montserrat'; // ← اسم الخط من pubspec.yaml

TextStyle titleOnboarding = TextStyle(
  fontSize: 33,
  fontWeight: FontWeight.w500,
  fontFamily: _fontFamily,
  color: black,
);
TextStyle descriptionOnboarding = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w300,
  fontFamily: _fontFamily,
  color: black,
);

// textNormal
TextStyle textNormal = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w400,
  fontFamily: _fontFamily,
  color: black,
);

// textBody
TextStyle textBody = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w500,
  fontFamily: _fontFamily,
  color: black,
);

// textTitleLarge
TextStyle textTitleLarge = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w800,
  fontFamily: _fontFamily,
  color: black,
);

// text PrivacyPolicyAndTerms
TextStyle textPPT = TextStyle(
  fontSize: 13,

  fontFamily: _fontFamily,
  color: black,
);

// text
TextStyle text = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  fontFamily: _fontFamily,
  color: black,
);

// text cretat account
TextStyle textCAccount = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
  fontFamily: _fontFamily,
  color: black,
);

// button
TextStyle textButton = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
  fontFamily: _fontFamily,
  color: white,
);

/// Class-based constants — use these in new code.
abstract final class AppTextStyles {
  static const String _font = 'Montserrat';

  static const TextStyle displayLarge = TextStyle(
    fontSize: 33,
    fontWeight: FontWeight.w800,
    fontFamily: _font,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    fontFamily: _font,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    fontFamily: _font,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: _font,
  );

  static const TextStyle body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    fontFamily: _font,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: _font,
  );

  static const TextStyle button = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    fontFamily: _font,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: _font,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w300,
    fontFamily: _font,
  );
}

// buuton singin
TextStyle textButtonSingin = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
  fontFamily: _fontFamily,
  color: bluedark,
);

// text fields
TextStyle textFields = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w400,
  fontFamily: _fontFamily,
  color: black,
);

// hintStyle
TextStyle hintStyle = TextStyle(
  fontSize: 17,
  fontFamily: _fontFamily,
  fontWeight: FontWeight.w300,
  color: black,
);

// textSkip
TextStyle textSkip = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
  fontFamily: _fontFamily,
  color: black,
);
