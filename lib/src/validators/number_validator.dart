import 'validator.dart';

class NumberValidator implements Validator {
  String _error = '';

  final _validators = <ValidatorFunc<num>>[];

  @override
  String get error => _error;

  @override
  bool validate(value) {
    for (final validator in _validators) {
      final err = validator(value);
      if (err.isNotEmpty) {
        _error = err;
        return false;
      }
    }
    return true;
  }

  /// Instructs [NumberValidator] to make sure the given number
  /// is an integer, i.e. no decimal places.
  void isInteger([String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value is! int)
        return errorMessage ?? 'The number is not an integer.';
      return '';
    });
  }

  /// Instructs [NumberValidator] to make sure the given number
  /// is not smaller than [min].
  void min(num min, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value < min)
        return errorMessage ?? 'Number is smaller than $min.';
      return '';
    });
  }

  /// Instructs [NumberValidator] to make sure the given number
  /// is not bigger than [max].
  void max(num max, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value > max)
        return errorMessage ?? 'Number is larger than $max.';
      return '';
    });
  }

  /// Instructs [NumberValidator] to make sure the given number
  /// is positive.
  void isPositive([String? errorMessage]) {
    min(0, errorMessage);
  }

  /// Instructs [NumberValidator] to make sure the given number
  /// is negative.
  void isNegative([String? errorMessage]) {
    min(-1, errorMessage);
  }

  /// Instructs [NumberValidator] to make sure the given number
  /// is within the range [min] and [max], both end inclusive.
  void within(num min, num max, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value < min || value > max)
        return errorMessage ?? 'Number is not within $min and $max';
      return '';
    });
  }
}
