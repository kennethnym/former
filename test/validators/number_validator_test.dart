import 'package:flutter_test/flutter_test.dart';
import 'package:former/validators.dart';

void main() {
  group('NumberMust', () {
    late NumberMust numberMust;

    setUp(() {
      numberMust = NumberMust();
    });

    test('should verify that the given value exists', () {
      const msg = 'is null';

      numberMust.exist(msg);

      expect(numberMust.validate(null), isFalse);
      expect(numberMust.error, msg);

      expect(numberMust.validate(0), isTrue);
      expect(numberMust.error, isEmpty);
    });

    test('should verify that the given value is an integer', () {
      const msg = 'not integer';

      numberMust.beInteger(msg);

      expect(numberMust.validate(1.1), isFalse);
      expect(numberMust.error, equals(msg));

      numberMust.validate(1);
      expect(numberMust.error, isEmpty);
    });

    test(
      'should verify that the given value is not less than the specified value',
      () {
        const msg = 'too small';

        numberMust.beAtLeast(10, msg);

        expect(numberMust.validate(9.9), isFalse);
        expect(numberMust.error, equals(msg));
        expect(numberMust.validate(8), isFalse);
        expect(numberMust.error, equals(msg));

        expect(numberMust.validate(10), isTrue);
        expect(numberMust.error, isEmpty);
        expect(numberMust.validate(10.1), isTrue);
        expect(numberMust.error, isEmpty);
      },
    );

    test(
      'should verify that the given value is not more than the specified value',
      () {
        const msg = 'too large';

        numberMust.beAtMost(10, msg);

        expect(numberMust.validate(10.1), isFalse);
        expect(numberMust.error, equals(msg));
        expect(numberMust.validate(11), isFalse);
        expect(numberMust.error, equals(msg));

        expect(numberMust.validate(9.9), isTrue);
        expect(numberMust.error, isEmpty);
        expect(numberMust.validate(10), isTrue);
        expect(numberMust.error, isEmpty);
      },
    );

    test('should verify that the given value is positive', () {
      const msg = 'not positive';

      numberMust.bePositive(msg);

      expect(numberMust.validate(-1), isFalse);
      expect(numberMust.error, equals(msg));
      expect(numberMust.validate(-1.1), isFalse);
      expect(numberMust.error, equals(msg));

      expect(numberMust.validate(1), isTrue);
      expect(numberMust.error, isEmpty);
      expect(numberMust.validate(1.1), isTrue);
      expect(numberMust.error, isEmpty);
    });

    test('should verify that the given value is negative', () {
      const msg = 'not negative';

      numberMust.beNegative(msg);

      expect(numberMust.validate(1), isFalse);
      expect(numberMust.error, equals(msg));
      expect(numberMust.validate(1.1), isFalse);
      expect(numberMust.error, equals(msg));

      expect(numberMust.validate(-1), isTrue);
      expect(numberMust.error, isEmpty);
      expect(numberMust.validate(-1.1), isTrue);
      expect(numberMust.error, isEmpty);
    });

    test(
      'should verify that the given value is within the two specified values',
      () {
        const msg = 'not in range';

        numberMust.beWithin(1, 10, msg);

        expect(numberMust.validate(0), isFalse);
        expect(numberMust.error, equals(msg));
        expect(numberMust.validate(10.1), isFalse);
        expect(numberMust.error, equals(msg));

        expect(numberMust.validate(2), isTrue);
        expect(numberMust.error, isEmpty);
        expect(numberMust.validate(2.2), isTrue);
        expect(numberMust.error, isEmpty);
      },
    );
  });
}
