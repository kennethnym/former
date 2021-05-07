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
          child: Former<MyForm>(
            form: () => MyForm(),
            schema: () => MyFormSchema(
              username: StringValidator()
                ..min(10)
                ..max(50),
              email: StringValidator()..email(),
              age: NumberValidator()
                ..min(1)
                ..max(150),
              shouldEnableAnalytics: BoolValidator()..exist(),
              shouldSendNewsletter: BoolValidator()..exist(),
            ),
            child: _Form(),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  bool _isFormEnabled = true;

  void _toggleForm(bool isEnabled) {
    Former.of(context, listen: false).isFormEnabled = isEnabled;
    setState(() {
      _isFormEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('enable form?'),
            Switch(
              value: _isFormEnabled,
              onChanged: _toggleForm,
            ),
          ],
        ),
        FormerTextField<MyForm>(field: MyFormField.username),
        FormerError<MyForm>(field: MyFormField.username),
        FormerTextField<MyForm>(field: MyFormField.email),
        FormerError<MyForm>(field: MyFormField.email),
        FormerSlider<MyForm>(field: MyFormField.age, min: 1, max: 100),
        FormerError<MyForm>(field: MyFormField.age),
        FormerCheckbox<MyForm>(field: MyFormField.shouldEnableAnalytics),
        FormerError<MyForm>(field: MyFormField.shouldEnableAnalytics),
        FormerSwitch<MyForm>(field: MyFormField.shouldSendNewsletter),
        FormerError<MyForm>(field: MyFormField.shouldSendNewsletter),
        ElevatedButton(
          onPressed: () {
            Former.of<MyForm>(context, listen: false).submit();
          },
          child: Text('submit'),
        ),
      ],
    );
  }
}
