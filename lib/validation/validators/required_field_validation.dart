import '../../presentation/dependencies/dependencies.dart';
import '../dependencies/dependencies.dart';

class RequiredFieldValidation implements FieldValidation {

  @override
  final String field;

  RequiredFieldValidation(this.field);

  @override
  ValidationError? validate({required Map inputFormData}) {
    return inputFormData[field]?.isNotEmpty == true ? null : ValidationError.requiredField;
  }

}