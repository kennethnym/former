/// A function that validates [value]
/// and returns error message if any, or an empty string.
typedef ValidatorFunc<T> = String Function(T value);

abstract class Validator<T> {
  /// The error message as a result of a failed validation.
  /// This is empty if the previous validation is passed.
  String get error;

  /// Validates [value]. Returns whether the value is valid.
  bool validate(T value);
}
