// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_form.dart';

// **************************************************************************
// Generator: FormableBuilder
// **************************************************************************

mixin _$MyFormIndexable on _MyForm {
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

/// All fields of [_MyForm]
class MyFormField extends FormerField {
  const MyFormField._(int value) : super(value);

  static const all = [username, email];

  static const username = MyFormField._(0);
  static const email = MyFormField._(1);
}

/// A [FormerSchema] that [_MyForm] needs to conform to.
class MyFormSchema implements FormerSchema<_MyForm> {
  final StringValidator username;
  final StringValidator email;

  const MyFormSchema({
    required this.username,
    required this.email,
  });

  @override
  bool validate(_MyForm form) {
    var isValid = true;

    isValid = username.validate(form.username);
    isValid = email.validate(form.email);

    return isValid;
  }
}
