import 'package:avk/router/path_exporter.dart';

/// A singleton service for handling Firebase Crashlytics integration.
///
/// This service initializes Firebase Crashlytics, captures errors, and logs
/// user-specific information such as mobile number and device ID.
class CrashlyticsBaseService {
  // Private constructor for singleton
  CrashlyticsBaseService._privateConstructor();

  /// The single instance of [CrashlyticsBaseService].
  static final CrashlyticsBaseService _instance =
      CrashlyticsBaseService._privateConstructor();

  /// Provides access to the singleton instance of [CrashlyticsBaseService].
  static CrashlyticsBaseService get instance => _instance;

  /// Initializes the Crashlytics service by setting up custom error handling.
  ///
  /// This method ensures that Flutter and platform-specific errors are reported
  /// to Firebase Crashlytics. In debug mode, errors are printed to the console.
  Future<void> init() async {
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      if (kDebugMode) {
        // Print error normally in debug mode
        FlutterError.dumpErrorToConsole(errorDetails);
      } else {
        try {
          // Report Flutter framework errors to Firebase Crashlytics.
          FlutterError.onError = (FlutterErrorDetails errorDetails) => FirebaseCrashlytics.instance
              .recordFlutterFatalError(errorDetails);

          // Capture uncaught platform errors.
          PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
            unawaited(FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
            return true;
          };

          // Set user phone number for tracking crashes.
          await setUserPhoneNumber();
        }on Object catch (e, stackTrace) {
          FlutterError.dumpErrorToConsole(errorDetails);
          if (e is HttpException) {
            await FirebaseCrashlytics.instance
                .log('HTTP error occurred: ${e.message}');
          } else {
            await FirebaseCrashlytics.instance.recordError(e, stackTrace);
          }
        }
      }
    };
  }

  /// Sets the logged-in user's mobile number in Firebase Crashlytics.
  ///
  /// This helps identify users in crash reports.
  Future<void> setUserPhoneNumber() async {
      await FirebaseCrashlytics.instance
          .setUserIdentifier('Nothing');
  }

  /// Associates a device ID with crash reports.
  ///
  /// This can be used to track crashes on specific devices.
  ///
  /// - [serialNumber]: The unique identifier of the device.
  Future<void> setDeviceID(String serialNumber) async {
    await FirebaseCrashlytics.instance.setCustomKey('serial_number', serialNumber);
  }
}
