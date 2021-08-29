## [0.2.0] - official release 🎉!

Improvements:
- Former widgets now provide a more descriptive error message when the type of the form is not passed.
  For example:
  ```
  You must pass in the type of your form that this Former widget is consuming, so that the widget can locate and obtain the correct form.
  Example:

  FormerTextField<MyForm>(
                 ^^^^^^^^
                 Pass in the type of your form here.
    ...other params,
  ),

  This assertion is made by: FormerTextField
  ```

## [0.2.0-rc.1] - v2 release candidate 1

- Still figuring out pub versioning, to avoid confusion, I decided to do a release candidate release since there will
  unlikely be any other API breaking changes.

## [0.2.0-beta.5] - v2 pre-release (beta) 5

- No changes - bumped to beta for semantics.

## [0.2.0-dev.4] - v2 fourth dev release

New changes:

- `FormerForm.submit` now allows return values.
    - Subsequently, `FormerProvider.submit` now accepts a generic type that should match the return value
      of `FormerForm.submit`. For example, if `FormerForm.submit` returns `Future<String>`, `String` should be used as a
      type parameter to `FormerProvider.submit`.

Breaking changes:

- `FormerProvider.submit` now automatically disables the form during form submission until it gets a response back.
- `FormerProvider.submit` now throws a `FormInvalidException` if the form is invalid.

## [0.2.0-dev.3] - v2 third dev release

New features:

- `FormerProvider` now has a getter that verifies and returns whether the form is valid or not.

## [0.2.0-dev.2] - v2 second dev release

### Breaking changes

- `FormerError` now renders an empty `Container` if the given field does not have any error.

## [0.2.0-dev.1] - v2 dev release

### Breaking changes

- `FormerForm.submit` now requires a `BuildContext` parameter. Forms that extend `FormerForm`
  should have their `submit` methods updated accordingly.

## [0.1.0-dev.1] - Initial dev release

- Initial dev release
