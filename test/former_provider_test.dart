import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:former/former.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'former_provider_test.mocks.dart';
import 'test_form.dart';

class _MockBuildContext extends Mock implements BuildContext {}

/// A callable class that is used as a test listener to [FormerProvider].
class _TestProviderListener extends Mock {
  void call();
}

@GenerateMocks([TestForm])
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

    test('should validate form and return whether it is valid', () {
      final listener = _TestProviderListener();

      provider.addListener(listener);

      final isFormValid = provider.isFormValid;

      expect(isFormValid, isFalse);
      verify(listener()).called(1);

      testForm.stringField = '123';

      final isFormValid2 = provider.isFormValid;

      expect(isFormValid2, isTrue);
      verify(listener()).called(1);
    });

    test('should validate form and return whether it is valid', () {
      final listener = _TestProviderListener();

      provider.addListener(listener);

      final isFormValid = provider.validateForm();

      expect(isFormValid, isFalse);
      verifyNever(listener());

      testForm.stringField = '123';

      final isFormValid2 = provider.validateForm();

      expect(isFormValid2, isTrue);
      verifyNever(listener());
    });

    test(
        'should throw FormInvalidException if the form being submitted is invalid',
        () async {
      try {
        await provider.submit<String>();
      } on FormInvalidException catch (ex) {
        expect(ex.invalidForm, 'TestForm');
      }
    });

    test('should call FormerForm.submit when submit is called', () async {
      final mockBuildContext = _MockBuildContext();
      testForm = MockTestForm();
      provider = FormerProvider(mockBuildContext, testForm, testSchema);

      when(testForm.stringField).thenReturn('123');
      when(testForm.intField).thenReturn(0);
      when(testForm.nullableIntField).thenReturn(0);
      when(testForm.nullableDoubleField).thenReturn(0.0);
      when(testForm.boolField).thenReturn(false);
      when(testForm.submit(mockBuildContext))
          .thenAnswer((realInvocation) async => null);

      await provider.submit();
      verify(testForm.submit(mockBuildContext)).called(1);
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

    test('should notify listeners when rebuild() is called', () {
      final listener = _TestProviderListener();
      provider.addListener(listener);

      provider
        ..form.stringField = '123'
        ..rebuild();

      verify(listener()).called(1);
    });
  });
}
