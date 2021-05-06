import 'package:flutter/cupertino.dart';
import 'package:former/src/former_field.dart';
import 'package:former/src/former_form.dart';
import 'package:former/src/former_schema.dart';
import 'package:provider/provider.dart';

class FormerProvider<TForm extends FormerForm> extends ChangeNotifier {
  final TForm form;

  final FormerSchema _schema;

  bool _isFormEnabled = true;

  FormerProvider(this.form, this._schema);

  static FormerProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of(context, listen: listen);

  bool get isFormEnabled => _isFormEnabled;

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
    final isValid = _schema.validate(form);
    if (!isValid) {
      notifyListeners();
      return Future.value();
    }
    return form.submit();
  }
}

/// Automatically obtain the nearest [FormerProvider].
mixin FormerProviderMixin<T extends StatefulWidget> on State<T> {
  @protected
  late final FormerProvider formProvider;

  @override
  void initState() {
    super.initState();
    formProvider = FormerProvider.of(context, listen: false);
  }
}
