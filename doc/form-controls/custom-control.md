# Custom control

In some cases the built-in controls just won't cut it.
`former` allows you to build custom form controls that will suit your needs the best.

Custom controls are just normal widgets that interact with `former`'s API.

## Obtaining `FormerProvider`

`FormerProvider` is a `ChangeNotifier` that holds the current form.
It provides various methods to interact with the form.
You can obtain the instance of `FormerProvider` that is controlling your form with:

```dart
final provider = Former.of<MyForm>(context);
```

The generic type must match the type of your form. Otherwise, `former` will not be able to locate
the provider.

## Value handling

Built-in controls handle value tracking and updating for you.
However, in a custom control, you need to do that manually.
`FormerProvider` has an `update` method that lets you update a field with the given value.

Let's assume you have a login form called `LoginForm`, and you want to update the `username` field.
To do so, call the `update` method as such:

```dart
provider.update(LoginFormField.username, 'NewUsername');
```

The first parameter takes in the field that you want to update, in this case `username` 
(The `LoginFormField` is automatically generated for you that includes all the fields of your form).
The second parameter takes in the new value that you want the field to hold, in this case `'NewUsername'`.
