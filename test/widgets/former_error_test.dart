import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:former/former.dart';
import 'package:former/src/exceptions/form_invalid_exception.dart';

import '../test_form.dart';
import 'wrap_with_former.dart';

void main() {
  group('FormerError', () {
    testWidgets('should build correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerError<TestForm>(field: TestFormField.stringField),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('should show error of the field', (tester) async {
      final error = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerError<TestForm>(
            key: error,
            field: TestFormField.stringField,
          ),
        ),
      );

      // should be empty initially
      expect(find.byType(Text), findsNothing);

      final provider =
          Former.of<TestForm>(error.currentContext!, listen: false);

      try {
        // update with an invalid value
        provider
          ..update(field: TestFormField.stringField, withValue: '')
          ..submit();
      } on FormInvalidException catch (_) {
        // exception is expected
      } finally {
        await tester.pump();
        // should show error message
        expect(find.text(stringFieldError), findsOneWidget);
      }
    });

    testWidgets('should have default red color', (tester) async {
      final error = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerError<TestForm>(
            key: error,
            field: TestFormField.stringField,
          ),
        ),
      );

      final provider =
          Former.of<TestForm>(error.currentContext!, listen: false);

      try {
        // update with an invalid value
        provider
          ..update(field: TestFormField.stringField, withValue: '')
          ..submit();
      } on FormInvalidException catch (_) {
        // exception is expected
      } finally {
        await tester.pump();

        final finder = find.text(stringFieldError);
        final Text text = tester.firstWidget(finder);

        expect(text.style?.color, Theme.of(error.currentContext!).errorColor);
      }
    });

    testWidgets('should use the given style', (tester) async {
      final error = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerError<TestForm>(
            key: error,
            field: TestFormField.stringField,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      final provider =
          Former.of<TestForm>(error.currentContext!, listen: false);

      try {
        // update with an invalid value
        provider
          ..update(field: TestFormField.stringField, withValue: '')
          ..submit();
      } on FormInvalidException catch (_) {
        // exception is expected
      } finally {
        await tester.pump();

        final finder = find.text(stringFieldError);
        final Text text = tester.firstWidget(finder);

        expect(text.style?.color, Colors.black);
        expect(text.style?.fontWeight, FontWeight.bold);
      }
    });
  });
}
