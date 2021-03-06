import 'validator.dart';

/// A [Validator] that validates a number field. This includes:
///   - [int]
///   - [double]
///   - [num].
///
/// [NumberMust] provides numerous constraints that can be imposed on the number field.
///
/// Constraints can be chained together via the cascade operator `..`.
/// Constraints that come first take precedence.
///
/// Example:
/// ```
/// Former(
///   form: ...
///   schema: MySchema(
///     someIntField: NumberMust()..beWithin(0, 10)
///   )
/// )
/// ```
/// In the above snippet, the [NumberMust] validator ensures that
/// `someIntField` must be within 0 and 10, inclusive on both ends.
class NumberMust implements Validator<num> {
  String _error = '';

  final _validators = <ValidatorFunc<num?>>[];

  @override
  String get error => _error;

  @override
  bool validate(num? value) {
    for (final validator in _validators) {
      final err = validator(value);
      if (err.isNotEmpty) {
        _error = err;
        return false;
      }
    }
    _error = '';
    return true;
  }

  /// Instructs [NumberMust] to make sure the given value is not null.
  void exist([String? errorMessage]) {
    _validators.add((value) {
      if (value == null) return errorMessage ?? 'The number is null';
      return '';
    });
  }

  /// Instructs [NumberMust] to make sure the given number
  /// is an integer, i.e. no decimal places.
  void beInteger([String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value is! int)
        return errorMessage ?? 'The number is not an integer.';
      return '';
    });
  }

  /// Instructs [NumberMust] to make sure the given number
  /// is not smaller than [min].
  void beAtLeast(num min, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value < min)
        return errorMessage ?? 'Number is smaller than $min.';
      return '';
    });
  }

  /// Instructs [NumberMust] to make sure the given number
  /// is not bigger than [max].
  void beAtMost(num max, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value > max)
        return errorMessage ?? 'Number is larger than $max.';
      return '';
    });
  }

  /// Instructs [NumberMust] to make sure the given number
  /// is positive.
  void bePositive([String? errorMessage]) {
    beAtLeast(0, errorMessage);
  }

  /// Instructs [NumberMust] to make sure the given number
  /// is negative.
  void beNegative([String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value >= 0) {
        return errorMessage ?? 'Number is not negative';
      }
      return '';
    });
  }

  /// Instructs [NumberMust] to make sure the given number
  /// is within the range [min] and [max], both end inclusive.
  void beWithin(num min, num max, [String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value < min || value > max)
        return errorMessage ?? 'Number is not within $min and $max';
      return '';
    });
  }
}
