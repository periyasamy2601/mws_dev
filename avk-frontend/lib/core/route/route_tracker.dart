import 'package:avk/router/path_exporter.dart';
/// instance of route tracker
final RouteTracker routeTracker = RouteTracker();

/// route tracker class to identify the current route to build the path params
class RouteTracker extends RouteObserver<PageRoute<dynamic>> {

  /// return the current route name
  String? currentRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute) {
      currentRoute = route.settings.name;
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute is PageRoute) {
      currentRoute = previousRoute.settings.name;
    }
    super.didPop(route, previousRoute);
  }
}
