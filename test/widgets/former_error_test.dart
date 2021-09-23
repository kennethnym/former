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

    testWidgets('should fail assertion if the type of the form is not passed',
        (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerError(field: TestFormField.stringField),
        ),
      );
      expect(tester.takeException(), isInstanceOf<AssertionError>());
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
        provider.update(field: TestFormField.stringField, withValue: '');
        await provider.submit();
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
        provider.update(field: TestFormField.stringField, withValue: '');
        await provider.submit();
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
        provider.update(field: TestFormField.stringField, withValue: '');
        await provider.submit();
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

    testWidgets('should use the given builder function to build widget',
        (tester) async {
      final errorWidget = GlobalKey();
      final customWidgetKey = GlobalKey();
      final childWidgetKey = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerError<TestForm>(
            key: errorWidget,
            field: TestFormField.stringField,
            builder: (context, error, child) => Container(
              key: customWidgetKey,
              child: Column(
                children: [
                  Text(error),
                  child!,
                ],
              ),
            ),
            child: Container(key: childWidgetKey),
          ),
        ),
      );

      final provider =
          Former.of<TestForm>(errorWidget.currentContext!, listen: false);

      try {
        await provider.submit();
      } on FormInvalidException {
        // exception is expected
      } finally {
        await tester.pump();
        // checks if the passed builder is appropriately called.
        expect(find.byKey(customWidgetKey), findsOneWidget);
        // checks if the error message is passed to the builder.
        expect(find.text(stringFieldError), findsOneWidget);
        // checks if the child is passed to the builder.
        expect(find.byKey(childWidgetKey), findsOneWidget);
      }
    });
  });
}
