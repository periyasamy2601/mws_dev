import 'package:avk/router/path_exporter.dart';

/// A reusable popup menu widget that dynamically builds menu items
/// based on the provided enum values and callbacks.
class CustomPopupMenu<T> extends StatelessWidget {
  /// Creates a [CustomPopupMenu].
  ///
  /// [menuItems] is a list of enum values representing the menu options.
  /// [onSelected] is triggered when a menu item is tapped.
  /// [iconBuilder] returns the icon widget for a given enum value.
  /// [labelBuilder] returns the text label for a given enum value.
  const CustomPopupMenu({
    required this.menuItems,
    required this.onSelected,
    required this.iconBuilder,
    required this.labelBuilder,
    super.key,
  });

  /// The list of enum values that will be shown in the menu.
  final List<T> menuItems;

  /// Called when the user selects a menu item.
  final void Function(T value) onSelected;

  /// Provides the icon for a given enum value.
  final Widget Function(T value) iconBuilder;

  /// Provides the label for a given enum value.
  final String Function(T value) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      splashRadius: 0.1,
      icon: const Icon(Icons.more_vert_sharp),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return menuItems.map((T value) {
          return PopupMenuItem<T>(
            value: value,
            child: SizedBox(
              width: 135,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(width: 40, child: iconBuilder(value)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          labelBuilder(value),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList();
      },
    );
  }
}