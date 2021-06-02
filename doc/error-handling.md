# Error handling

`former` offers APIs that make it easy to handle form validation errors.

## The `FormerError` widget

`FormerError` is a `Text` widget that displays any validation error of a given field.
Like other form controls, it accepts all the arguments of a `Text` widget.

### An example

Let's consider the following schema:

```dart
FormSchema(
  field: NumberMust()..beAtLeast(10, 'too small!')
)
```

You can use the `FormerError` widget to display any validation error of the given field:

```dart
FormerError(field: Form.field)
```

If the field doesn't have any error, it will build an empty `Container`.
If there is an error, it will build a `Text` widget with the error message (in this case `'too small'!`) as the text.
The text will have an error color, taken from the `Theme` in context.

## Get error messages of a field

If you want to get the error message of a field, so that, for example,
you can build your own error message widget, you can use the `errorOf` method of `FormerProvider`:

```dart
final provider = Former.of<MyForm>(context);
final error = provider.errorOf(MyForm.myField);
```

If the field doesn't have any error, an empty string is returned.

## `FormInvalidException`

If you attempt to submit an invalid form, a `FormInvalidException` will be thrown. To catch it,
wrap your `Former.of(context).submit` call with a try-catch block:

```dart
try {
  Former.of(context).submit();
} on FormInvalidException catch (ex) {
  print('name of invalid form: ${ex.invalidForm}');
}
```
