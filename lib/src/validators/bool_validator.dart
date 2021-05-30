import 'validator.dart';

/// A [Validator] that validates a [bool] field.
/// It provides numerous constraints that can be imposed on the [bool] field.
///
/// Constraints can be chained together via the cascade operator `..`.
/// Constraints that come first take precedence.
///
/// Example:
/// ```
/// Former(
///   form: ...
///   schema: MySchema(
///     someBoolField: BoolMust()..exist()..beTrue(),
///   )
/// )
/// ```
///
/// In the above snippet, the [BoolMust] validator ensures that
/// `someBoolField` must exist and must be true.
class BoolMust implements Validator<bool> {
  String _error = '';

  @override
  String get error => _error;

  final _validators = <ValidatorFunc<bool>>[];

  @override
  bool validate(bool? value) {
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

  /// Instructs [BoolMust] to make sure the given value is not null.
  void exist([String? errorMessage]) {
    _validators.add((value) {
      if (value == null) return errorMessage ?? 'The boolean is null.';
      return '';
    });
  }

  /// Instructs [BoolMust] to make sure the given value is true.
  void beTrue([String? errorMessage]) {
    _validators.add((value) {
      if (value == null || !value)
        return errorMessage ?? 'The boolean is not true.';
      return '';
    });
  }

  /// Instructs [BoolMust] to make sure the given value is false.
  void beFalse([String? errorMessage]) {
    _validators.add((value) {
      if (value == null || value)
        return errorMessage ?? 'The boolean is not false.';
      return '';
    });
  }
}
