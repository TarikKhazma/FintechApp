import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:fintech_app/features/view/auth/create_account_screen_page_two/widgets/form_widget/app_text_field.dart';
import 'package:fintech_app/features/view/auth/create_account_screen_page_two/widgets/form_widget/create_account_view_model.dart';
import 'package:fintech_app/features/view/auth/widgets/account_singin.dart';
import 'package:fintech_app/features/view/auth/widgets/privacy_policy_and_terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FormTextfields extends StatelessWidget {
  const FormTextfields({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CreateAccountViewModel>();
    return Positioned(
      top: 220,
      left: 20,
      right: 20,
      child: Form(
        key: vm.formKey,
        child: Column(
          children: [
            AppTextField(
              hint: 'Your Email',
              controller: vm.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: vm.emailValidator,
            ),
            const SizedBox(height: 16),

            AppTextField(
              hint: 'Create a strong password',
              controller: vm.passwordController,
              obscureText: vm.isPasswordHidden,
              validator: vm.passwordValidator,
              suffixIcon: IconButton(
                onPressed: vm.togglePassword,
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      IconImages.visibility,
                      width: 20,
                      height: 20,
                    ),
                    if (vm.isPasswordHidden)
                      Transform.rotate(
                        angle: 0.5, // زاوية الراديان، سالب لإمالة الخط
                        child: Container(
                          width: 28, // أطول من الأيقونة شوي
                          height: 2, // سمك الخط
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            AppTextField(
              hint: 'Repeat Password',
              controller: vm.confirmPasswordController,
              obscureText: vm.isConfirmPasswordHidden,
              validator: vm.confirmPasswordValidator,
              suffixIcon: IconButton(
                onPressed: vm.togglePassword,
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      IconImages.visibility,
                      width: 20,
                      height: 20,
                    ),
                    if (vm.isPasswordHidden)
                      Transform.rotate(
                        angle: 0.5, // زاوية الراديان، سالب لإمالة الخط
                        child: Container(
                          width: 28, // أطول من الأيقونة شوي
                          height: 2, // سمك الخط
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Theme(
              data: Theme.of(
                context,
              ).copyWith(elevatedButtonTheme: AppTheme.buttonTheme()),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (vm.submit()) {
                      debugPrint(ACCOUNTCREATE);
                    }
                  },
                  child: Text(CREATEANACCOUNT, style: textButton),
                ),
              ),
            ),
            SizedBox(height: 30),
            PrivacyPolicyAndTerms(),
            SizedBox(height: 50),
            AccountSingIn(),
          ],
        ),
      ),
    );
  }
}
