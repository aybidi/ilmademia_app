// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const passwordString = 'T0pS3cr3t123';
  group('ConfirmedPassword', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final password = ConfirmedPassword.pure(password: passwordString);
        expect(password.value, '');
        expect(password.pure, true);
      });

      test('dirty creates correct instance', () {
        final password = ConfirmedPassword.dirty(
          password: passwordString,
        );
        expect(password.value, '');
        expect(password.pure, false);
      });
    });
    group('validator', () {
      test('returns invalid error when password is empty', () {
        expect(
          ConfirmedPassword.dirty(password: passwordString).error,
          ConfirmedPasswordValidationError.invalid,
        );
      });

      test('is valid when the value matches the password', () {
        expect(
          ConfirmedPassword.dirty(
            password: passwordString,
            value: passwordString,
          ).error,
          isNull,
        );
      });
    });
  });
}
