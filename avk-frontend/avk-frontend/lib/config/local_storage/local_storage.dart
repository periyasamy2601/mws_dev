import 'package:avk/router/path_exporter.dart';

/// local storage base provider class
class LocalStorage extends DbBaseService {
  /// _cachedDrawerShrink
  bool? _cachedDrawerShrink;
  /// get is login or not
  bool getIsLogIn() {
    return getBool(storageKeys.isLoginKey) ?? false;
  }

  /// get project ID
  String getProjectId() {
    return getString(storageKeys.projectID) ?? '';
  }

  /// set project ID
  Future<void> setProjectId(String projectID) async {
     await setString(storageKeys.projectID,projectID);
  }

  /// get project ID
  String getToken() {
    return getString(storageKeys.token) ?? '';
  }

  /// set project ID
  Future<void> setToken(String token) async {
     await setString(storageKeys.token,'Bearer $token');
  }

  /// get project ID
  bool getIsNotRegistered() {
    return getBool(storageKeys.isNotRegistered) ?? false;
  }

  /// set project ID
  Future<void> setIsNotRegistered({required bool registerValue}) async {
     await setBool(storageKeys.isNotRegistered, value: registerValue);
  }

  /// set drawer shrink value
  Future<void> setDrawerShrink({required bool value}) async {
    _cachedDrawerShrink = value;
    await setBool(storageKeys.drawerShrinkKey, value: value);
    return;
  }

  /// set drawer shrink value
  bool getDrawerShrink()  {
    _cachedDrawerShrink ??= getBool(storageKeys.drawerShrinkKey) ?? false;
    return _cachedDrawerShrink??false;
  }

  /// set drawer shrink value
  Future<void> setHoverShrink({required bool value}) async {
    await setBool(storageKeys.hoverShrinkKey, value: value);
    return;
  }

  /// set drawer shrink value
  bool getHoverShrink()  {
    return getBool(storageKeys.hoverShrinkKey) ?? false;
  }


  /// get is login or not
  Future<bool> setIsLogin() {
    return setBool(storageKeys.isLoginKey, value: true);
  }

  /// clear user data for logout
  Future<void> clearUserDataForLogout() async {
    await clear();
  }
}
