import 'package:project_test/screens/errors/errors.dart';

abstract class SignUpPresenter {
  Stream<ScreenError?> get emailErrorStream;
  Stream<ScreenError?> get passwordErrorStream;
  Stream<ScreenError?> get confirmPasswordStream;
  Stream<bool> get isFormValidStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void validateConfirmPassword(String confirmPassword);
  Future<void> signUp();
  void goToLogin();
}