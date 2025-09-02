import 'package:avk/core/helper/encription_decription.dart';
import 'package:avk/router/path_exporter.dart';

/// A custom navigation utility for managing routes and navigation actions.
///
/// This class centralizes all navigation logic, helping avoid
/// scattering `Navigator` calls across the codebase.
///
/// Example usage:
/// ```dart
/// routerHelper.pushNamed(routerKeys.dashboard);
/// ```
class RouteHelper {
  /// Creates a new [RouteHelper] instance.
  ///
  /// This can be registered as a singleton via your DI container
  /// so navigation can be accessed globally.
  RouteHelper();

  /// Global navigator key for accessing navigation without a [BuildContext].
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Push a named route with optional parameters.
  Future<Object?>? pushNamed(
    String routeName, {
    BaseRouteEntity? params,
    bool isLinked = true,
  }) async {
    return _safeNavigate(() async {
      final String path = await _buildRoute(routeName, isLinked, params);
      return Navigator.pushNamed(navigatorKey.currentContext!, path);
    });
  }

  /// Replace the current route with a named route.
  Future<Object?>? pushReplacementNamed(
    String routeName, [
    BaseRouteEntity? params,
  ]) async {
    return _safeNavigate(() async {
      final String path = await _buildRoute(routeName, false, params);
      return Navigator.pushReplacementNamed(navigatorKey.currentContext!, path);
    });
  }

  /// Replace all routes with the given named route.
  Future<Object?>? pushReplacementAllNamed(
    String routeName, [
    BaseRouteEntity? params,
  ]) async {
    return _safeNavigate(() async {
      final String path = await _buildRoute(routeName, false, params);
      return Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        path,
        (_) => false,
      );
    });
  }

  /// Pop the current route.
  void back<T extends Object?>({T? result, bool returnTrue = true}) {
    _safeNavigate(() {
      Navigator.pop(navigatorKey.currentContext!, result ?? returnTrue);
    });
  }

  /// Pop the current route twice.
  void doublePop<T extends Object?>([T? result]) {
    _safeNavigate(() {
      Navigator.of(navigatorKey.currentContext!)
        ..pop(result)
        ..pop(result);
    });
  }

  /// Common Material navigation with animation.
  MaterialPageRoute<dynamic> commonNavigation(
    RouteSettings settings,
    Widget screen,
  ) => MaterialPageRoute<Object>(settings: settings, builder: (_) => screen);

  /// Navigation without animation.
  PageRouteBuilder<dynamic> commonNavigationWith0Animation(
    RouteSettings settings,
    Widget screen,
  ) => _noAnimationRoute(settings, screen);

  /// Dashboard-specific no-animation navigation.
  PageRouteBuilder<dynamic> dashboardCommonNavWith0Animation(
    RouteSettings settings,
    Widget screen,
    String routeKey, {
    bool showPop = false,
    String? title,
  }) => PageRouteBuilder<Object>(
    settings: settings,
    pageBuilder: (_, _, _) => Dashboard(routeName: routeKey, child: screen),
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );

  /// Extract base route name without parameters.
  // String getFilterRouteName(String route) => route.contains('?')
  //     ? "/${route.split('?')[0].split('/').last}"
  //     : "/${route.split('/').last}";

  String getFilterRouteName(String route) {
    final String name = "/${route.split('/').last}";
    if (name.contains('?')) {
      return name.split('?').first;
    }
    return name;
  }

  /// Extract parameters from query string into a [BaseRouteEntity].
  BaseRouteEntity getParams(String route) {
    final Map<String, String> params = <String, String>{};

    if (route.contains('?')) {
      final String rawEncoded = route.split('?')[1];
      final String decodedText = EncryptionDecryption().decode(
        Uri.decodeComponent(rawEncoded),
      );

      for (final String pair in decodedText.split('&')) {
        final List<String> keyValue = pair.split('=');
        if (keyValue.length == 2) {
          params[keyValue[0]] = keyValue[1];
        }
      }
    }

    logger.debugLog('params', params);
    return BaseRouteEntity.fromJson(params);
  }

  /// Builds route string with optional query parameters.
  Future<String> _buildRoute(
    String route, [
    bool isLinked = false,
    BaseRouteEntity? params,
  ]) async {
    String? currentRouteName = routeTracker.currentRoute;
    // if(currentRouteName?.contains('?')??false){
    //   currentRouteName = currentRouteName?.split('?').first;
    // }
    String localRoute = isLinked ? (currentRouteName ?? '') + route : route;

    if (params != null) {
      final String paramString = params
          .toJson()
          .entries
          .map((MapEntry<String, String> e) => '${e.key}=${e.value}')
          .join('&');
      logger.debugLog('paramString', paramString);
      final String encodedString = await EncryptionDecryption().encode(
        paramString,
      );
      final String urlSafeEncoded = Uri.encodeComponent(encodedString);
      localRoute = '$localRoute?$urlSafeEncoded'.replaceAll('"', '');
    }

    logger.debugLog('ROUTE', localRoute);
    return localRoute;
  }

  /// Creates a route with no animation.
  PageRouteBuilder<dynamic> _noAnimationRoute(
    RouteSettings settings,
    Widget screen,
  ) => PageRouteBuilder<Object>(
    settings: settings,
    pageBuilder: (_, _, _) => screen,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );

  /// Safely executes navigation only if a context exists.
  T? _safeNavigate<T>(T Function() action) {
    final BuildContext? context = navigatorKey.currentContext;
    if (context != null) {
      return action();
    }
    logger.errorLog('Navigation context is null. Navigation aborted.');
    return null;
  }
}
