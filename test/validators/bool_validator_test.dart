import 'package:flutter_test/flutter_test.dart';
import 'package:former/src/validators/bool_validator.dart';

void main() {
  group('BoolMust', () {
    late BoolMust boolMust;

    setUp(() {
      boolMust = BoolMust();
    });

    test('should verify that the given value exists', () {
      const msg = 'not exist';

      boolMust.exist(msg);

      expect(boolMust.validate(null), isFalse);
      expect(boolMust.error, equals(msg));

      expect(boolMust.validate(false), isTrue);
      expect(boolMust.error, isEmpty);

      expect(boolMust.validate(true), isTrue);
      expect(boolMust.error, isEmpty);
    });

    test('should verify that the given value is false', () {
      const msg = 'not false';

      boolMust.beFalse(msg);

      expect(boolMust.validate(true), isFalse);
      expect(boolMust.error, equals(msg));

      expect(boolMust.validate(false), isTrue);
      expect(boolMust.error, isEmpty);
    });

    test('should verify that the given value is true', () {
      const msg = 'not true';

      boolMust.beTrue(msg);

      expect(boolMust.validate(false), isFalse);
      expect(boolMust.error, equals(msg));

      expect(boolMust.validate(true), isTrue);
      expect(boolMust.error, isEmpty);
    });
  });
}
