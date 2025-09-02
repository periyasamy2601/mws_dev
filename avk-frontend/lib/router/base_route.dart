import 'package:avk/router/path_exporter.dart';
import 'package:avk/screen/error_view/access_denied_view.dart';

/// base router configuration
class BaseRouter {
  /// generate route func
  Route<dynamic> generateRoute(RouteSettings settings) {
    final RouteHelper routeHelper = GetIt.instance<RouteHelper>();

    /// split route name and queryParams
    String routeName = routeHelper.getFilterRouteName(settings.name ?? '');
    BaseRouteEntity queryParams = routeHelper.getParams(settings.name ?? '');

    logger.debugLog('routeName ${settings.name}', routeName);

    ///route cases
    if (routeName == routerKeys.login) {
      return routeHelper.commonNavigation(settings, const LoginView());
    } else if (routeName == routerKeys.register) {
      return routeHelper.commonNavigation(settings, const RegisterView());
    } else if (routeName == routerKeys.forgetPassword) {
      return routeHelper.commonNavigation(
        settings,
        ForgotPasswordView(baseRouteEntity: queryParams),
      );
    } else if (routeName == routerKeys.verifyOtp) {
      return routeHelper.commonNavigation(
        settings,
        VerifyOtpView(baseRouteEntity: queryParams),
      );
    } else if (routeName == routerKeys.resetPassword) {
      return routeHelper.commonNavigation(
        settings,
        ResetPasswordView(baseRouteEntity: queryParams),
      );
    } else if (routeName == routerKeys.home) {
      return routeHelper.dashboardCommonNavWith0Animation(
        settings,
        const HomeView(),
        routeName,
      );
    } else if (routeName == routerKeys.projectSettings) {
      return routeHelper.dashboardCommonNavWith0Animation(
        settings,
        const ProjectSettingsView(),
        routeName,
      );
    } else if (routeName == routerKeys.userManagement) {
      return routeHelper.dashboardCommonNavWith0Animation(
        settings,
        const UserManagementView(),
        routeName,
      );
    }  else if (routeName == routerKeys.addUser) {
      return routeHelper.dashboardCommonNavWith0Animation(
        settings,
         AddUserView(baseRouteEntity:queryParams ,),
        settings.name??routeName,
      );
    }  else if (routeName == routerKeys.profile) {
      return routeHelper.commonNavigation(
        settings,
        const ProfileView(),
      );
    }   else if (routeName == routerKeys.updateProfile) {
      return routeHelper.commonNavigation(
        settings,
        const UpdateProfileView(),
      );
    }    else if (routeName == routerKeys.splashScreen) {
      return routeHelper.commonNavigation(
        settings,
        const SplashView(),
      );
    }    else if (routeName == routerKeys.accessDenied) {
      return routeHelper.commonNavigation(
        settings,
        const AccessDeniedView(),
      );
    } else {
      return routeHelper.commonNavigationWith0Animation(settings, Container());
    }
  }


  /// set the initial route based on the below conditions
  String initialRoute(){
    final LocalStorage localStorge = GetIt.I<LocalStorage>();
    if(localStorge.getIsNotRegistered()){
      return routerKeys.register;
    }
    if(localStorge.getToken().isNotEmpty){
      return routerKeys.projectSettings;
    }
    return routerKeys.login;
  }
}
