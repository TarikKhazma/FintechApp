import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  ///////////////////////////////////////////////////
  // Function واحدة مع parameter اختياري
  static ElevatedButtonThemeData buttonTheme({
    Color? backgroundColor, // ← اختياري
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? bluedark, // ← افتراضي أو مخصص
        foregroundColor: white,

        minimumSize: Size(double.infinity, 70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: textButton,
      ),
    );
  }
  /*
 // 1. استخدام اللون الافتراضي
ThemeData(
  elevatedButtonTheme: AppTheme.buttonTheme(),  // ← blueDark
)

// 2. استخدام لون مخصص
ThemeData(
  elevatedButtonTheme: AppTheme.buttonTheme(
    backgroundColor: Colors.green,  // ← لون مختلف
  ),
)
 */
  /////////////////////////////////////////////////////////////

  // static ThemeData get textfieldsTheme {
  //   return ThemeData(
  //     // ========== حقول النص ==========
  //     inputDecorationTheme: InputDecorationTheme(
  //       filled: true,
  //       fillColor: Colors.grey[50],
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(color: grey),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(color: grey),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(color: grey, width: 2),
  //       ),
  //       errorBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(color: red),
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(
  //         horizontal: 16,
  //         vertical: 16,
  //       ),
  //     ),
  //   );
  // }

  // ===== TextFields Theme =====
  static ThemeData get textFieldsTheme {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,

        // 👇 يخلي اللابل داخل الحقل
        floatingLabelBehavior: FloatingLabelBehavior.auto,

        // شكل النص داخل الحقل
        labelStyle: TextStyle(color: grey, fontSize: 14),

        // شكل النص لما يطلع لفوق (بس يظل داخل البوكس)
        floatingLabelStyle: TextStyle(
          color: bluedark,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: grey, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: red),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      ),
    );
  }

  // ===== Button Theme =====
  static ElevatedButtonThemeData buttonsTheme({Color? backgroundColor}) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? bluedark,
        foregroundColor: white,
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
