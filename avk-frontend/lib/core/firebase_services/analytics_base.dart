

import 'package:avk/router/path_exporter.dart';

/// A singleton service for handling Google Analytics in Flutter.
///
/// This service helps track user interactions, log events, and set user properties.
class AnalyticsBaseService {
  // Private constructor for singleton
  AnalyticsBaseService._privateConstructor();

  /// The single instance of [AnalyticsBaseService].
  static final AnalyticsBaseService _instance =
      AnalyticsBaseService._privateConstructor();

  /// Provides access to the singleton instance of [AnalyticsBaseService].
  static AnalyticsBaseService get instance => _instance;

  /// Firebase Analytics instance
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Firebase Analytics Observer instance
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  /// Initializes Google Analytics (Optional)
  ///
  /// Can be used to enable or disable analytics collection.
  Future<void> init() async {
    /// ---- For Requesting `AppTrackingTransparency` access for "App Store Connect" issue ----\
    await _analytics.setAnalyticsCollectionEnabled(true);
  }

  /// Sets the logged-in user's mobile number as a user property.
  ///
  /// This allows tracking user-specific data in analytics reports.
  ///
  /// -mobileNumber: The user's mobile number.
  Future<void> setUserPhoneNumber() async {
    await _analytics.setUserId(id: 'user_id -> nothing');
  }

  /// Sets user properties like role, country, or custom attributes.
  ///
  /// - name: The user property name.
  /// - value: The value associated with the property.
  Future<void> setUserSerialNumber(String serialNumber) async {
    await setUserPhoneNumber();

    await _analytics.setUserProperty(
        name: 'serial_number', value: serialNumber);
  }

  /// Tracks screen views in Google Analytics.
  ///
  /// - [screenName]: The name of the screen being viewed.
  Future<void> setCurrentScreen(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  /// Logs a custom event to Firebase Analytics.
  ///
  /// - [eventName]: The name of the event to log.
  /// - [parameters]: A map of event parameters (optional).
  Future<void> logEvent(String eventName,
      {Map<String, Object>? parameters}) async {
    await _analytics.logEvent(name: eventName, parameters: parameters);
  }
}
