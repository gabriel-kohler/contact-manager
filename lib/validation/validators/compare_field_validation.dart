import '../../presentation/dependencies/dependencies.dart';
import '../dependencies/dependencies.dart';

class CompareFieldValidation implements FieldValidation {

  @override
  final String field;

  final String fieldToCompare;

  CompareFieldValidation({required this.field, required this.fieldToCompare});

  bool invalidInputField(Map inputFormData) {
    return (inputFormData[field] != null &&
        inputFormData[fieldToCompare] != null &&
        inputFormData[field] != inputFormData[fieldToCompare]);
  }

  @override
  ValidationError? validate({required Map inputFormData}) {
    final inputInvalid = invalidInputField(inputFormData);
    if (inputInvalid) {
      return ValidationError.invalidField;
    } else {
      return null;
    }
  }
}