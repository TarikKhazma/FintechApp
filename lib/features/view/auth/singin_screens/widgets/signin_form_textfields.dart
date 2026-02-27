import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:fintech_app/features/view/auth/login_screens/create_account_screen_page_two/widgets/form_widget/app_text_field.dart';
import 'package:fintech_app/features/view/auth/singin_screens/widgets/form_widgets/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignInFormTextfields extends StatelessWidget {
  const SignInFormTextfields({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignInViewModel>();

    return Form(
      key: vm.formKey,
      child: Column(
        children: [
          /// ===== Email =====
          AppTextField(
            hint: 'Email',
            controller: vm.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: vm.emailValidator,
          ),

          const SizedBox(height: 16),

          /// ===== Password =====
          AppTextField(
            hint: 'Password',
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
                      angle: 0.5,
                      child: Container(
                        width: 28,
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// ===== Forgot password =====
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot password?'),
            ),
          ),

          const SizedBox(height: 30),

          /// ===== Sign In Button =====
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
                    // dispatch login event
                  }
                },
                child: Text(SINGIN, style: textButton),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
