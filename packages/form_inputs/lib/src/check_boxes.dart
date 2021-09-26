import 'package:formz/formz.dart';

/// CheckBox Input Validation Error
enum CheckBoxInputError {
  /// CheckBox Input is empty
  empty,
}

/// {@template checkbox}
/// Reusable checkbox form input.
/// {@endtemplate}
class CheckBoxInput extends FormzInput<bool, CheckBoxInputError> {
  /// {@macro checkbox}
  const CheckBoxInput.pure() : super.pure(false);

  /// {@macro checkbox}
  const CheckBoxInput.dirty([bool value = false]) : super.dirty(value);

  @override
  CheckBoxInputError? validator(bool value) {
    return value == true ? null : CheckBoxInputError.empty;
  }
}
