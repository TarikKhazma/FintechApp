import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/core/navigation/app_navigator.dart';
import 'package:fintech_app/core/navigation/app_routes.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:fintech_app/features/view/auth/singin_screens/sign_in_page.dart';
import 'package:fintech_app/features/view/widgets/account_check_text.dart';
import 'package:fintech_app/features/view/onborading/widgets/background_onboarding.dart';
import 'package:fintech_app/features/view/onborading/widgets/app_button.dart';
import 'package:fintech_app/features/view/onborading/widgets/photo.dart';
import 'package:fintech_app/features/view/onborading/widgets/titleonboarding.dart';
import 'package:flutter/material.dart';

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
            elevatedButtonTheme: AppTheme.buttonTheme(
              // backgroundColor: Colors.green,
            ),
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
                onPressed: () {
                  AppNavigator.replace(context, AppRoutes.createAccount);
                },
              ),

              const SizedBox(height: 15),

              AccountCheckText(
                questionText: ALREADYHAVEANACCOUNT,
                actionText: SINGIN,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



/**
     AppButton(
              text: CREATEANACCOUNT,
              type: ButtonType.primary,
              onPressed: () {
                // action
              },
            ),
 */