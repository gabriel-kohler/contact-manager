import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:project_test/presentation/dependencies/validation.dart';
import 'package:project_test/validation/dependencies/dependencies.dart';

class CpfValidation implements FieldValidation {
  @override
  final String field;

  CpfValidation(this.field);

  @override
  ValidationError? validate({required Map inputFormData}) {
    final cpf = inputFormData['cpf'];
    final cpfList = inputFormData['cpfList'];
    if (!CPFValidator.isValid(cpf)) {
      return ValidationError.invalidField;
    } else if (cpfList.where((cpfFromList) => cpfFromList == cpf).toList().length >
        0) {
      return ValidationError.cpfRepeated;
    } else {
      return null;
    }
  }
}
