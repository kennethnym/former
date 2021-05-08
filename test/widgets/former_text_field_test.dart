import 'package:flutter/cupertino.dart';
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

    testWidgets(
      'should fail assertion if field is a number but keyboard type is not number',
      (tester) async {
        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerTextField<TestForm>(
              field: TestFormField.intField,
            ),
          ),
        );
        expect(tester.takeException(), isInstanceOf<AssertionError>());
      },
    );

    testWidgets(
      'should pass assertion if field is a number and keyboard type is number',
      (tester) async {
        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerTextField<TestForm>(
              field: TestFormField.intField,
              keyboardType: TextInputType.number,
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      },
    );
  });
}
