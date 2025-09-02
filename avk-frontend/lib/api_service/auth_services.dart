import 'package:avk/router/path_exporter.dart';

/// auth api services (Repo)
class AuthServices extends APIBaseService with Endpoints {
  /// Constructor to initialize the base URL and any other setup logic.
  AuthServices() {
    init(); // Ensure baseUrl is initialized early
  }
  String get _projectId => GetIt.I<LocalStorage>().getProjectId();

  /// login service
  Future<MetaEntity> loginRepo(Map<String, dynamic> body) async =>
      httpPost('$baseUrl$project/$_projectId$login', body);

  /// register or reset password service
  Future<MetaEntity> registerOrResetPasswordService(
    Map<String, dynamic> body,
  ) async => httpPost('$baseUrl$project/$_projectId$register', body);

  /// validate user
  Future<MetaEntity> validateUserService(Map<String, dynamic> body) async =>
      httpPost('$baseUrl$project/$_projectId$validate', body);

  /// send otp
  Future<MetaEntity> sendOtpService(Map<String, dynamic> body) async =>
      httpPost(
        '$baseUrl$otp',
        body..addAll(<String, dynamic>{'project_id': _projectId}),
      );

  /// verify otp service
  Future<MetaEntity> verifyOtpService(Map<String, dynamic> body) async =>
      httpPost(
        '$baseUrl$otpVerify',
        body..addAll(<String, dynamic>{'project_id': _projectId}),
      );
}
