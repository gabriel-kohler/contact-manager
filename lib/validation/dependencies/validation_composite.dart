import 'package:project_test/presentation/dependencies/dependencies.dart';

import 'dependencies.dart';

class ValidationUIComposite implements ValidationUI {
  final List<FieldValidation> validations;

  ValidationUIComposite(this.validations);

  @override
  ValidationError? validate({required String field, required Map inputFormData}) {
    ValidationError? error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(inputFormData: inputFormData);
      if (error != null) {
        return error;
      }
    }
    return error;
  }
}