// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  final today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  final twoDaysAfter = DateTime.now().add(Duration(days: 2));
  group('DateTimeInput', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final dateTime = DateTimeInput.pure();
        expect(dateTime.value, today);
        expect(dateTime.pure, true);
      });

      test('dirty creates correct instance', () {
        final dateTime = DateTimeInput.dirty(today);
        expect(dateTime.value, today);
        expect(dateTime.pure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when checkbox is not checked', () {
        expect(
          DateTimeInput.dirty(twoDaysAfter).error,
          DateTimeValidationError.invalid,
        );
      });

      test('is valid when the input is at least 13 years old', () {
        expect(
          DateTimeInput.dirty(DateTime(
            DateTime.now().year - 13,
            DateTime.now().month,
            DateTime.now().day,
          )).error,
          isNull,
        );
      });
    });
  });
}
