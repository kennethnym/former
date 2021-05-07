import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:former/former.dart';
import 'package:mockito/mockito.dart';

import '../test_form.dart';

/// A callable class that creates [TestForm] when called.
class _FormCreator {
  TestForm call() => TestForm();
}

/// A callable class that returns [testSchema] when called.
class _FormSchemaCreator extends Mock {
  TestFormSchema call() => testSchema;
}

void main() {
  late _FormCreator formCreator;
  late _FormSchemaCreator formSchemaCreator;

  setUp(() {
    formCreator = _FormCreator();
    formSchemaCreator = _FormSchemaCreator();
  });

  group('Former', () {
    testWidgets('should render child', (tester) async {
      final childKey = Key('child');

      await tester.pumpWidget(
        Former(
          form: formCreator,
          schema: formSchemaCreator,
          child: Container(key: childKey),
        ),
      );

      expect(find.byKey(childKey), findsOneWidget);
    });

    group('of', () {
      testWidgets('should obtain the nearest instance of FormerProvider',
          (tester) async {
        final childKey = GlobalKey();

        await tester.pumpWidget(
          Former<TestForm>(
            form: formCreator,
            schema: formSchemaCreator,
            child: Container(key: childKey),
          ),
        );

        final provider =
            Former.of<TestForm>(childKey.currentContext!, listen: false);

        expect(provider, isInstanceOf<FormerProvider<TestForm>>());
        expect(provider.form, isInstanceOf<TestForm>());
      });
    });
  });
}
