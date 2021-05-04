import 'package:flutter/cupertino.dart';
import 'package:former/src/former_field.dart';
import 'package:former/src/former_form.dart';
import 'package:provider/provider.dart';

class FormerProvider extends ChangeNotifier {
  final FormerForm form;

  bool _isFormEnabled = true;

  FormerProvider(this.form);

  static FormerProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of(context, listen: listen);

  bool get isFormEnabled => _isFormEnabled;

  set isFormEnabled(bool isEnabled) {
    _isFormEnabled = isEnabled;
    notifyListeners();
  }

  /// Updates [field] of [FormerProvider.form] with [withValue].
  void update({required FormerField field, required dynamic withValue}) {
    form[field] = withValue;
  }
}

/// Automatically obtain the nearest [FormerProvider].
mixin FormProviderMixin<T extends StatefulWidget> on State<T> {
  @protected
  late final FormerProvider formProvider;

  @override
  void initState() {
    super.initState();
    formProvider = FormerProvider.of(context, listen: false);
  }
}
