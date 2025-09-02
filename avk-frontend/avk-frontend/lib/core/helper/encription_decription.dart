import 'package:avk/router/path_exporter.dart';

/// Simple text obfuscator with lightweight metadata embedding.
///
/// This is **not** cryptographically secure — use only for basic obfuscation.
class EncryptionDecryption {
  static const int _shift = 3;
  static const String _version = '1.0.0';
  static const String _delimiter = '|';

  /// Encodes [text] by appending a UTC timestamp and version, then
  /// shifting each character code by +[_shift].
  ///
  /// Example output (before char shift):
  /// `Hello|2025-05-20T12:00:00|1.0.0`
  Future<String> encode(String text) async {
    final String timestamp = DateFormat('yyyy-MM-ddTHH:mm:ss', 'en')
        .format(DateTime.now().toUtc());

    final String combinedText = '$text$_delimiter$timestamp$_delimiter$_version';
    return _shiftString(combinedText, _shift);
  }

  /// Decodes [encodedText] by reversing the char shift (-[_shift]) and
  /// extracting the original text (before metadata).
  ///
  /// Returns the plain text without timestamp/version.
  ///
  /// Throws [FormatException] if metadata format is invalid.
  String decode(String encodedText) {
    final String plainText = _shiftString(encodedText, -_shift);
    final List<String> parts = plainText.split(_delimiter);

    if (parts.length < 3) {
      throw const FormatException('Invalid encoded text format.');
    }

    logger.debugLog('Decoded text', plainText);
    return parts[0];
  }

  /// Shifts every character in [input] by [shiftValue].
  String _shiftString(String input, int shiftValue) =>
      String.fromCharCodes(input.codeUnits.map((int c) => c + shiftValue));
}
