import 'package:avk/router/path_exporter.dart';

/// Global constants used throughout the app.
///
/// Use [appConstants] to access values instead of creating new instances.
const AppConstants appConstants = AppConstants();

///
class AppConstants {

  /// Private constructor to enforce singleton usage through [appConstants].
  const AppConstants();
  /// Determines if the current build is running on the web platform.
  ///
  /// This can be used for environment-specific logic (e.g., enabling admin UI).
  bool get isAdmin => kIsWeb;

  /// Maximum allowed length for certain input fields (100 characters).
  int get fieldLimit100 => 100;

  /// Maximum allowed length for shorter input fields (32 characters).
  int get fieldLimit32 => 32;

  /// Maximum allowed length for shorter input fields (50 characters).
  int get fieldLimit50 => 50;

  /// min drawer widget
  double get minDrawerWidgetWidth => 100;
 /// max drawer widget
  double get maxDrawerWidgetWidth => 320;

}
