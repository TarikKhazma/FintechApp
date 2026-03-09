import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/core/navigation/app_routes.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:fintech_app/features/view/widgets/account_check_text.dart';
import 'package:fintech_app/features/view/onborading/widgets/background_onboarding.dart';
import 'package:fintech_app/features/view/onborading/widgets/app_button.dart';
import 'package:fintech_app/features/view/onborading/widgets/photo.dart';
import 'package:fintech_app/features/view/onborading/widgets/titleonboarding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BackgroundOnboarding(
      bSvg: SvgImages.backgroundonboardingone,
      child: SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(
            elevatedButtonTheme: AppTheme.buttonTheme(),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.60,
                child: Photo(pSvg: SvgImages.photoonboardingone),
              ),

              const SizedBox(height: 5),

              TitleOnboarding(page: AppStrings.onboardingPages[0]),

              const SizedBox(height: 15),

              AppButton(
                text: CREATEANACCOUNT,
                onPressed: () => context.go(AppRoutes.signUp),
              ),

              const SizedBox(height: 15),

              AccountCheckText(
                questionText: ALREADYHAVEANACCOUNT,
                actionText: SINGIN,
                onTap: () => context.go(AppRoutes.signIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
