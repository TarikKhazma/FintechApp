// ignore_for_file: non_constant_identifier_names

String SKIP = 'Skip';
String REGISTRATION = 'Registration';
String FULLNAME = 'Full Name';
String EMAIL = 'Email';
String YOUREMAIL = 'Your Email';
String FORGETPASSWORD = 'Forgot your password?';
String SUBMIT = 'Submit';
String LOGOUT = 'Logout';
String SINGUP = 'Sing Up';
String SINGIN = 'Sing In';
String SUCCESS = 'Success!';
// ignore: constant_identifier_names
const String CREATEANACCOUNT = 'Create an account';
String ACCOUNTCREATE = '✅ Account Created';

String CREATEANACCOUNTT = 'Create an\naccount.';
String SIGNACCOUNT = 'Sign in to your account';
String ALREADYHAVEANACCOUNT = 'Already have an account? ';
String SIGNINWITHGOOGLE = 'Sign in with Google';
String SIGNINWITHAPPLE = 'Sign in with Apple';

String COUNITNUEWITHGOOGLE = 'Counitnue with Google';
String COUNITNUEWITHAPPLE = 'Counitnue with Apple';
String SIGNUPWITHEMAIL = 'Sign up with Email';

String PRIVACYPOLICYANDTERMS =
    'By signing up you agree to our Privacy Policy and Terms.';

String CHECKEMAIL = 'Now check your email for\nconfirmation link.';

// onboardings
// في الشاشة
// final page = AppStrings.onboardingPages[0 or 1 or 2];
// Text(page.title)         // ← العنوان
// Text(page.description)   // ← الوصف
class OnboardingPage {
  final String title;
  final String description;

  const OnboardingPage({required this.title, required this.description});
}

class AppStrings {
  static const List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Quickpay',
      description:
          'for your cash, cards,\ninvestments, savings and\nforeign exchanges',
    ),
    OnboardingPage(
      title: 'Quickpay',
      description:
          'for your travel, bus cards,\nidentification cards, top ups,\nutilities & bills',
    ),
    OnboardingPage(
      title: 'Quickpay',
      description:
          'for your family life, friends,\nrewards, credit & so much\nmore',
    ),
  ];
}

String YEAROFBIRTH = 'Please enter your year of birth';
String VALIDYEAR = 'Please enter a valid year';
String NEMERBETWEEN = 'email';
String THEPASSWORDWEEK = 'The password is to week';
String ADDRESS = 'Your Address';
String BIRTH = 'Year of Birth';
String NOQUESTION = 'There is no question to show';
String PASSWORD = 'Password';
String SURE = "Are you sure you want to logout?";
String COMPLETEINFORMATION = "please complete your information";
String NOINTERNET = "There is no internet conection";
String VALIDEMAIL = 'Enter A valid Email';
String FORMS = 'Forms';
String NOTIFICATIONTITLE = 'You did it Answers Submitted :)';
String QUESTION = 'Questions';
String ENTERANSWERS = 'Enter the answers';
String NOFORMS = 'there is no forms to show';
