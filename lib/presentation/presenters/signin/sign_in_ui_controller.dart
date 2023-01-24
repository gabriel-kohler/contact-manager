import 'dart:async';

import 'package:get/get.dart';
import 'package:project_test/domain/domain.dart';
import 'package:project_test/screens/errors/screen_errors.dart';
import 'package:project_test/utils/app_routes.dart';

import '../../../screens/screens.dart';
import '../../dependencies/validation.dart';

class LoginState {
  String? mainError;
}

class SignInUiController extends GetxController implements LoginPresenter {
  final Authentication authentication;
  final ValidationUI validation;

  SignInUiController({
    required this.authentication,
    required this.validation,
  });

  String? _email;
  String? _password;

  Rx<ScreenError?> emailError = Rx<ScreenError?>(null);
  Rx<ScreenError?> passwordError = Rx<ScreenError?>(null);
  Rx<ScreenError?> mainError = Rx<ScreenError?>(null);
  Rx<bool> isFormValid = false.obs;
  Rx<bool> isLoading = false.obs;

  @override
  Stream<ScreenError?> get emailErrorStream => emailError.stream;

  @override
  Stream<ScreenError?> get passwordErrorStream => passwordError.stream;

  @override
  Stream<ScreenError?> get mainErrorStream => mainError.stream;

  @override
  Stream<bool> get isFormValidStream => isFormValid.stream;

  @override
  Stream<bool> get isLoadingStream => isLoading.stream;

  @override
  Future<void> auth() async {
    try {
      mainError.value = null;
      isLoading.value = true;
      await authentication.auth(
        _email!,
        _password!,
      );
      Get.offAllNamed(AppRoutes.splashPage);
    } on AuthenticationError catch (error) {
      mainError.value = error.handleAuthenticationError();
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void validateEmail(String email) {
    _email = email;
    emailError.value = _validateField('email');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    passwordError.value = _validateField('password');
    _validateForm();
  }

  ScreenError? _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
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
    isFormValid.value = emailError.value == null &&
            passwordError.value == null &&
            _email != null &&
            _password != null
        ? true
        : false;
  }
}
