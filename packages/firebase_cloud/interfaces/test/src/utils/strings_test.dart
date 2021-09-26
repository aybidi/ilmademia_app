import 'package:firebase_cloud_interfaces/firebase_cloud_interfaces.dart';
import 'package:test/test.dart';

void main() {
  group('Strings', () {
    group('capitalize', () {
      test('return null if param value is null', () {
        expect(Strings.capitalize(null), isNull);
      });
      test('return ' ' when param value is empty', () {
        expect(Strings.capitalize(''), equals(''));
      });
      test('return Hello when param value is hello', () {
        expect(Strings.capitalize('hello'), equals('Hello'));
      });
    });

    group('isNullOrBlank', () {
      test('return true when param value is null', () {
        expect(Strings.isNullOrBlank(null), isTrue);
      });
      test('return true when param value is empty', () {
        expect(Strings.isNullOrBlank('  '), isTrue);
      });
    });

    group('isNullOrEmpty', () {
      test('return true when param value is null', () {
        expect(Strings.isNullOrBlank(null), isTrue);
      });
      test('return true when param value is empty', () {
        expect(Strings.isNullOrBlank(''), isTrue);
      });
    });
  });
}
