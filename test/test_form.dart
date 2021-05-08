import 'package:former/former.dart';
import 'package:former/validators.dart';

class TestForm extends FormerForm {
  String stringField = '';
  int intField = 0;
  int? nullableIntField = 0;
  bool boolField = false;

  @override
  final Map<FormerField, String> fieldType = {
    TestFormField.stringField: 'String',
    TestFormField.intField: 'int',
    TestFormField.nullableIntField: 'int?',
    TestFormField.boolField: 'bool',
  };

  @override
  dynamic operator [](FormerField field) {
    switch (field.value) {
      case 0:
        return stringField;
      case 1:
        return intField;
      case 2:
        return nullableIntField;
      case 3:
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
        nullableIntField = newValue;
        break;
      case 3:
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

  static const all = [stringField, intField, nullableIntField, boolField];

  static const stringField = TestFormField._(0);
  static const intField = TestFormField._(1);
  static const nullableIntField = TestFormField._(2);
  static const boolField = TestFormField._(3);
}

class TestFormSchema extends FormerSchema<TestForm> {
  final StringMust stringField;
  final NumberMust intField;
  final NumberMust nullableIntField;
  final BoolMust boolField;

  TestFormSchema({
    required this.stringField,
    required this.intField,
    required this.nullableIntField,
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
        return nullableIntField.error;
      case 3:
        return boolField.error;
      default:
        return '';
    }
  }

  @override
  bool validate(TestForm form) => [
        stringField.validate(form.stringField),
        intField.validate(form.intField),
        nullableIntField.validate(form.nullableIntField),
        boolField.validate(form.boolField),
      ].every(fieldIsValid);
}

const stringFieldError = 'is empty';
const intFieldError = 'is negative';
const boolFieldError = 'does not exist';

final testSchema = TestFormSchema(
  stringField: StringMust()..notBeEmpty(stringFieldError),
  intField: NumberMust()..bePositive(intFieldError),
  nullableIntField: NumberMust(),
  boolField: BoolMust()..exist(boolFieldError),
);
