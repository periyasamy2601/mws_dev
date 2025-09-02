import 'package:avk/router/path_exporter.dart';

/// A widget that displays the "Zone Section", including a header,
/// an "Add Zone" button, and a collapsible tree of zones with sites.
/// Uses [ValueNotifier]s to reactively rebuild when zone expansion state
/// or zone list data changes.
class ZoneSection extends StatelessWidget {
  /// Creates a [ZoneSection].
  ///
  /// - [zoneExpansionNotifier] : controls whether the zone tree is expanded.
  /// - [zoneListNotifier] : provides the list of zones to render.
  /// - [onAddZoneTap] : callback triggered when the "Add Zone" button is tapped.
  /// - [onAddChildZoneTap] : callback to add a child zone inside a zone node.
  /// - [onAddChildSiteTap] : callback to add a site inside a zone node.
  /// - [headerWidget] : widget shown in the header (e.g., title).
  /// - [loader] : whether to show loading state on the add button.
  /// - [scrollController] : used to handle tree auto-scrolling when expanding.
  const ZoneSection({
    required this.zoneExpansionNotifier,
    required this.zoneListNotifier,
    required this.onAddZoneTap,
    required this.headerWidget,
    required this.loader,
    required this.scrollController,
    required this.onAddChildZoneTap,
    required this.onAddChildSiteTap,
    required this.addChildEditTap,
    required this.addChildDeleteTap,
    super.key,
  });

  /// Controls expansion state of the zone tree.
  final ValueNotifier<bool> zoneExpansionNotifier;

  /// Holds the list of zones to render in the tree.
  final ValueNotifier<List<TreeNode<UserName>>> zoneListNotifier;

  /// Callback when "Add Zone" is tapped.
  final void Function() onAddZoneTap;

  /// Callback when adding a child zone to an existing zone.
  final void Function(TreeNode<UserName>) onAddChildZoneTap;

  /// Callback when adding a child site to an existing zone.
  final void Function(TreeNode<UserName>) onAddChildSiteTap;
  /// Callback when a new "Zone" is added as a child.
  final void Function(TreeNode<UserName> zone) addChildEditTap;

  /// Callback when a new "Site" is added as a child.
  final void Function(TreeNode<UserName> site) addChildDeleteTap;


  /// Header widget displayed at the top of the section.
  final Widget headerWidget;

  /// Loader state for the add zone button.
  final bool loader;

  /// Scroll controller used by the tree for auto-scrolling.
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: zoneExpansionNotifier,
      builder: (BuildContext context, bool isExpanded, _) {
        return ValueListenableBuilder<List<TreeNode<UserName>>>(
          valueListenable: zoneListNotifier,
          builder:
              (BuildContext context, List<TreeNode<UserName>> zoneList, _) {
                return Column(
                  spacing: dimensions.spacingM,
                  children: <Widget>[
                    // Header row: title, add zone button, expansion toggle
                    BaseButton(
                      onTap: () {
                        if (zoneList.isNotEmpty) {
                          zoneExpansionNotifier.value = !isExpanded;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          headerWidget,
                          Row(
                            spacing: dimensions.spacingM,
                            children: <Widget>[
                              PrimaryAppButton(
                                isLoading: loader,
                                buttonLabel: context.getText().add_zone,
                                isSmall: true,
                                customIcon: Icon(
                                  Icons.add,
                                  color: context.getColor().surface,
                                  size: 20,
                                ),
                                onButtonTap: onAddZoneTap,
                              ),
                              if (zoneList.isNotEmpty)
                                RotatedBox(
                                  quarterTurns: isExpanded ? 0 : 2,
                                  child: appSvg.expansionIconLarge,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if(isExpanded)
                    // Render all zones as a tree view
                    Column(
                      children: zoneList
                          .map(
                            (TreeNode<UserName> node) => CustomTreeView(
                              scrollController: scrollController,
                              node: node,
                              addChildZone: onAddChildZoneTap,
                              addChildSite: onAddChildSiteTap,
                              addChildDeleteTap:addChildDeleteTap,
                              addChildEditTap:addChildEditTap,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                );
              },
        );
      },
    );
  }
}
