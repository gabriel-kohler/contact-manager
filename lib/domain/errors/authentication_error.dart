import '../../screens/errors/errors.dart';

enum AuthenticationError {
  userNotFound,
  wrongPassword,
  unexpected,
}

extension HandleAuthenticationError on AuthenticationError {
  handleAuthenticationError() {
    switch (this) {
      case AuthenticationError.userNotFound:
        return ScreenError.userNotFound;
      case AuthenticationError.wrongPassword:
        return ScreenError.invalidCredentials;
      case AuthenticationError.unexpected:
        return ScreenError.unexpected;
    }
  }
}

