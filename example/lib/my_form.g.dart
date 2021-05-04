// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_form.dart';

// **************************************************************************
// Generator: FormableBuilder
// **************************************************************************

class MyForm extends MyFormBase implements FormerForm {
  @override
  dynamic operator [](FormerField field) {
    switch (field.value) {
      case 0:
        return username;

      case 1:
        return email;
    }
  }

  @override
  void operator []=(FormerField field, dynamic newValue) {
    switch (field.value) {
      case 0:
        username = newValue;
        break;

      case 1:
        email = newValue;
        break;
    }
  }
}

/// All fields of [MyForm]
class MyFormField extends FormerField {
  const MyFormField._(int value) : super(value);

  static const all = [username, email];

  static const username = MyFormField._(0);
  static const email = MyFormField._(1);
}

class MyFormSchema implements FormerSchema<MyForm> {
  final StringValidator username;
  final StringValidator email;

  const MyFormSchema({
    required this.username,
    required this.email,
  });

  @override
  bool validate(MyForm form) {
    var isValid = true;

    isValid = username.validate(form.username);
    isValid = email.validate(form.email);

    return isValid;
  }
}
