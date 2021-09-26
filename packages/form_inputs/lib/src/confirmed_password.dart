import 'package:formz/formz.dart';

/// ConfirmedPassword Form Input Validation Error
enum ConfirmedPasswordValidationError {
  /// ConfirmedPassword is invalid (generic validation error)
  invalid,
}

/// {@template confirmed_password}
/// Reusable confirmed password form input.
/// {@endtemplate}
class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  /// {@macro confirmed_password}
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  /// {@macro confirmed_password}
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// confirmed password
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String? value) {
    return password == value ? null : ConfirmedPasswordValidationError.invalid;
  }
}
