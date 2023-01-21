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
  void dispose();
}

/*
void validateCpf(String cpf);
  void validateCep(String cep);
  void validateStreet(String street);
  void validateNumber(String number);
  void validateDistrict(String district);
  void validateState(String state);
  void validateCity(String city);
  void onPhoneNumber(String complement);
  void onComplementForm(String complement);
  void onReferencePoint(String referencePoint);
 */