import 'package:flutter/material.dart';
import 'package:former/src/former_provider.dart';
import 'package:former/src/former_schema.dart';
import 'package:provider/provider.dart';

import '../former_form.dart';

typedef FormCreator<F extends FormerForm> = F Function();
typedef SchemaCreator = FormerSchema Function();

class Former<TForm extends FormerForm> extends StatelessWidget {
  /// A function that creates a [FormerForm].
  final FormCreator<TForm> form;

  final SchemaCreator schema;

  final Widget child;

  const Former({
    required this.form,
    required this.schema,
    required this.child,
  });

  static FormerProvider<TForm> of<TForm extends FormerForm>(BuildContext context,
          {bool listen = true}) =>
      Provider.of<FormerProvider<TForm>>(context, listen: listen);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormerProvider<TForm>(form(), schema()),
      child: child,
    );
  }
}
