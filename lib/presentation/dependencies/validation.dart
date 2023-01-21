abstract class ValidationUI {
  ValidationError? validate({required String field, required Map inputFormData});
}

enum ValidationError {
  requiredField,
  invalidField,
  minLength,
}