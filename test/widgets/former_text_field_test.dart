import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:former/former.dart';

import '../test_form.dart';
import 'wrap_with_former.dart';

void main() {
  group('FormerTextField', () {
    testWidgets('should build correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerTextField<TestForm>(field: TestFormField.stringField),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('should fail assertion if the type of the form is not passed',
        (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerTextField(field: TestFormField.stringField),
        ),
      );
      expect(tester.takeException(), isInstanceOf<AssertionError>());
    });

    testWidgets(
      'should fail assertion if field is a nullable number but keyboard type is not number',
      (tester) async {
        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerTextField<TestForm>(
              field: TestFormField.nullableIntField,
            ),
          ),
        );
        expect(tester.takeException(), isInstanceOf<AssertionError>());
      },
    );

    testWidgets(
      'should fail assertion if field is a non-nullable number and keyboard type is number',
      (tester) async {
        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerTextField<TestForm>(
              field: TestFormField.intField,
              keyboardType: TextInputType.number,
            ),
          ),
        );
        expect(tester.takeException(), isInstanceOf<AssertionError>());
      },
    );

    testWidgets(
      'should pass assertion if field is a nullable int, double or num and keyboard type is number',
      (tester) async {
        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerTextField<TestForm>(
              field: TestFormField.nullableIntField,
              keyboardType: TextInputType.number,
            ),
          ),
        );
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerTextField<TestForm>(
              field: TestFormField.nullableDoubleField,
              keyboardType: TextInputType.number,
            ),
          ),
        );
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerTextField<TestForm>(
              field: TestFormField.nullableNumField,
              keyboardType: TextInputType.number,
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('should update field value when changed', (tester) async {
      final textField = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerTextField<TestForm>(
            key: textField,
            field: TestFormField.stringField,
          ),
        ),
      );

      final form =
          Former.of<TestForm>(textField.currentContext!, listen: false).form;

      expect(form.stringField, isEmpty);

      const newText = 'new text';
      await tester.enterText(find.byKey(textField), newText);
      expect(form.stringField, newText);
    });

    testWidgets('should update int field when changed', (tester) async {
      final textField = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerTextField<TestForm>(
            key: textField,
            field: TestFormField.nullableIntField,
            keyboardType: TextInputType.number,
          ),
        ),
      );

      final form =
          Former.of<TestForm>(textField.currentContext!, listen: false).form;

      expect(form.nullableIntField, 0);

      await tester.enterText(find.byKey(textField), '23');
      expect(form.nullableIntField, 23);
    });

    testWidgets('should update double field when changed', (tester) async {
      final textField = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerTextField<TestForm>(
            key: textField,
            field: TestFormField.nullableDoubleField,
            keyboardType: TextInputType.number,
          ),
        ),
      );

      final form =
          Former.of<TestForm>(textField.currentContext!, listen: false).form;

      expect(form.nullableDoubleField, 0);

      await tester.enterText(find.byKey(textField), '23.1');
      expect(form.nullableDoubleField, 23.1);
    });

    testWidgets(
      'should set number field to null if invalid number is entered',
      (tester) async {
        final textField = GlobalKey();

        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerTextField<TestForm>(
              key: textField,
              field: TestFormField.nullableIntField,
              keyboardType: TextInputType.number,
            ),
          ),
        );

        final form =
            Former.of<TestForm>(textField.currentContext!, listen: false).form;

        expect(form.nullableIntField, 0);

        await tester.enterText(find.byKey(textField), '23a');
        expect(form.nullableIntField, isNull);
      },
    );

    testWidgets('should use given controller', (tester) async {
      final textField = GlobalKey();
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerTextField<TestForm>(
            key: textField,
            controller: controller,
            field: TestFormField.stringField,
          ),
        ),
      );

      final form =
          Former.of<TestForm>(textField.currentContext!, listen: false).form;

      expect(form.stringField, isEmpty);

      const newText = 'newText';
      await tester.enterText(find.byKey(textField), newText);

      expect(form.stringField, newText);
      expect(controller.text, newText);
    });

    testWidgets('should be disabled if form is disabled', (tester) async {
      final textFieldKey = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerTextField<TestForm>(
            key: textFieldKey,
            field: TestFormField.stringField,
          ),
        ),
      );

      final provider =
          Former.of<TestForm>(textFieldKey.currentContext!, listen: false);

      provider.isFormEnabled = false;
      await tester.pump();

      final TextField textField = tester.firstWidget(
        find.descendant(
          of: find.byKey(textFieldKey),
          matching: find.byType(TextField),
        ),
      );
      expect(textField.enabled, isFalse);
    });
  });
}
