// import 'package:fintech_app/core/constants/app_text_styles.dart';
// import 'package:fintech_app/core/constants/app_theme.dart';

// import 'package:fintech_app/core/resources/app_images_assets.dart';
// import 'package:fintech_app/core/resources/app_strings.dart';
// import 'package:fintech_app/features/view/auth/create_account_screen_page_two/services/bloc/singup_bloc.dart';
// import 'package:fintech_app/features/view/auth/create_account_screen_page_two/services/bloc/singup_state.dart';
// import 'package:fintech_app/features/view/auth/create_account_screen_page_two/widgets/form_widget/app_text_field.dart';
// import 'package:fintech_app/features/view/auth/create_account_screen_page_two/widgets/form_widget/create_account_view_model.dart';
// import 'package:fintech_app/features/view/auth/create_account_success/view/create_account_success_screen.dart';
// import 'package:fintech_app/features/view/auth/widgets/account_singin.dart';
// import 'package:fintech_app/features/view/auth/widgets/privacy_policy_and_terms.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// class FormTextfields extends StatelessWidget {
//   const FormTextfields({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final confirmPasswordController = TextEditingController();

//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state.status == SignupStatus.success) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const CreateAccountSuccessScreen(),
//             ),
//           );
//         } else if (state.status == SignupStatus.error) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.error ?? 'Something went wrong')),
//           );
//         }
//       },
//       builder: (context, state) {
//         final loading = state.status == SignupStatus.loading;
//         final vm = context.watch<CreateAccountViewModel>();

//        return Positioned(
//       top: 220,
//       left: 20,
//       right: 20,
//       child: Form(
//         key: vm.formKey,
//         child: Column(
//           children: [
//             AppTextField(
//               hint: 'Your Email',
//               controller: vm.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: vm.emailValidator,
//             ),
//             const SizedBox(height: 16),

//             AppTextField(
//               hint: 'Create a strong password',
//               controller: vm.passwordController,
//               obscureText: vm.isPasswordHidden,
//               validator: vm.passwordValidator,
//               suffixIcon: IconButton(
//                 onPressed: vm.togglePassword,
//                 icon: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       IconImages.visibility,
//                       width: 20,
//                       height: 20,
//                     ),
//                     if (vm.isPasswordHidden)
//                       Transform.rotate(
//                         angle: 0.5, // زاوية الراديان، سالب لإمالة الخط
//                         child: Container(
//                           width: 28, // أطول من الأيقونة شوي
//                           height: 2, // سمك الخط
//                           color: Colors.grey,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             AppTextField(
//               hint: 'Repeat Password',
//               controller: vm.confirmPasswordController,
//               obscureText: vm.isConfirmPasswordHidden,
//               validator: vm.confirmPasswordValidator,
//               suffixIcon: IconButton(
//                 onPressed: vm.togglePassword,
//                 icon: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       IconImages.visibility,
//                       width: 20,
//                       height: 20,
//                     ),
//                     if (vm.isConfirmPasswordHidden)
//                       Transform.rotate(
//                         angle: 0.5, // زاوية الراديان، سالب لإمالة الخط
//                         child: Container(
//                           width: 28, // أطول من الأيقونة شوي
//                           height: 2, // سمك الخط
//                           color: Colors.grey,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             Theme(
//               data: Theme.of(
//                 context,
//               ).copyWith(elevatedButtonTheme: AppTheme.buttonTheme()),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 60,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (vm.submit()) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const CreateAccountSuccessScreen(),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text(CREATEANACCOUNT, style: textButton),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             PrivacyPolicyAndTerms(),
//             SizedBox(height: 50),
//             AccountSingIn(),
//         ],
//         ),
//       ),
//     );
//   }
// }
/////
// form_textfields.dart
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/constants/app_theme.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:fintech_app/core/resources/app_strings.dart';
import 'package:fintech_app/features/view/auth/create_account_screen_page_two/services/bloc/singup_bloc.dart';
import 'package:fintech_app/features/view/auth/create_account_screen_page_two/services/bloc/singup_event.dart';
import 'package:fintech_app/features/view/auth/create_account_screen_page_two/services/bloc/singup_state.dart';
import 'package:fintech_app/features/view/auth/create_account_screen_page_two/widgets/form_widget/app_text_field.dart';
import 'package:fintech_app/features/view/auth/create_account_screen_page_two/widgets/form_widget/create_account_view_model.dart';
import 'package:fintech_app/features/view/auth/create_account_success/view/create_account_success_screen.dart';
import 'package:fintech_app/features/view/auth/widgets/account_singin.dart';
import 'package:fintech_app/features/view/auth/widgets/privacy_policy_and_terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FormTextfields extends StatelessWidget {
  const FormTextfields({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CreateAccountViewModel>();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == SignupStatus.success) {
          // أولاً أرسل الـ SnackBar
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login successful!")));

          // ثم انتقل للشاشة التالية
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateAccountSuccessScreen(),
            ),
          );
        }

        if (state.status == SignupStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error ?? 'حدث خطأ')));
        }
      },
      builder: (context, state) {
        final loading = state.status == SignupStatus.loading;
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
                const SizedBox(height: 16),
                AppTextField(
                  hint: 'Repeat Password',
                  controller: vm.confirmPasswordController,
                  obscureText: vm.isConfirmPasswordHidden,
                  validator: vm.confirmPasswordValidator,
                  suffixIcon: IconButton(
                    onPressed: vm.toggleConfirmPassword,
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          IconImages.visibility,
                          width: 20,
                          height: 20,
                        ),
                        if (vm.isConfirmPasswordHidden)
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
                const SizedBox(height: 30),
                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(elevatedButtonTheme: AppTheme.buttonTheme()),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: loading
                          ? null
                          : () {
                              if (vm.submit()) {
                                context.read<AuthBloc>().add(
                                  SignupRequested(
                                    email: vm.emailController.text,
                                    password: vm.passwordController.text,
                                    confirmPassword:
                                        vm.confirmPasswordController.text,
                                  ),
                                );
                              }
                            },
                      child: loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(CREATEANACCOUNT, style: textButton),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                PrivacyPolicyAndTerms(),
                const SizedBox(height: 50),
                AccountSingIn(),
              ],
            ),
          ),
        );
      },
    );
  }
}
