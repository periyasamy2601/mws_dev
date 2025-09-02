import 'package:avk/core/helper/logger.dart';
import 'package:web/web.dart' as web;

/// read base url only for web
void readBaseUrl() {
  final web.Location location = web.window.location;

  final String origin = location.origin; // http://localhost:11447
  final String href = location.href;     // http://localhost:11447/#/user_management
  final String _ = location.pathname; // usually "/"
  final String hash = location.hash;     // "#/user_management"

  logger..debugLog('Origin: $origin')
  ..debugLog('Full URL: $href')
  ..debugLog('Hash route: $hash');
}
