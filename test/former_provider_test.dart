import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:former/former.dart';
import 'package:mockito/mockito.dart';

import 'test_form.dart';

class _MockBuildContext extends Mock implements BuildContext {}

/// A callable class that is used as a test listener to [FormerProvider].
class _TestProviderListener extends Mock {
  void call();
}

void main() {
  late TestForm testForm;
  late TestFormSchema schema;
  late FormerProvider<TestForm> provider;

  setUp(() {
    testForm = TestForm();
    schema = testSchema;
    provider = FormerProvider(_MockBuildContext(), testForm, schema);
  });

  group('FormerProvider', () {
    test('should contain the given form', () {
      expect(provider.form, equals(testForm));
    });

    test('should enable form by default', () {
      expect(provider.isFormEnabled, isTrue);
    });

    test('should notify listeners when enabled state is changed', () {
      final listener = _TestProviderListener();

      provider
        ..addListener(listener)
        ..isFormEnabled = false;

      verify(listener()).called(1);
    });

    test('should have no error message before validation is performed', () {
      for (final field in TestFormField.all) {
        expect(provider.errorOf(field), isEmpty);
      }
    });

    test('should update field correctly', () {
      const newValue = '123';
      provider.update(field: TestFormField.stringField, withValue: newValue);
      expect(provider.form.stringField, newValue);
    });
  });
}
