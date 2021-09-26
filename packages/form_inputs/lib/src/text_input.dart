import 'package:formz/formz.dart';

/// Text Input Validation Error
enum TextInputError {
  /// Text Input is empty
  empty,
}

/// {@template text}
/// Reusable text form input.
/// {@endtemplate}
class TextInput extends FormzInput<String, TextInputError> {
  /// {@macro text}
  const TextInput.pure() : super.pure('');

  /// {@macro text}
  const TextInput.dirty([String value = '']) : super.dirty(value);

  @override
  TextInputError? validator(String value) {
    return value.isNotEmpty == true ? null : TextInputError.empty;
  }
}
