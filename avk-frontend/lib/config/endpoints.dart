import 'package:avk/router/path_exporter.dart';

/// end points
mixin Endpoints {

  /// otp verify endpoint
  final String login = '/login';
  /// get project  endpoint
  final String project = '/project';
  /// get projects  endpoint
  final String projects = '/projects';
  /// role  endpoint
  final String role = '/project/role';
  /// get projects  endpoint
  final String getRole = '/role';

  ///  zone  endpoint
  final String zone = '/zone';
  ///  user   endpoint
  final String user = '/user';
  ///  users   endpoint
  final String users = '/users';
  ///  site  endpoint
  final String site = '/site';
  /// get projects  endpoint
  final String getZones = '/zones';

  /// password
  final String password = '/password';
  /// reset
  final String reset = '/reset';

  /// register
  final String register = '/user/register';

  /// validate
  final String validate = '/user/validate';

  /// otp
  final String otp = '/otp';
  /// otp verify
  final String otpVerify = '/otp/verify';

  /// delete
  final String deleteEndpoint = '/delete';

  /// auth base url
  String authBaseUrl = '';
  /// base url
  String baseUrl = '';

  /// /configuration
  String configuration = '/configuration';

  /// init base urls
  void init()  {
    logger.debugLog('baseUrl',baseUrl);
    // You can also use a simple bool to check if already initialized
    if (authBaseUrl.isEmpty || baseUrl.isEmpty) {
      switch (F.appFlavor) {
        case Flavor.dev:
          baseUrl = 'http://192.168.2.116:7655';
        case Flavor.stage:
          authBaseUrl = 'https://stage-dconag-api-auth.mwsresearchcentre.com';
          baseUrl = 'http://192.168.2.116:7655';
        case Flavor.prod:
          authBaseUrl = 'https://api-auth.dconag.com';
          baseUrl = 'http://192.168.2.116:7655';
      }
    }
    logger.debugLog('baseUrl',baseUrl);
  }
}
