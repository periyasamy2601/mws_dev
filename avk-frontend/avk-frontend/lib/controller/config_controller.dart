import 'package:avk/router/path_exporter.dart';

/// Handles Config-related operations.
///
/// Extends [ConfigService] to use configuration API methods,
/// adding logic specific to authentication state and validation.
class ConfigController extends ConfigService {
  /// Logs in using project configuration.
  ///
  /// Fetches configuration data from the server and attempts
  /// to parse it into a [ConfigEntity]. Returns `null` if the
  /// request fails or parsing is unsuccessful.
  Future<ConfigEntity?> getConfigController() async {
    try {
      final MetaEntity response = await getConfigRepo();

      if (_isSuccessState(response) && response.data != null) {
        return ConfigEntity.fromJson(response.data as Map<String, dynamic>);
      } else {
        logger.debugLog('CONFIG FAILED', response.toJson());
      }
    } on Object catch (e) {
      logger.debugLog('CONFIG EXCEPTION', e);
    }
    return null;
  }

  /// Checks if the API [response] is considered successful.
  ///
  /// Currently considers only HTTP 200 (OK).
  bool _isSuccessState(MetaEntity response) =>
      response.statusCode == 200;
}
