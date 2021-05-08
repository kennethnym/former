import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:former/former.dart';

import '../test_form.dart';
import 'wrap_with_former.dart';

void main() {
  group('FormerCheckbox', () {
    testWidgets('should build correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerCheckbox<TestForm>(field: TestFormField.boolField),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'should fail assertion if incompatible field is passed',
      (tester) async {
        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerCheckbox<TestForm>(field: TestFormField.stringField),
          ),
        );
        expect(tester.takeException(), isInstanceOf<AssertionError>());
      },
    );

    testWidgets('should update the given field on change', (tester) async {
      final control = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerCheckbox<TestForm>(
            key: control,
            field: TestFormField.boolField,
          ),
        ),
      );

      final provider =
          Former.of<TestForm>(control.currentContext!, listen: false);
      expect(provider.form.boolField, isFalse);

      await tester.tap(find.byKey(control));
      expect(provider.form.boolField, isTrue);
    });

    testWidgets('should be disabled when form is disabled', (tester) async {
      final control = GlobalKey();

      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerCheckbox<TestForm>(
            key: control,
            field: TestFormField.boolField,
          ),
        ),
      );

      final provider =
          Former.of<TestForm>(control.currentContext!, listen: false);
      expect(provider.form.boolField, isFalse);

      provider.isFormEnabled = false;
      await tester.pump();

      // boolField should still be false after being tapped since it is disabled

      await tester.tap(find.byKey(control));
      expect(provider.form.boolField, isFalse);
    });
  });
}
