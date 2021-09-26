import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

/// DateTimeInput validation error
enum DateTimeValidationError {
  /// DateTimeInput is invalid
  invalid,
}

/// {@template dateTimeInput}
/// Reusable dateTimeInput form input.
/// {@endtemplate}
class DateTimeInput extends FormzInput<DateTime, DateTimeValidationError> {
  /// {@macro dateTimeInput}
  DateTimeInput.pure()
      : super.pure(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        );

  /// {@macro dateTimeInput}
  DateTimeInput.dirty(DateTime dateTime) : super.dirty(dateTime);

  @override
  DateTimeValidationError? validator(DateTime value) {
    const datePattern = 'yyyy-MM-dd';
    final today = DateTime.now();
    final birthDate = DateFormat(datePattern).parse(value.toString());
    final adultDate = DateTime(
      birthDate.year + 13,
      birthDate.month,
      birthDate.day,
    );
    return adultDate.isBefore(today) == true
        ? null
        : DateTimeValidationError.invalid;
  }
}
