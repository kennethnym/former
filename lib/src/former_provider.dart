import 'package:flutter/cupertino.dart';
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

  /// Checks if the form is valid
  Future<void> submit() {
    if (!isFormValid) {
      return Future.value();
    }
    return form.submit(_context);
  }
}
