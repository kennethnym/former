import 'package:flutter/material.dart';
import 'package:former/src/former_provider.dart';
import 'package:former/src/former_schema.dart';
import 'package:provider/provider.dart';

import '../former_form.dart';

typedef FormCreator = FormerForm Function();
typedef SchemaCreator = FormerSchema Function();

class Former extends StatelessWidget {
  /// A function that creates a [FormerForm].
  final FormCreator form;

  final SchemaCreator schema;

  final Widget child;

  const Former({
    required this.form,
    required this.schema,
    required this.child,
  });

  static FormerProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of(context, listen: listen);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormerProvider(form(), schema()),
      child: child,
    );
  }
}
