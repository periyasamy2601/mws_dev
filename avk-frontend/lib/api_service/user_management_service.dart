import 'package:avk/router/path_exporter.dart';

/// Service class for handling project settings and roles-related API operations.
///
/// This class extends [APIBaseService] and mixes in [Endpoints] to access the necessary
/// HTTP utility methods and endpoint paths. It encapsulates API calls for managing
/// project settings and roles within a project.
class UserManagementService extends APIBaseService with Endpoints {
  /// Constructor to initialize the base URL and any other setup logic.
  UserManagementService() {
    init();
  }

  String get _projectId => GetIt.I<LocalStorage>().getProjectId();


  /// Sends a GET request to fetch the project settings.
  ///
  /// Returns a [MetaEntity] containing the response data.
  Future<MetaEntity> getUserZonesRepo(String userId) async =>
      httpGet('$baseUrl$project/$_projectId$user/$userId$getZones');

  /// Sends a GET request to fetch the project settings.
  ///
  /// Returns a [MetaEntity] containing the response data.
  Future<MetaEntity> getUser(String userId) async =>
      httpGet('$baseUrl$project/$_projectId$user/$userId');

  /// Sends a GET request to fetch the project settings.
  ///
  /// Returns a [MetaEntity] containing the response data.
  Future<MetaEntity> createUserRepo(Map<String, dynamic> body) async =>
      httpPost('$baseUrl$project/$_projectId$user', body);

 /// Sends a GET request to fetch the project settings.
  ///
  /// Returns a [MetaEntity] containing the response data.
  Future<MetaEntity> editUserRepo(String userID,Map<String, dynamic> body) async =>
      httpPut('$baseUrl$project/$_projectId$user/$userID', body);

  /// get users services
  Future<MetaEntity> getUsers(
    String limit,
    String skip, {
    String? query,
  }) async => httpGet(
    '$baseUrl$project/$_projectId$users',
    queryParams: <String, String>{
      'skip': skip,
      'limit': limit,
      if (query != null) 'filter': query,
    },
  );

  /// reset user password
  Future<MetaEntity> resetUserPasswordService(String userID) async => httpPost(
    '$baseUrl$project/$_projectId$user/$userID$password$reset',
    <String, dynamic>{},
  );
  /// delete user for the project
  Future<MetaEntity> deleteUserService(String userID) async => httpDelete(
    '$baseUrl$project/$_projectId$user/$userID$deleteEndpoint'
  );
}
