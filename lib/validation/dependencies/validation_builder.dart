import 'package:project_test/validation/validators/cpf_validation.dart';

import '../validation.dart';

class ValidationUIBuilder {

  static ValidationUIBuilder? _instance;

  String fieldName;
  List<FieldValidation> validations = [];

  ValidationUIBuilder._(this.fieldName);


  static ValidationUIBuilder field(String fieldName) {
    _instance = ValidationUIBuilder._(fieldName);
    return _instance!;
  }

  ValidationUIBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationUIBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  ValidationUIBuilder minLength(int minLengthCaracters) {
    validations.add(MinLengthValidation(field: fieldName, minLengthCaracters: minLengthCaracters));
    return this;
  }

  ValidationUIBuilder sameAs(String fieldToCompare) {
    validations.add(CompareFieldValidation(field: fieldName, fieldToCompare: fieldToCompare));
    return this;
  }

  ValidationUIBuilder cpf() {
    validations.add(CpfValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;

}