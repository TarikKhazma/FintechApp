abstract final class AppRoutes {
  static const splash        = '/';
  static const onboarding    = '/onboarding';
  static const signIn        = '/auth/sign-in';
  static const signUp        = '/auth/sign-up';
  static const signUpSuccess = '/auth/sign-up/success';
  static const home          = '/home';
  static const wallet        = '/wallet';
  static const transactions  = '/transactions';
  static const profile       = '/profile';

  // Legacy aliases kept for old code in features/view/
  static const createAccount = '/auth/sign-up';
  static const singupemail   = '/auth/sign-up/email';
  static const createAccountSuccess = '/auth/sign-up/success';
}
