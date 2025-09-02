/// Extension methods for [bool].
extension BoolExtension on bool {
  /// Converts `true` → `'1'` and `false` → `'0'`.
  String parseBoolToString() => this ? '1' : '0';
}
