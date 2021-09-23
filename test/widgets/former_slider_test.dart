import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:former/former.dart';

import '../test_form.dart';
import 'wrap_with_former.dart';

void main() {
  group('FormerSlider', () {
    testWidgets('should build correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerSlider<TestForm>(field: TestFormField.intField),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('should fail assertion if the type of the form is not passed',
        (tester) async {
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerSlider(field: TestFormField.intField),
        ),
      );
      expect(tester.takeException(), isInstanceOf<AssertionError>());
    });

    testWidgets(
      'should fail assertion if incompatible field is used',
      (tester) async {
        await tester.pumpWidget(
          wrapWithFormer(
            control: FormerSlider<TestForm>(field: TestFormField.stringField),
          ),
        );
        expect(tester.takeException(), isInstanceOf<AssertionError>());
      },
    );

    testWidgets('should update value when dragged', (tester) async {
      final slider = GlobalKey();
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerSlider<TestForm>(
            key: slider,
            field: TestFormField.intField,
            min: 0,
            max: 10,
          ),
        ),
      );

      final form =
          Former.of<TestForm>(slider.currentContext!, listen: false).form;

      expect(form.intField, 0);

      await tester.drag(find.byKey(slider), Offset(1000, 0));
      expect(form.intField, 10);
    });

    testWidgets('should be disabled when form is disabled', (tester) async {
      final slider = GlobalKey();
      await tester.pumpWidget(
        wrapWithFormer(
          control: FormerSlider<TestForm>(
            key: slider,
            field: TestFormField.intField,
            min: 0,
            max: 10,
          ),
        ),
      );

      final provider =
          Former.of<TestForm>(slider.currentContext!, listen: false);

      expect(provider.form.intField, 0);

      provider.isFormEnabled = false;
      await tester.pump();

      await tester.drag(find.byKey(slider), Offset(1000, 0));
      expect(provider.form.intField, 0);
    });
  });
}
