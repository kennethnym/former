import 'package:example/my_form.dart';
import 'package:flutter/material.dart';
import 'package:former/former.dart';
import 'package:former/validators.dart';

void main() {
  runApp(FormerExampleApp());
}

class FormerExampleApp extends StatelessWidget {
  const FormerExampleApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Former example',
      home: Scaffold(
        body: SafeArea(
          child: Former(
            form: () => MyForm(),
            schema: () => MyFormSchema(
              username: StringValidator()
                ..min(10)
                ..max(50),
              email: StringValidator()..email(),
            ),
            child: _Form(),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormerTextField(field: MyFormField.username),
        FormerError(field: MyFormField.username),
        FormerTextField(field: MyFormField.email),
        FormerError(field: MyFormField.email),
        ElevatedButton(
          onPressed: () {
            Former.of(context, listen: false).submit();
          },
          child: Text('submit'),
        ),
      ],
    );
  }
}
