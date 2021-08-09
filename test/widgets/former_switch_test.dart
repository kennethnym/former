import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:former/former.dart';

import '../test_form.dart';
import 'wrap_with_former.dart';

void main() {
  group('FormerSwitch', () {
    testWidgets('should build correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerSwitch<TestForm>(field: TestFormField.boolField),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('should fail assertion if the type of the form is not passed',
        (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerSwitch(field: TestFormField.boolField),
        ),
      );
      expect(tester.takeException(), isInstanceOf<AssertionError>());
    });

    testWidgets(
      'should fail assertion when incompatible field is used',
      (tester) async {
        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerSwitch<TestForm>(field: TestFormField.stringField),
          ),
        );
        expect(tester.takeException(), isInstanceOf<AssertionError>());
      },
    );

    testWidgets('should update field when changed', (tester) async {
      final key = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerSwitch<TestForm>(
            key: key,
            field: TestFormField.boolField,
          ),
        ),
      );

      final form = Former.of<TestForm>(key.currentContext!, listen: false).form;
      expect(form.boolField, isFalse);

      await tester.tap(find.byKey(key));
      expect(form.boolField, isTrue);
    });

    testWidgets('should be disabled when form is disabled', (tester) async {
      final key = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerSwitch<TestForm>(
            key: key,
            field: TestFormField.boolField,
          ),
        ),
      );

      final provider = Former.of<TestForm>(key.currentContext!, listen: false);
      expect(provider.form.boolField, isFalse);

      provider.isFormEnabled = false;
      await tester.pump();

      await tester.tap(find.byKey(key));
      expect(provider.form.boolField, isFalse);
    });
  });
}
