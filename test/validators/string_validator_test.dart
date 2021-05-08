import 'package:flutter_test/flutter_test.dart';
import 'package:former/validators.dart';

void main() {
  group('StringMust', () {
    late StringMust stringMust;

    setUp(() {
      stringMust = StringMust();
    });

    test('should verify that the given value exists', () {
      const msg = 'is null';

      stringMust.exist(msg);

      expect(stringMust.validate(null), isFalse);
      expect(stringMust.error, msg);

      expect(stringMust.validate(''), isTrue);
      expect(stringMust.error, isEmpty);
    });

    test('should verify that the given value matches the given regex', () {
      const msg = 'does not match';

      stringMust.match(RegExp('^a.+'), msg);

      expect(stringMust.validate('bc'), isFalse);
      expect(stringMust.error, equals(msg));

      expect(stringMust.validate('ab'), isTrue);
      expect(stringMust.error, isEmpty);
    });

    test('should verify that the given value is not empty.', () {
      const msg = 'is empty';

      stringMust.notBeEmpty(msg);

      expect(stringMust.validate(''), isFalse);
      expect(stringMust.error, equals(msg));

      expect(stringMust.validate(' not empty '), isTrue);
      expect(stringMust.error, isEmpty);
    });

    test('should verify that the given value is a valid email', () {
      const msg = 'invalid email';

      stringMust.beAnEmail(msg);

      expect(stringMust.validate('email.com'), isFalse);
      expect(stringMust.error, equals(msg));

      expect(stringMust.validate('test@email.com'), isTrue);
      expect(stringMust.error, isEmpty);
    });

    test('should verify that the given value has at least 10 characters', () {
      const msg = 'too short';

      stringMust.hasMinLength(10, msg);

      expect(stringMust.validate('123'), isFalse);
      expect(stringMust.error, equals(msg));

      expect(stringMust.validate('AVeryLongString123'), isTrue);
      expect(stringMust.error, isEmpty);
    });

    test('should verify that the given value has at most 10 characters', () {
      const msg = 'too short';

      stringMust.hasMaxLength(10, msg);

      expect(stringMust.validate('AVeryLongString123'), isFalse);
      expect(stringMust.error, equals(msg));

      expect(stringMust.validate('123'), isTrue);
      expect(stringMust.error, isEmpty);
    });

    group('requirements chaining', () {
      test(
          'should verify that the given value matches regex and not exceed 10 characters',
          () {
        const regexNotMatchedMsg = 'regex not matched';
        const tooLongMsg = 'too long';

        stringMust
          ..match(RegExp('^a.+'), regexNotMatchedMsg)
          ..hasMaxLength(10, tooLongMsg);

        expect(stringMust.validate('bc'), isFalse);
        expect(stringMust.error, equals(regexNotMatchedMsg));
        expect(stringMust.validate('abcdefghijklmnopq'), isFalse);
        expect(stringMust.error, equals(tooLongMsg));

        expect(stringMust.validate('abc'), isTrue);
        expect(stringMust.error, isEmpty);
      });
    });
  });
}
