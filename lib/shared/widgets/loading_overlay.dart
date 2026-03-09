import 'package:flutter/material.dart';
import 'package:fintech_app/core/constants/app_colors.dart';

/// Wraps any widget with a full-screen loading overlay.
/// Usage: wrap your Scaffold body with [LoadingOverlay] and pass [isLoading].
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const ColoredBox(
            color: Colors.black26,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
      ],
    );
  }
}
