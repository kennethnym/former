# Validation

`former` has a fluent, declarative API for performing form validation.

## Built-in validators

Below is a list of validators that `former` comes with.

- `BoolValidator` validates a bool field.
- `NumberValidator` validates a number field.
- `StringValidator` validates a string field.

## Custom error messages

By default, every constraint method of the built-in validators has a default error message
whenever validation fails. You can pass in a custom error message as the last argument to the constraint methods to
override the default messages.

```dart
StringMust()..beAnEmail('Please enter a valid email!');
```

`FormerError` will display the custom error messages if given, instead of the default error messages.

## Custom validators

You can create custom validators that validate fields of custom types.
Create a class that implements `Validator`, and pass in the type that you want to validate 
through the type parameter of `Validator`. Then, implement all the required methods.

### Example

Below shows a simple `Validator` that validates values of type `User`.

```dart
class UserValidator extends Validator<User> {
  /// The error message as a result of an invalid value.
  String _error = '';
  
  @override
  String get error => _error;
  
  /// Returns false if [value] is invalid, true if valid.
  @override
  bool validate(User? value) {
    // validation logic
  }
}
```

### Fluent API convention

Below are conventions for a fluent `Validator` API similar to the built-in validators.

- Validator name **SHOULD** follow `<type-name>Must`, so that it forms a complete sentence
  with its methods.
- Constraint methods **SHOULD** form a complete sentence with the validator name. For example
  `UserMust()..hasAUsername()`
- Constraint methods **SHOULD** return `void`, and **SHOULD NOT** return `this`.
