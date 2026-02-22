import 'package:flutter/material.dart';

class SuccessBackground extends StatelessWidget {
  final Widget child;

  const SuccessBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// الجزء العلوي أزرق
          Container(height: height * 0.1, color: Colors.blue),

          /// الجزء السفلي أبيض مقوس
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
