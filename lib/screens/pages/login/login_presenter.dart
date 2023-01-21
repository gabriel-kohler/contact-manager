import 'package:project_test/screens/errors/errors.dart';

abstract class LoginPresenter {
  Stream<ScreenError?> get emailErrorStream;
  Stream<ScreenError?> get passwordErrorStream;
  Stream<ScreenError?> get mainErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> auth();
}