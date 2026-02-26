import 'package:flutter/material.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    notifyListeners();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Invalid email';
    }
    if (!value.contains('.com')) {
      return 'Correct email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 chars';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool submit() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
