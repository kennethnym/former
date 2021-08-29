import 'package:flutter_test/flutter_test.dart';
import 'package:former/src/utils/assert_has_generic.dart';

import '../test_form.dart';

void main() {
  group('assertHasGeneric', () {
    test('should fail assertion if no generic type is passed to function call',
        () {
      expect(
        () => assertHasGeneric(forWidget: 'TestWidget'),
        throwsA(TypeMatcher<AssertionError>()),
      );
    });

    test(
        'should not fail assertion if a generic type that extends FormerForm is passed to function call',
        () {
      expect(
        () => assertHasGeneric<TestForm>(forWidget: 'TestWidget'),
        returnsNormally,
      );
    });
  });
}
