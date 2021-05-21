import 'package:flutter/cupertino.dart';
import 'package:former/src/exceptions/form_invalid_exception.dart';
import 'package:former/src/former_field.dart';
import 'package:former/src/former_form.dart';
import 'package:former/src/former_schema.dart';
import 'package:provider/provider.dart';

class FormerProvider<TForm extends FormerForm> extends ChangeNotifier {
  final TForm form;

  final BuildContext _context;

  final FormerSchema _schema;

  bool _isFormEnabled = true;

  FormerProvider(this._context, this.form, this._schema);

  static FormerProvider<TForm> of<TForm extends FormerForm>(
          BuildContext context,
          {bool listen = true}) =>
      Provider.of(context, listen: listen);

  bool get isFormEnabled => _isFormEnabled;

  /// Validates [form] that it conforms to the schema and returns whether
  /// it is valid. Listeners of [FormerProvider] are notified when this getter
  /// is called.
  bool get isFormValid {
    final isValid = _schema.validate(form);
    notifyListeners();
    return isValid;
  }

  set isFormEnabled(bool isEnabled) {
    _isFormEnabled = isEnabled;
    notifyListeners();
  }

  /// Retrieves the error message of [field]. Empty if [field] is valid.
  String errorOf(FormerField field) => _schema.errorOf(field);

  /// Updates [field] of [FormerProvider.form] with [withValue].
  void update({required FormerField field, required dynamic withValue}) {
    form[field] = withValue;
  }

  /// Checks if [form] is valid, then submits [form] by calling
  /// [FormerForm.submit]. ([FormerForm] is extended by your own form classes,
  /// so [FormerForm.submit] should contain your own implementations of how to
  /// submit the forms).
  ///
  /// If [form] is invalid, [FormInvalidException] is thrown.
  /// The name of the invalid form is available as [FormInvalidException.invalidForm].
  ///
  /// [form] is automatically disabled until [FormerForm.submit] finishes.
  /// [form] will then be re-enabled.
  ///
  /// Accepts generic parameter [T] that should match the return value
  /// of the submit method of your form. For example, if your form's submit
  /// method returns `Future<String>`, then [T] should be [String]. Skip [T]
  /// if it returns `Future<void>`
  Future<T> submit<T>() async {
    isFormEnabled = false;

    if (!isFormValid) {
      throw FormInvalidException(TForm);
    }

    final result = await form.submit(_context);
    isFormEnabled = true;

    return result;
  }
}
