# [Work in progress] former

Easy form building in Flutter.

## Motivation

[Formik](https://formik.org/) is one of my favorite React libraries. It is a form library that
drastically reduces boilerplate for keeping track of field values, validation, and form submission.

Form building in Flutter suffers from similar issues:

- Developers have to manually keep track of field values, for example using `TextEditingController`s. 
- Validation and error handling requires imperative logic.

This is where `former` comes in.

## Features

`former` provides the following features:

- Enabling/disabling form globally
- Declarative form validation
- Automatic value tracking via `Former` widgets
- Easy error handling with `FormerError` widget.
- Type-safe access of form.

## Example

Consider the following form:

```dart
part 'my_form.g.dart';

class MyForm = _MyForm with _$MyFormIndexable;

@Formable()
abstract class _MyForm implements FormerForm {
  String username = '';
  String email = '';

  @FormableIgnore()
  String ignored = '';

  @override
  Future<void> submit() {
    // TODO: implement submit
    return Future.value();
  }
}
```

- The `FormerForm` interface allows form classes to interface with the API.
- `@Formable` tells `former` to generate the following for the annotated form class:
    - `_$<form-name>Indexable`: makes the form "indexable" via the bracket operator
    - A `<form-name>Field` (in this case `MyFormField`) enum class that contains all the fields
    of a form.
    - A `<form-name>Schema` (in this case `MyFormSchema`) that lets you define the schema of the form.
- `@FormableIgnore` tells `former` to not treat the annotated field as part of the form.

Form validation in `former` is done in a declarative way. Simply create an instance of the schema class
that is generated for you, and pass in different `Validator`s depending on the
requirement of the field:

```dart
MyFormSchema(
  username: StringMust()
    ..hasMinLength(10)
    ..hasMaxLength(50),
  email: StringMust()..beAnEmail(),
);
```

- the `username` field should be a string with at least 10 characters and at most 50 characters.
- the `email` field should contain a valid email.

To consume the form,

```dart
MaterialApp(
  title: 'Former example',
  home: Scaffold(
    body: SafeArea(
      child: Former<MyForm>(
        form: () => MyForm(),
        schema: () => MyFormSchema(
          username: StringMust()
            ..hasMinLength(10)
            ..hasMaxLength(50),
          email: StringMust()..beAnEmail(),
        ),
        child: _Form(),
      ),
    ),
  ),
);
```

the `_Form` widget:

```dart
Column(
  children: [
    FormerTextField<MyForm>(field: MyFormField.username),
    FormerError<MyForm>(field: MyFormField.username),
    FormerTextField<MyForm>(field: MyFormField.email),
    FormerError<MyForm>(field: MyFormField.email),
    ElevatedButton(
      onPressed: () {
        Former.of<MyForm>(context, listen: false).submit();
      },
      child: Text('submit'),
    ),
  ],
);
```

- The `MyForm` type passed to the former controls allow them to find the correct form object in context.
- `FormerTextField` automatically updates the given field of `MyForm` (`username` and `email`)
whenever there are changes
- `FormerError` displays an error message whenever the given field is invalid.

The form state is all stored in a `ChangeNotifier` that is provided by `ChangeNotifierProvider`.
Therefore, it is possible to obtain the form and its state *without* using `former` widgets.
You can always roll your own form components that consume the current form via `Former.of<TForm extends FormerForm>`.
The provider provides the following:

- `Former.of<MyForm>(context).form`, the current form. You can use it to retrieve the current value of a field,
e.g. `form.username`
- `Former.of<MyForm>(context).errorOf(field)` retrieves the error message of the given field
- `Former.of<MyForm>(context).submit()` validates and submits the form.
