import 'validator.dart';

class BoolValidator implements Validator<bool> {
  String _error = '';

  @override
  String get error => _error;

  final _validators = <ValidatorFunc<bool?>>[];

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

  void exist([String? errorMessage]) {
    _validators.add((value) {
      if (value == null) return errorMessage ?? 'The boolean is null.';
      return '';
    });
  }

  void beTrue([String? errorMessage]) {
    _validators.add((value) {
      if (value == null || !value)
        return errorMessage ?? 'The boolean is not true.';
      return '';
    });
  }

  void beFalse([String? errorMessage]) {
    _validators.add((value) {
      if (value == null || !value)
        return errorMessage ?? 'The boolean is not false.';
      return '';
    });
  }
}
