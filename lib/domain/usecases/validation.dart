abstract class Validation {
  Future<bool> cepValidation(int cep);
  Future<bool> cpfValidation(int cpf);
  Future<bool> passwordValidation(int password);
}