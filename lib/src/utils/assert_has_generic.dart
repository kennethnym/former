import '../former_form.dart';

/// Asserts that [TForm] is given to the former widget with the name [forWidget].
/// Used by Former widgets to ensure that the type of the form is passed,
/// so that they can locate and obtain the correct form.
///
/// Example:
/// ```
/// // Asserts that the type LoginForm is passed to FormerTextField.
/// assertHasGeneric<LoginForm>(forWidget: 'FormerTextField');
/// ```
void assertHasGeneric<TForm extends FormerForm>({required String forWidget}) {
  assert(
    TForm != FormerForm,
    '''You must pass in the type of your form that this Former widget is consuming, so that the widget can locate and obtain the correct form.
Example:

$forWidget<MyForm>(
${' ' * forWidget.length}^^^^^^^^
          Pass in the type of your form here.

  ...other params,
),

This assertion is made by: $forWidget''',
  );
}
