import 'package:get/get.dart';
import 'package:project_test/domain/domain.dart';
import 'package:project_test/screens/pages/pages.dart';

import '../../../screens/errors/errors.dart';
import '../../../utils/utils.dart';
import '../../dependencies/dependencies.dart';

class SignUpUiController extends GetxController implements SignUpPresenter {
  final AddNewUser addNewUser;
  final ValidationUI validation;

  SignUpUiController({
    required this.addNewUser,
    required this.validation,
  });

  String? _email;
  String? _password;
  String? _confirmPassword;

  final _emailError = Rx<ScreenError?>(null);
  final _passwordError = Rx<ScreenError?>(null);
  final _confirmPasswordError = Rx<ScreenError?>(null);
  final _isFormValid = false.obs;

  @override
  Stream<ScreenError?> get emailErrorStream => _emailError.stream.distinct();

  @override
  Stream<ScreenError?> get passwordErrorStream => _passwordError.stream.distinct();

  @override
  Stream<ScreenError?> get confirmPasswordStream =>
      _confirmPasswordError.stream.distinct();

  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();


  @override
  Future<void> signUp() async {
    print('chegou aqui');
    final params = AddNewUserParams(
      email: _email!,
      password: _password!,
    );
    try {
      print('addNewUser');
      final user = await addNewUser.addUser(params);
      Get.offAllNamed(
        AppRoutes.homePage,
        arguments: user,
      );
    } catch (error) {
      print('error > $error');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void goToLogin() {
    // TODO: implement goToLogin
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

  void _validateForm() {
    _isFormValid.value = _emailError.value == null
        && _passwordError.value == null
        && _confirmPasswordError.value == null
        && _email != null
        && _confirmPassword != null
        && _password != null ? true : false;
  }
}
