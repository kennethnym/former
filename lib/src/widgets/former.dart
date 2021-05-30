import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../former_form.dart';
import '../former_provider.dart';
import '../former_schema.dart';

/// A function that creates a [FormerForm].
typedef FormCreator<F extends FormerForm> = F Function();

/// A function that creates a [FormerSchema] for a [FormerForm].
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

  /// A function that creates a [FormerSchema] for a [FormerForm].
  final SchemaCreator schema;

  /// Child [Widget] that can consume [FormerForm].
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

  /// Retrieves the [FormerProvider] in [context].
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
