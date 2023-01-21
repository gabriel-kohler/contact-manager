import '../../presentation/dependencies/dependencies.dart';
import '../dependencies/dependencies.dart';

class EmailValidation implements FieldValidation {

  @override
  final String field;

  EmailValidation(this.field);

  @override
  ValidationError? validate({required Map inputFormData}) {
    final value = inputFormData[field];

    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);

    return isValid ? null : ValidationError.invalidField;
  }
}