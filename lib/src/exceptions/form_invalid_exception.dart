/// Thrown when [FormerForm] is submitted but it does not conform to its schema.
class FormInvalidException implements Exception {
  /// The name of the invalid form that caused this exception.
  final String invalidForm;

  FormInvalidException(Type formType) : invalidForm = formType.toString();

  @override
  String toString() {
    return 'You tried to submit $invalidForm, but $invalidForm is invalid '
        'because it does not conform to the requirements '
        'described by ${invalidForm}Schema.';
  }
}
