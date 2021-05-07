import 'package:former/src/validators/validator.dart';

class StringMust implements Validator<String> {
  String _error = '';

  final _validators = <ValidatorFunc<String?>>[];

  // The error message as a result of a previous validation.
  @override
  String get error => _error;

  @override
  bool validate(String? value) {
    for (final validator in _validators) {
      final err = validator(value);
      if (err.isNotEmpty) {
        print(err);
        _error = err;
        return false;
      }
    }
    return true;
  }

  /// Instructs [StringMust] to check
  /// whether the given value matches [pattern].
  void match(RegExp pattern, [String? errorMessage]) {
    final err = errorMessage ?? 'String does not match pattern $pattern';
    _validators.add((value) {
      if (value == null) return err;
      final match = pattern.hasMatch(value);
      if (match) return '';
      return err;
    });
  }

  /// Instructs [StringMust] to make sure the given string is not empty.
  void notBeEmpty([String? errorMessage]) {
    _validators.add(
      (value) => value == null || value.isEmpty
          ? errorMessage ?? 'String is empty or is null'
          : '',
    );
  }

  /// Instructs [StringMust] to make sure the given string is a valid email.
  /// Note that this is just a simple regex check from ihateregex.io that
  /// should cover most use cases. The backend should be responsible for
  /// anything more complicated.
  void beAnEmail([String? errorMessage]) {
    match(RegExp('[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+'),
        errorMessage ?? 'The string is not a valid email address.');
  }

  /// Instructs [StringMust] to make sure the given string
  /// is at least [len] characters long.
  void hasMinLength(int len, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value.length < len)
        return errorMessage ?? 'String is shorter than $len.';
      return '';
    });
  }

  /// Instructs [StringMust] to make sure the given string
  /// is at most [len] characters long.
  void hasMaxLength(int len, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value.length > len)
        return errorMessage ?? 'String is longer than $len.';
      return '';
    });
  }
}
