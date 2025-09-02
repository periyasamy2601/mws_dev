/// Extension methods for [String] to provide
/// safe type conversions.
extension StringExtension on String {
  /// Converts `"1"` to `true`, `"0"` to `false`.
  ///
  /// Any other value will default to `false`.
  ///
  /// Example:
  /// ```dart
  /// "1".parseStringToBool(); // true
  /// "0".parseStringToBool(); // false
  /// "yes".parseStringToBool(); // false
  /// ```
  bool parseStringToBool() {
    if (this == '1') {
      return true;
    } else if (this == '0') {
      return false;
    } else {
      return false;
    }
  }

  /// Parses the string into an integer.
  ///
  /// If parsing fails, it returns `0` instead of throwing an error.
  ///
  /// Example:
  /// ```dart
  /// "42".toInt();   // 42
  /// "abc".toInt();  // 0
  /// ```
  int toInt() => int.tryParse(this) ?? 0;
}
