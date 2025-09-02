/// A centralized class for defining application route paths.
///
/// This ensures route names are consistent throughout the app
/// and reduces the risk of typos when navigating.
class RouterKeys {
  /// Creates a constant [RouterKeys] instance.
  ///
  /// Use this to access all route paths in a type-safe way.
  const RouterKeys();

  /// Route path for the login screen.
  String get login => '/login';

  /// Route path for the register screen.
  String get register => '/register';

  /// Route path for the register screen.
  String get forgetPassword => '/forgot_password';

  /// Route path for the verify-otp screen.
  String get verifyOtp => '/verify_otp';

  /// Route path for the reset password screen.
  String get resetPassword => '/reset_password';

  /// Route path for the Home screen.
  String get home => '/home';
  /// Route path for the projectSettings screen.
  String get projectSettings => '/project_settings';
  /// Route path for the userManagement screen.
  String get userManagement => '/user_management';
  /// Route path for the add user screen.
  String get addUser => '/add_user';
  /// Route path for the userManagement screen.
  String get profile => '/profile';
  /// Route path for the update-Profile screen.
  String get updateProfile => '/update_profile';

  /// splash screen
  String get splashScreen => '/splash';

  /// access denied
  String get accessDenied => '/access_denied';

}

/// A constant instance of [RouterKeys] to be used globally.
const RouterKeys routerKeys = RouterKeys();
