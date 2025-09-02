import 'package:avk/router/path_exporter.dart';


/// A utility class to display customizable snack bars across the application.
/// This class provides methods to show snack bars with or without icons,
/// and to hide the currently displayed snack bar.
class MWSnackBar {
  /// Displays a snack bar with the given [title].
  ///
  /// If another snack bar is currently visible, it will be dismissed before
  /// showing the new one.
  ///
  /// [title]: The text content to display in the snack bar.
  void showSnackBar(String title,{double? width}) {
    _hideSnackBar();

    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      width:width?? 300, // Set a custom width
      content: Text(
        title,
      ),
    );

    _showSnackBar(snackBar);
  }

  /// Displays a snack bar with the given [title] and an [icon].
  ///
  /// If another snack bar is currently visible, it will be dismissed before
  /// showing the new one.
  ///
  /// [title]: The text content to display in the snack bar.
  /// [icon]: A widget to display as an icon in the snack bar.
  void showSnackBarWithIcon(String title, Widget icon) {
    _hideSnackBar();

    final SnackBar snackBar = SnackBar(
      content: Row(
        children: <Widget>[
          icon,
          const SizedBox(
              width: 10), // Replacing MWSizedBox with a standard widget.
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
    );

    _showSnackBar(snackBar);
  }

  /// Hides the currently displayed snack bar, if any.
  void hideSnackBar() {
    _hideSnackBar();
  }

  /// Internal method to show a snack bar using [ScaffoldMessenger].
  ///
  /// [snackBar]: The snack bar to display.
  void _showSnackBar(SnackBar snackBar) {
    final BuildContext? context = GetIt.instance<RouteHelper>().navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      logger.debugLog('Error: Unable to show SnackBar. Context is null.');
    }
  }

  /// Internal method to hide the currently displayed snack bar.
  void _hideSnackBar() {
    final BuildContext? context = GetIt.instance<RouteHelper>().navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
    } else {
      logger.debugLog('Error: Unable to hide SnackBar. Context is null.');
    }
  }
}
