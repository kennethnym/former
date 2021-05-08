import 'package:former/former.dart';
import 'package:former/validators.dart';

class TestForm implements FormerForm {
  String stringField = '';
  int intField = 0;
  bool boolField = false;

  @override
  dynamic operator [](FormerField field) {
    switch (field.value) {
      case 0:
        return stringField;
      case 1:
        return intField;
      case 2:
        return boolField;
    }
  }

  @override
  void operator []=(FormerField field, newValue) {
    switch (field.value) {
      case 0:
        stringField = newValue;
        break;
      case 1:
        intField = newValue;
        break;
      case 2:
        boolField = newValue;
        break;
    }
  }

  @override
  Future<void> submit() {
    return Future.value();
  }
}

class TestFormField extends FormerField {
  const TestFormField._(int value) : super(value);

  static const all = [stringField, intField, boolField];

  static const stringField = TestFormField._(0);
  static const intField = TestFormField._(1);
  static const boolField = TestFormField._(2);
}

class TestFormSchema extends FormerSchema<TestForm> {
  final StringMust stringField;
  final NumberMust intField;
  final BoolMust boolField;

  TestFormSchema({
    required this.stringField,
    required this.intField,
    required this.boolField,
  });

  @override
  String errorOf(FormerField field) {
    switch (field.value) {
      case 0:
        return stringField.error;
      case 1:
        return intField.error;
      case 2:
        return boolField.error;
      default:
        return '';
    }
  }

  @override
  bool validate(TestForm form) => [
        stringField.validate(form.stringField),
        intField.validate(form.intField),
        boolField.validate(form.boolField),
      ].every(fieldIsValid);
}

const stringFieldError = 'is empty';
const intFieldError = 'is negative';
const boolFieldError = 'does not exist';

final testSchema = TestFormSchema(
  stringField: StringMust()..notBeEmpty(stringFieldError),
  intField: NumberMust()..bePositive(intFieldError),
  boolField: BoolMust()..exist(boolFieldError),
);
