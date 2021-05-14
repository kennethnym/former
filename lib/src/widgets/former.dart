import 'package:flutter/material.dart';
import 'package:former/src/former_provider.dart';
import 'package:former/src/former_schema.dart';
import 'package:provider/provider.dart';

import '../former_form.dart';

typedef FormCreator<F extends FormerForm> = F Function();
typedef SchemaCreator = FormerSchema Function();

/// Provides child widgets with the given form that needs to conform to the
/// given schema.
///
/// All Former controls should be under [Former],
/// and the form they are controlling should be provided by [Former].
///
/// Under the hood [Former] stores the form and the schema in [FormerProvider],
/// which child widgets can access with [Former.of].
///
/// ```
/// Former(
///   form: () => MyForm(),
///   schema: () => MyFormSchema(
///     field1: ...requirements,
///     field2: ...requirements,
///   ), // automatically generated
///   child: child,
/// ),
/// ```
class Former<TForm extends FormerForm> extends StatelessWidget {
  /// A function that creates a [FormerForm].
  final FormCreator<TForm> form;

  final SchemaCreator schema;

  final Widget child;

  /// Wraps child with [FormerProvider].
  /// Both [form] and [schema] are lazily created.
  ///
  /// The [schema] of the [form] can be created by instantiating the
  /// schema class that is generated for [form].
  const Former({
    required this.form,
    required this.schema,
    required this.child,
  });

  static FormerProvider<TForm> of<TForm extends FormerForm>(
          BuildContext context,
          {bool listen = true}) =>
      Provider.of<FormerProvider<TForm>>(context, listen: listen);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormerProvider<TForm>(context, form(), schema()),
      child: child,
    );
  }
}
