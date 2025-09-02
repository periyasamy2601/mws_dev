import 'package:avk/router/path_exporter.dart';

/// Service class for handling project settings and roles-related API operations.
///
/// This class extends [APIBaseService] and mixes in [Endpoints] to access the necessary
/// HTTP utility methods and endpoint paths. It encapsulates API calls for managing
/// project settings and roles within a project.
class ProjectService extends APIBaseService with Endpoints {
  /// Constructor to initialize the base URL and any other setup logic.
  ProjectService() {
    init(); // Ensure baseUrl is initialized early
  }

  String get _projectId => GetIt.I<LocalStorage>().getProjectId();


  /// Sends a GET request to fetch the project settings.
  ///
  /// Returns a [MetaEntity] containing the response data.
  Future<MetaEntity> getProjectSettingsRepo() async =>
      httpGet('$baseUrl$project');

  /// Sends a GET request to fetch the project settings.
  ///
  /// Returns a [MetaEntity] containing the response data.
  Future<MetaEntity> getProjectsSettingsRepo() async =>
      httpGet('$baseUrl$projects');

  /// Sends a POST request to create or update project settings.
  ///
  /// [data] is the JSON-serializable body of the request.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> postProjectSettingsRepo(Map<String, dynamic> data) async =>
      httpPost('$baseUrl$project', data);

  /// Sends a PUT request to update existing project settings.
  ///
  /// [data] is the JSON-serializable body of the request.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> putProjectSettingsRepo(Map<String, dynamic> data) async =>
      httpPut('$baseUrl$project/$_projectId', data);

  /// Sends a PUT request to update an existing role in the project.
  ///
  /// [data] contains role update information in JSON format.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> putRoleRepo(Map<String, dynamic> data) async =>
      httpPut('$baseUrl$role', data);

  /// Sends a POST request to add a new role to the project.
  ///
  /// [data] contains the new role information in JSON format.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> postRoleRepo(Map<String, dynamic> data) async =>
      httpPost('$baseUrl$role', data);

  /// Sends a DELETE request to remove a role from the project.
  ///
  /// [projectID] is the ID of the project whose role is to be deleted.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> deleteRoleRepo(String projectID) async =>
      httpDelete('$baseUrl$role/$projectID');

  /// Sends a GET request to retrieve roles associated with a project.
  ///
  /// [projectID] is the ID of the project.
  /// Returns a [MetaEntity] containing a list of roles.
  Future<MetaEntity> getRoleRepo() async =>
      httpGet('$baseUrl$project/$_projectId$getRole');
  /// Sends a GET request to retrieve roles associated with a project.
  ///
  /// [projectID] is the ID of the project.
  /// Returns a [MetaEntity] containing a list of roles.
  Future<MetaEntity> getZonesRepo() async =>
      httpGet('$baseUrl$project/$_projectId$getZones');

  /// Sends a POST request to add a new role to the project.
  ///
  /// [data] contains the new role information in JSON format.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> addZoneRepo(Map<String, dynamic> data) async =>
      httpPost('$baseUrl$project/$_projectId$zone', data);
  /// Sends a POST request to add a new role to the project.
  ///
  /// [data] contains the new role information in JSON format.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> addSiteRepo(Map<String, dynamic> data) async =>
      httpPost('$baseUrl$project/$_projectId$site', data);

  /// Sends a POST request to add a new role to the project.
  ///
  /// [data] contains the new role information in JSON format.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> editZoneRepo(Map<String, dynamic> data,String zoneID) async =>
      httpPut('$baseUrl$project/$_projectId$zone/$zoneID', data);
  /// Sends a POST request to add a new role to the project.
  ///
  /// [data] contains the new role information in JSON format.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> editSiteRepo(Map<String, dynamic> data,String siteID) async =>
      httpPut('$baseUrl$project/$_projectId$site/$siteID', data);

  /// Sends a POST request to add a new role to the project.
  ///
  /// [data] contains the new role information in JSON format.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> deleteZoneRepo(String zoneID) async =>
      httpDelete('$baseUrl$project/$_projectId$zone/$zoneID');
  /// Sends a POST request to add a new role to the project.
  ///
  /// [data] contains the new role information in JSON format.
  /// Returns a [MetaEntity] containing the response.
  Future<MetaEntity> deleteSiteRepo(String siteID) async =>
      httpDelete('$baseUrl$project/$_projectId$site/$siteID');

}
