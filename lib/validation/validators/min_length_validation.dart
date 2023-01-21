import '../../presentation/dependencies/dependencies.dart';
import '../validation.dart';

class MinLengthValidation implements FieldValidation {

  @override
  final String field;

  final int minLengthCaracters;

  MinLengthValidation({required this.field, required this.minLengthCaracters});


  @override
  ValidationError? validate({required Map inputFormData}) {
    final String? value = inputFormData[field];
    if (value != null && value.length >= minLengthCaracters) {
      return null;
    } else {
      return ValidationError.invalidField;
    }
  }

}