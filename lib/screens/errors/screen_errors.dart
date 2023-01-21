enum ScreenError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  userNotFound,
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
      case ScreenError.userNotFound:
        return 'Usuário não encontrado';
      default:
        return 'Erro inesperado';
    }
  }
}