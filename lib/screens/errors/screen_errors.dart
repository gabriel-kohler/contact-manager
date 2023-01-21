enum ScreenError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse,
}

extension ScreenErrorExtension on ScreenError {
  String get description {
    switch (this) {
      case ScreenError.invalidCredentials:
        return 'Credenciais inválidas';
      case ScreenError.invalidField:
        return 'Campo inválido';
      case ScreenError.requiredField:
        return 'Campo obrigatório';
      case ScreenError.emailInUse:
        return 'Esse email já está sendo utilizado';
      default:
        return 'Erro inesperado';
    }
  }
}