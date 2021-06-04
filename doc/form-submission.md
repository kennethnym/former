# Form submission

`former` submits form by calling the `submit` method of your form. The `submit` method of `FormerProvider` triggers form
submission:

```dart
final provider = Former.of<MyForm>(context);
provider.submit();
```

As mentioned in the [error handling](error-handling.md) section, `FormerProvider.submit`
throws a `FormInvalidException` if the form is invalid. During the submission, your form is automatically disabled.
Afterwards, your form is re-enabled.

## Returning results

Your `submit` method can return a value after submission.
To do so, your form's implementation of the `submit` method should return `Future<SomeValue>`, where
`SomeValue` is the type of the value that will be returned. Let's assume a `String` is returned.
The `submit` method should look like this:

```dart
@Formable()
abstract class _MyForm extends FormerForm {
  Future<String> submit(BuildContext context) async {
    // submission logic
    return '';
  }
}
```

Then, you should pass the type of the return value to `FormerProvider.submit`:

```dart
final provider = Former.of<MyForm>(context);
final result = provider.submit<String>();
```

Unfortunately, due to the limitation of Dart's type system, it is currently impossible to infer
the return type of your implementation of the `submit` method.

## Delegating submission to Bloc

It is also possible to delegate form submission to a bloc:

```dart
@Formable()
abstract class _MyForm extends FormerForm {
  Future<void> submit(BuildContext context) async {
    BlocProvider.of<MyBloc>(context).add(FormSubmitted(this));
  }
}
```

Your bloc can get the form in two ways:

- From the event object added (as shown above),
- Obtain the form with `Former.of(context).form`.

Pick an approach depending on your use case.
