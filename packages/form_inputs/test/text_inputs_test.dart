// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:form_inputs/src/text_input.dart';
import 'package:test/test.dart';

void main() {
  const textString = 'hello world';
  group('TextInput', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final text = TextInput.pure();
        expect(text.value, '');
        expect(text.pure, true);
      });

      test('dirty creates correct instance without value', () {
        final text = TextInput.dirty();
        expect(text.value, '');
        expect(text.pure, false);
      });

      test('dirty creates correct instance with value', () {
        final text = TextInput.dirty(textString);
        expect(text.value, textString);
        expect(text.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when text is empty', () {
        expect(
          TextInput.dirty().error,
          TextInputError.empty,
        );
      });

      test('is valid when the text is not empty', () {
        expect(
          TextInput.dirty(textString).error,
          isNull,
        );
      });
    });
  });
}
