import 'package:project_test/presentation/dependencies/dependencies.dart';

abstract class FieldValidation {
  String get field;
  ValidationError? validate({required Map inputFormData});
}