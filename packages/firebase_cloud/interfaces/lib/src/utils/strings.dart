/// {@template strings}
/// Strings is a utility class for different [String]
/// {@endtemplate}
class Strings {
  /// Represent Empty string
  ///
  /// Value: ''
  static String empty = '';

  /// Represent Space string
  /// Value: ' '
  /// Note: there a single space
  static String space = ' ';

  /// String that represent the tab
  /// Value: '\t'
  static String tab = '\t';

  /// String that represent the carriage return
  /// Value: '\r'
  static String carriageReturn = '\r';

  /// String that represent the new line
  /// Value: '\n'
  static String newLine = '\n';

  /// Returns a copy of this string having its first letter uppercase,
  /// or the original string,
  /// if it's empty or already starts with an upper case letter.
  static String? capitalize(String? str) {
    if (isNullOrEmpty(str)) return str;
    return str!.substring(0, 1).toUpperCase() + str.substring(1);
  }

  /// Returns `true` if this nullable char sequence is either `null`
  /// or empty or consists solely of whitespace characters.
  static bool isNullOrBlank(String? str) {
    return str == null || str.trim().isEmpty;
  }

  /// Returns `true` if this nullable char sequence is either `null` or empty.
  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }
}
