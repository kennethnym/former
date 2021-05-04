import 'package:flutter/widgets.dart';
import 'package:former/src/former_provider.dart';
import 'package:former/src/former_field.dart';
import 'package:provider/provider.dart';

typedef FieldUpdater<T> = void Function(T newValue);

typedef FieldBuilder<T> = Widget Function(
    BuildContext context, T value, FieldUpdater<T> updateField, Widget? child);

class Field<T> extends StatelessWidget {
  final FormerField field;
  final FieldBuilder<T> builder;
  final Widget? child;

  const Field({
    required this.field,
    required this.builder,
    this.child,
  });

  FieldUpdater<T> _updateField(BuildContext context) => (T newValue) {
        FormerProvider.of(context).update(field: field, withValue: newValue);
      };

  @override
  Widget build(BuildContext context) {
    return Selector<FormerProvider, T>(
      selector: (_, provider) => provider.form[field],
      builder: (context, value, child) =>
          builder(context, value, _updateField(context), child),
      child: child,
    );
  }
}
