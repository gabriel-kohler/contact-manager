import '../../domain/errors/errors.dart';

enum SignInCoreError {
  userNotFound,
  wrongPassword,
  unexpected,
}

extension HandleSignInCoreError on SignInCoreError {
  handleSignInCoreError() {
    switch (this) {
      case SignInCoreError.userNotFound:
        return AuthenticationError.userNotFound;
      case SignInCoreError.wrongPassword:
        return AuthenticationError.wrongPassword;
      case SignInCoreError.unexpected:
        return AuthenticationError.unexpected;
      default:
        return AuthenticationError.unexpected;
    }
  }
}