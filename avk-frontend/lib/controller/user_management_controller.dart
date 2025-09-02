
import 'package:avk/router/path_exporter.dart';

/// Handles authentication-related operations.
///
/// This controller extends [AuthServices] to use its API methods
/// and adds logic specific to authentication state and validation.
class UserManagementController extends UserManagementService {
  ///get user zones to edit and delete the access
  Future<List<ZoneEntity>?> getZonesList(String userId) async {
    try {
      final MetaEntity response = await getUserZonesRepo(userId);
      if (_isSuccessState(response)) {
        Iterable<dynamic> list = response.data;
        return list
            .whereType<Map<String, dynamic>>()
            .map(ZoneEntity.fromJson)
            .toList();
      }
    } on Object catch (e) {
      logger.debugLog('Error in getZonesList: $e');
    }
    return null;
  }

  ///get user zones to edit and delete the access
  Future<UserEntity?> getUserData(String userId) async {
    try {
      final MetaEntity response = await getUser(userId);
      if (_isSuccessState(response)) {
        return UserEntity.fromJson(response.data);
      }
    } on Object catch (e) {
      logger.debugLog('Error in getUserData: $e');
    }
    return null;
  }

  /// create user controller
  Future<CommonEntity?> createUserController(Map<String, dynamic> body) async {
    try {
      final MetaEntity response = await createUserRepo(body);
      if (_isSuccessState(response)) {
        return CommonEntity.fromJson(response.data);
      }
    } on Object catch (e) {
      logger.debugLog('Error in getUserData: $e');
    }
    return null;
  }

  /// create user controller
  Future<bool> editUserController(String userID,Map<String, dynamic> body) async {
    try {
      final MetaEntity response = await editUserRepo(userID,body);
      if (_isSuccessState(response)) {
        return true;
      }
    } on Object catch (e) {
      logger.debugLog('Error in getUserData: $e');
    }
    return false;
  }

  ///get users
  Future<UserPaginationEntity?> getUsersController(
    String limit,
    String skip, {
    String? query,
  }) async {
    try {
      final MetaEntity response = await getUsers(limit, skip, query: query);
      if (_isSuccessState(response)) {
        return UserPaginationEntity.fromJson(response.data);
      }
    } on Object catch (e) {
      logger.debugLog('Error in getUserData: $e');
    }
    return null;
  }

  /// reset password Controller
  /// create user controller
  Future<CommonEntity?> resetUserController(String userId) async {
    try {
      final MetaEntity response = await resetUserPasswordService(userId);
      if (_isSuccessState(response)) {
        return CommonEntity.fromJson(response.data);
      }
    } on Object catch (e) {
      logger.debugLog('Error in getUserData: $e');
    }
    return null;
  }


  /// delete user form the project id
  Future<bool> deleteUserController(String userId) async {
    try {
      final MetaEntity response = await deleteUserService(userId);
      if (_isSuccessState(response)) {
        return response.error == null;
      }
    } on Object catch (e) {
      logger.debugLog('Error in getUserData: $e');
    }
    return false;
  }


  /// Checks if a given statusCode] represents a success response.
  ///
  /// Considers HTTP 200 (OK) and 201 (Created) as successful responses.
  bool _isSuccessState(MetaEntity response) =>
      <int>[200, 201].contains(response.statusCode);
}
