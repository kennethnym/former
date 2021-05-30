# Welcome to former

`former` is a form library for Flutter, inspired by `formik`.

## Motivation

[Formik](https://formik.org/) is one of my favorite React libraries. It is a form library that drastically reduces
boilerplate for keeping track of field values, validation, and form submission.

Form building in Flutter suffers from similar issues:

- Developers have to manually keep track of field values, for example using `TextEditingController`s.
- Validation and error handling requires imperative logic.

This is where `former` comes in.

## Features

- Enabling/disabling form globally
- Declarative form validation
- Automatic value tracking via `Former` form controls.
- Easy error handling with `FormerError` widget.
- Type-safe access of form.

## API reference

[API reference on pub.dev](https://pub.dev/documentation/former/latest/)
