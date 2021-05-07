import 'package:former/former.dart';
import 'package:former/validators.dart';

class TestForm implements FormerForm {
  String field1 = '';
  int field2 = 0;
  bool field3 = false;

  @override
  dynamic operator [](FormerField field) {
    switch (field.value) {
      case 0:
        return field1;
      case 1:
        return field2;
      case 2:
        return field3;
    }
  }

  @override
  void operator []=(FormerField field, newValue) {
    switch (field.value) {
      case 0:
        field1 = newValue;
        break;
      case 1:
        field2 = newValue;
        break;
      case 2:
        field3 = newValue;
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

  static const all = [field1, field2, field3];

  static const field1 = TestFormField._(0);
  static const field2 = TestFormField._(1);
  static const field3 = TestFormField._(2);
}

class TestFormSchema extends FormerSchema<TestForm> {
  final StringMust field1;
  final NumberMust field2;
  final BoolMust field3;

  TestFormSchema({
    required this.field1,
    required this.field2,
    required this.field3,
  });

  @override
  String errorOf(FormerField field) {
    switch (field.value) {
      case 0:
        return field1.error;
      case 1:
        return field2.error;
      case 2:
        return field3.error;
      default:
        return '';
    }
  }

  @override
  bool validate(TestForm form) => [
        field1.validate(form.field1),
        field2.validate(form.field2),
        field3.validate(form.field3),
      ].every(fieldIsValid);
}
