import 'package:former/src/validators/validator.dart';

class StringValidator implements Validator<String> {
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

  /// Instructs [StringValidator] to check
  /// whether the given value matches [pattern].
  void matches(RegExp pattern, [String? errorMessage]) {
    final err = errorMessage ?? 'String does not match pattern $pattern';
    _validators.add((value) {
      if (value == null) return err;
      final match = pattern.hasMatch(value);
      if (match) return '';
      return err;
    });
  }

  /// Instructs [StringValidator] to make sure the given string is not empty.
  void notEmpty([String? errorMessage]) {
    _validators.add(
      (value) => value == null || value.isEmpty
          ? errorMessage ?? 'String is empty or is null'
          : '',
    );
  }

  /// Instructs [StringValidator] to make sure the given string is a valid email.
  /// Note that this is just a simple regex check from ihateregex.io that
  /// should cover most use cases. The backend should be responsible for
  /// anything more complicated.
  void email([String? errorMessage]) {
    matches(RegExp('[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+'),
        errorMessage ?? 'The string is not a valid email address.');
  }

  /// Instructs [StringValidator] to make sure the given string
  /// is at least [len] characters long.
  void min(int len, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value.length < len)
        return errorMessage ?? 'String is shorter than $len.';
      return '';
    });
  }

  /// Instructs [StringValidator] to make sure the given string
  /// is at most [len] characters long.
  void max(int len, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value.length > len)
        return errorMessage ?? 'String is longer than $len.';
      return '';
    });
  }
}
