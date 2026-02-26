import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SuccessBackground extends StatelessWidget {
  final Widget child;
  final Widget? leading;

  const SuccessBackground({super.key, required this.child, this.leading});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(height: size.height * 0.22, color: bluedark),

          Positioned(
            top: size.height * 0.22 - 40,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.78,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(top: false, child: child),
            ),
          ),

          if (leading != null) Positioned(top: 140, left: 16, child: leading!),
        ],
      ),
    );
  }
}
