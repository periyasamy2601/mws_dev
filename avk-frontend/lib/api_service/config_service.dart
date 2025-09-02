import 'package:avk/router/path_exporter.dart';

/// Configuration-related API services.
///
/// This service handles fetching project or user-related
/// configuration details from the backend.
///
/// Extends [APIBaseService] to reuse HTTP helpers,
/// and mixes in [Endpoints] to access defined API endpoints.
class ConfigService extends APIBaseService with Endpoints {
  /// Constructor to initialize the base URL and any other setup logic.
  ConfigService() {
    init(); // Ensure baseUrl is initialized early
  }

  /// Fetches the project/user configuration from the API.
  ///
  /// Returns a [MetaEntity] containing the configuration data.
  Future<MetaEntity> getConfigRepo() async =>
      httpGet('$baseUrl$configuration');
}
