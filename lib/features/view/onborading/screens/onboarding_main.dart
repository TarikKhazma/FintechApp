import 'package:fintech_app/features/view/onborading/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'onboarding_one.dart';
import 'onboarding_two.dart';
import 'onboarding_three.dart';

class OnboardingMain extends StatefulWidget {
  const OnboardingMain({super.key});

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final pages = const [OnboardingOne(), OnboardingTwo(), OnboardingThree()];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top + 8;

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 PageView الأساسي
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: pages,
          ),

          // 🔹 Skip Button يظهر فقط إذا لم نصل للصفحة الأخيرة
          if (currentIndex < pages.length - 1)
            Positioned(
              top: topPadding,
              right: 20,
              child: SkipButton(
                onPressed: () {
                  if (currentIndex < pages.length - 1) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),

          // 🔹 Dots Indicator أسفل الشاشة
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
