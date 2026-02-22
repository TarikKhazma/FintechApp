import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';

class BackgroundCreateScreen extends StatelessWidget {
  final Widget child;

  const BackgroundCreateScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 👈 مهم جداً
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 🔹 Background ثابت
          Image.asset(
            PngImages.screencreateacoount,
            fit: BoxFit.cover,
            alignment: Alignment.center, // 👈 تثبيت التمركز
          ),

          /// 🔹 المحتوى فوق الخلفية
          SafeArea(child: child),
        ],
      ),
    );
  }
}
