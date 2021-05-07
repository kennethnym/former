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

      case 2:
        return age;

      case 3:
        return shouldSendNewsletter;

      case 4:
        return shouldEnableAnalytics;
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

      case 2:
        age = newValue;
        break;

      case 3:
        shouldSendNewsletter = newValue;
        break;

      case 4:
        shouldEnableAnalytics = newValue;
        break;
    }
  }
}

/// All fields of [_MyForm]
class MyFormField extends FormerField {
  const MyFormField._(int value) : super(value);

  static const all = [
    username,
    email,
    age,
    shouldSendNewsletter,
    shouldEnableAnalytics
  ];

  static const username = MyFormField._(0);
  static const email = MyFormField._(1);
  static const age = MyFormField._(2);
  static const shouldSendNewsletter = MyFormField._(3);
  static const shouldEnableAnalytics = MyFormField._(4);
}

/// A [FormerSchema] that [_MyForm] needs to conform to.
class MyFormSchema extends FormerSchema<_MyForm> {
  final StringMust username;
  final StringMust email;
  final NumberMust age;
  final BoolMust shouldSendNewsletter;
  final BoolMust shouldEnableAnalytics;

  const MyFormSchema({
    required this.username,
    required this.email,
    required this.age,
    required this.shouldSendNewsletter,
    required this.shouldEnableAnalytics,
  });

  @override
  String errorOf(FormerField field) {
    switch (field.value) {
      case 0:
        return username.error;

      case 1:
        return email.error;

      case 2:
        return age.error;

      case 3:
        return shouldSendNewsletter.error;

      case 4:
        return shouldEnableAnalytics.error;

      default:
        return '';
    }
  }

  @override
  bool validate(_MyForm form) => [
        username.validate(form.username),
        email.validate(form.email),
        age.validate(form.age),
        shouldSendNewsletter.validate(form.shouldSendNewsletter),
        shouldEnableAnalytics.validate(form.shouldEnableAnalytics),
      ].every(fieldIsValid);
}
