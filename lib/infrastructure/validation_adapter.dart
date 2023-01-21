import 'package:project_test/domain/domain.dart';

class ValidationAdapter implements Validation {
  @override
  Future<bool> cepValidation(int cep) {
    // TODO: implement cepValidation
    throw UnimplementedError();
  }

  @override
  Future<bool> cpfValidation(int cpf) {
    // TODO: implement cpfValidation
    throw UnimplementedError();
  }

  @override
  Future<bool> passwordValidation(int password) {
    // TODO: implement passwordValidation
    throw UnimplementedError();
  }
  
}