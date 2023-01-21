import 'package:project_test/domain/domain.dart';
import 'package:project_test/screens/pages/pages.dart';
import 'package:rxdart/rxdart.dart';

import '../../screens/errors/errors.dart';
import '../dependencies/dependencies.dart';

class SignUpUiController implements SignUpPresenter {
  final AddNewUser addNewUser;
  final ValidationUI validation;

  SignUpUiController({
    required this.addNewUser,
    required this.validation,
  });

  String? _email;
  String? _password;
  String? _confirmPassword;

  final _emailError = BehaviorSubject<ScreenError?>.seeded(null);
  final _passwordError = BehaviorSubject<ScreenError?>.seeded(null);
  final _confirmPasswordError = BehaviorSubject<ScreenError?>.seeded(null);
  final _isFormValid = BehaviorSubject<bool>.seeded(false);

  @override
  Stream<ScreenError?> get emailErrorStream => _emailError.stream;

  @override
  Stream<ScreenError?> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<ScreenError?> get confirmPasswordStream =>
      _confirmPasswordError.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;


  @override
  Future<void> signUp() async {
    // final params = AddNewUserParams(s
    //   email: _email!,
    //   password: _password!,
    // );
    //
    // try {
    //   print('addNewUser');
    //   await addNewUser.addUser(params);
    // } catch (error) {
    //   print('error > $error');
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void goToLogin() {
    // TODO: implement goToLogin
  }

  set isFormValid(bool isFormValid) {
    _isFormValid.value = isFormValid;
  }

  void _validateForm() {
    isFormValid = _emailError.value == null
        && _passwordError.value == null
        && _confirmPasswordError.value == null
        && _email != null
        && _confirmPassword != null
        && _password != null ? true : false;
  }

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  @override
  void validateConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    _confirmPasswordError.value = _validateField('confirmPassword');
    _validateForm();
  }

  ScreenError? _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
      'confirmPassword': _confirmPassword,
    };
    final error = validation.validate(field: field, inputFormData: formData);
    switch (error) {
      case ValidationError.invalidField:
        return ScreenError.invalidField;
      case ValidationError.requiredField:
        return ScreenError.requiredField;
      default:
        return null;
    }
  }
}
