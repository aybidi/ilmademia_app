// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  group('CheckBoxInput', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final checkBox = CheckBoxInput.pure();
        expect(checkBox.value, false);
        expect(checkBox.pure, true);
      });

      test('dirty creates correct instance without value', () {
        final checkBox = CheckBoxInput.dirty();
        expect(checkBox.value, false);
        expect(checkBox.pure, false);
      });

      test('dirty creates correct instance with value', () {
        final checkBox = CheckBoxInput.dirty();
        expect(checkBox.value, false);
        expect(checkBox.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when checkbox is not checked', () {
        expect(
          CheckBoxInput.dirty().error,
          CheckBoxInputError.empty,
        );
      });

      test('is valid when the checkbox is checked', () {
        expect(
          CheckBoxInput.dirty(true).error,
          isNull,
        );
      });
    });
  });
}
