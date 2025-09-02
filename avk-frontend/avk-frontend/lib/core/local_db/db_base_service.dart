import 'package:avk/router/path_exporter.dart';

/// A base class to manage SharedPreferences in a centralized manner.
class DbBaseService {
  SharedPreferences? _preferences;

  /// Initializes SharedPreferences instance.
  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  /// Sets a string value in SharedPreferences.
  Future<bool> setString(String key, String value) async {
    _ensureInitialized();
    return _preferences!.setString(key, value);
  }

  /// Gets a string value from SharedPreferences.
  String? getString(String key) {
    _ensureInitialized();
    return _preferences!.getString(key);
  }

  /// Sets an integer value in SharedPreferences.
  Future<bool> setInt(String key, int value) async {
    _ensureInitialized();
    return _preferences!.setInt(key, value);
  }

  /// Gets an integer value from SharedPreferences.
  int? getInt(String key) {
    _ensureInitialized();
    return _preferences!.getInt(key);
  }

  /// Sets a boolean value in SharedPreferences.
  Future<bool> setBool(String key, {required bool value}) async {
    _ensureInitialized();
    return _preferences!.setBool(key, value);
  }

  /// Gets a boolean value from SharedPreferences.
  bool? getBool(String key) {
    _ensureInitialized();
    return _preferences!.getBool(key);
  }

  /// Removes a value from SharedPreferences.
  Future<bool> remove(String key) async {
    _ensureInitialized();
    return _preferences!.remove(key);
  }

  /// Clears all values from SharedPreferences.
  Future<bool> clear() async {
    _ensureInitialized();
    return _preferences!.clear();
  }

  /// Ensures SharedPreferences is initialized before accessing.
  void _ensureInitialized() {
    if (_preferences == null) {
      logger.debugLog('SharedPreferences is not initialized');
      throw Exception(
        'SharedPreferences is not initialized. Call init() first.',
      );
    }
  }
}
