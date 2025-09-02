import 'package:avk/model/project_settings/role_entity.dart';
import 'package:avk/model/project_settings/zone_entity.dart';
import 'package:avk/router/path_exporter.dart';

/// Handles operations related to project settings and roles.
///
/// This controller extends [ProjectService] to utilize API methods
/// and includes logic for managing authentication state and validation.
class ProjectSettingsController extends ProjectService {
  /// Fetches project settings data.
  ///
  /// Returns a [ProjectSettingsEntity] on success, or `null` if the request fails.
  Future<ProjectSettingsEntity?> getProjectSettingsData() async {
    try {
      final MetaEntity response = await getProjectSettingsRepo();
      if (_isSuccessState(response.statusCode)) {
        return ProjectSettingsEntity.fromJson(response.data);
      }
    } on Object catch (e) {
      // Log error or handle exception
      logger.debugLog('Error in getProjectSettingsData: $e');
    }
    return null;
  }

  /// Fetches project settings data.
  ///
  /// Returns a [ProjectSettingsEntity] on success, or `null` if the request fails.
  Future<List<ProjectSettingsEntity>?> getProjectsSettingsData() async {
    try {
      final MetaEntity response = await getProjectsSettingsRepo();
      if (_isSuccessState(response.statusCode)) {
        Iterable<dynamic> list = response.data;
        return list.whereType<Map<String,dynamic>>().map(ProjectSettingsEntity.fromJson).toList();
      }
    } on Object catch (e) {
      // Log error or handle exception
      logger.debugLog('Error in getProjectSettingsData: $e');
    }
    return null;
  }

  /// Sends a POST request to create project settings.
  ///
  /// Returns `true` if the request is successful, `false` otherwise.
  Future<bool> postProjectSettingsData(ProjectSettingsEntity body) async {
    try {
      final MetaEntity response = await postProjectSettingsRepo(body.toJson());
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in postProjectSettingsData: $e');
    }
    return false;
  }

  /// Sends a PUT request to update project settings.
  ///
  /// Returns `true` if the update is successful, `false` otherwise.
  Future<bool> putProjectSettingsData(ProjectSettingsEntity body) async {
    try {
      final MetaEntity response = await putProjectSettingsRepo(body.toJson());
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in putProjectSettingsData: $e');
    }
    return false;
  }

  /// Sends a PUT request to update a role within project settings.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> putRole(RoleEntity body) async {
    try {
      final MetaEntity response = await putRoleRepo(body.toJson());
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in putRole: $e');
    }
    return false;
  }

  /// Sends a POST request to create a new role within project settings.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> postRole(RoleEntity body) async {
    try {
      final MetaEntity response = await postRoleRepo(body.toJson());
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in postRole: $e');
    }
    return false;
  }

  /// Sends a DELETE request to remove a role from a project.
  ///
  /// [projectId] is the ID of the project whose role needs to be deleted.
  /// Returns `true` on successful deletion, `false` otherwise.
  Future<bool> deleteRole(String projectId) async {
    try {
      final MetaEntity response = await deleteRoleRepo(projectId);
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in deleteRole: $e');
    }
    return false;
  }

  /// Fetches all roles associated with a specific project.
  ///
  /// [projectId] is the ID of the project.
  /// Returns a list of [RoleEntity] on success, or `null` on failure.
  Future<List<RoleEntity>?> getRoles() async {
    try {
      final MetaEntity response = await getRoleRepo();
      if (_isSuccessState(response.statusCode)) {
        Iterable<dynamic> list = response.data;
        return list
            .whereType<Map<String, dynamic>>()
            .map(RoleEntity.fromJson)
            .toList();
      }
    } on Object catch (e) {
      logger.debugLog('Error in getRoles: $e');
    }
    return null;
  }

  /// Fetches all roles associated with a specific project.
  ///
  /// [projectId] is the ID of the project.
  /// Returns a list of [RoleEntity] on success, or `null` on failure.
  Future<List<ZoneEntity>?> getZonesList() async {
    try {
      final MetaEntity response = await getZonesRepo();
      if (_isSuccessState(response.statusCode)) {
        Iterable<dynamic> list = response.data;
        return list
            .whereType<Map<String, dynamic>>()
            .map(ZoneEntity.fromJson)
            .toList();
      }
    } on Object catch (e) {
      logger.debugLog('Error in getRoles: $e');
    }
    return null;
  }

  /// Sends a POST request to create a new role within project settings.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> addZone(ZoneEntity body) async {
    try {
      final MetaEntity response = await addZoneRepo(body.toJson());
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in postRole: $e');
    }
    return false;
  }
  /// Sends a POST request to create a new role within project settings.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> addSite(ZoneEntity body) async {
    try {
      final MetaEntity response = await addSiteRepo(body.toJson());
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in postRole: $e');
    }
    return false;
  }


  /// Sends a POST request to create a new role within project settings.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> editZone(ZoneEntity body,String zoneID) async {
    try {
      final MetaEntity response = await editZoneRepo(body.toJson(),zoneID);
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in postRole: $e');
    }
    return false;
  }
  /// Sends a POST request to create a new role within project settings.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> editSite(ZoneEntity body,String siteID) async {
    try {
      final MetaEntity response = await editSiteRepo(body.toJson(),siteID);
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in postRole: $e');
    }
    return false;
  }


  /// Sends a POST request to create a new role within project settings.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> deleteSite(String siteID) async {
    try {
      final MetaEntity response = await deleteSiteRepo(siteID);
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in postRole: $e');
    }
    return false;
  }


  /// Sends a POST request to create a new role within project settings.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> deleteZone(String zoneID) async {
    try {
      final MetaEntity response = await deleteZoneRepo(zoneID);
      return _isSuccessState(response.statusCode);
    } on Object catch (e) {
      logger.debugLog('Error in postRole: $e');
    }
    return false;
  }


  /// Determines whether the [statusCode] represents a successful HTTP response.
  ///
  /// Success codes include HTTP 200 (OK) and 201 (Created).
  bool _isSuccessState(int? statusCode) => <int>[200, 201].contains(statusCode);
}
