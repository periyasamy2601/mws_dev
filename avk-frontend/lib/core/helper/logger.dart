import 'package:avk/router/path_exporter.dart';

/// A common instance

Logger logger = Logger();
/// A utility class for logging debug and error messages.
/// This class leverages Dart's [log] function and ensures messages are only
/// logged in debug mode for non-production environments.
class Logger {
  /// Logs a debug message with an optional additional [message].
  ///
  /// The log is only displayed in debug mode (when [kDebugMode] is true).
  ///
  /// - [title]: A required title or tag for the log message.
  /// - [message]: An optional additional message or data to log.
  ///
  /// Example:
  /// ```dart
  /// Logger.debug("API Response", responseData);
  /// ```
   void debugLog(String title, [Object? message]) {
    if (kDebugMode) {
      final String logMessage = message != null ? '$title -> $message' : title;
      log(logMessage, name: 'DEBUG');
    }
  }

  /// Logs an error message or object.
  ///
  /// This method logs errors in all modes (debug, release, and profile),
  /// making it useful for tracking issues in production environments.
  ///
  /// - [error]: The error object or message to log.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   // Some code that may throw an exception
  /// } catch (e) {
  ///   Logger.error(e);
  /// }
  /// ```
   void errorLog(Object error) {
    log(
      error.toString(),
      name: 'ERROR',
    );
  }
}
