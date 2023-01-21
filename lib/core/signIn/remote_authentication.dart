import 'package:project_test/core/core.dart';
import 'package:project_test/domain/domain.dart';

class RemoteAuthentication implements Authentication {
  final SignInApi signInApi;

  RemoteAuthentication({required this.signInApi});

  @override
  Future<void> auth(String email, String password) async {
    try {
      await signInApi.signIn(email, password);
    } on SignInApiError catch (error) {
      _handleSignApiError(error);
    }
  }

  void _handleSignApiError(error) {
    switch (error) {
      case SignInApiError.userNotFound:
      throw AuthenticationError.userNotFound;
      case SignInApiError.wrongPassword:
      throw AuthenticationError.wrongPassword;
      case SignInApiError.unexpected:
      throw AuthenticationError.unexpected;
      }
  }

}
