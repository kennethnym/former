import 'package:flutter_test/flutter_test.dart';

import 'package:former/former.dart';

import 'test_form.dart';

void main() {
  late TestForm testForm;
  late TestFormSchema schema;
  late FormerProvider<TestForm> provider;

  setUpAll(() {
    testForm = TestForm();
    schema = TestFormSchema();
    provider = FormerProvider(testForm, schema);
  });

  group('FormerProvider', () {
    test('should contain the given form', () {
      expect(provider.form, equals(testForm));
    });
  });
}
