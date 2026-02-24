import 'package:flutter/material.dart';

class SuccessBackground extends StatelessWidget {
  final Widget child;

  const SuccessBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(height: size.height * 0.22, color: Colors.blue),

          Positioned(
            top: size.height * 0.22 - 60,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SafeArea(top: false, child: child),
            ),
          ),
        ],
      ),
    );
  }
}
