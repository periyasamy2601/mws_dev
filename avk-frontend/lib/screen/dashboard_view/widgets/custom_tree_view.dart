import 'package:avk/router/path_exporter.dart';

/// A custom tree view widget that displays hierarchical data
/// with expandable/collapsible child nodes.
class CustomTreeView extends StatefulWidget {
  /// constructor
  const CustomTreeView({
    required this.node,
    required this.addChildZone,
    required this.addChildSite,
    required this.addChildEditTap,
    required this.addChildDeleteTap,
    required this.scrollController,
    super.key,
    this.depth = 0,
  });

  /// The root node of the tree/subtree to render.
  final TreeNode<UserName> node;

  /// Depth level in the tree hierarchy (used for indentation and coloring).
  final int depth;

  /// Callback when a new "Zone" is added as a child.
  final void Function(TreeNode<UserName> zone) addChildZone;

  /// Callback when a new "Site" is added as a child.
  final void Function(TreeNode<UserName> site) addChildSite;

  /// Callback when a new "Zone" is added as a child.
  final void Function(TreeNode<UserName> zone) addChildEditTap;

  /// Callback when a new "Site" is added as a child.
  final void Function(TreeNode<UserName> site) addChildDeleteTap;

  /// Scroll controller to automatically scroll when expanding.
  final ScrollController scrollController;

  @override
  State<CustomTreeView> createState() => _CustomTreeViewState();
}

class _CustomTreeViewState extends State<CustomTreeView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  /// Background colors mapped to depth levels.
  Map<int, Color> get colorMapper => <int, Color>{
    0: Colors.indigo[100]!,
    1: Colors.orange[100]!,
    2: Colors.indigo[50]!,
    3: Colors.orange[50]!,
    4: Colors.blueGrey[100]!,
  };

  /// Border colors mapped to depth levels.
  Map<int, Color> get borderColorMapper => <int, Color>{
    0: Colors.indigo[800]!,
    1: Colors.orange[500]!,
    2: Colors.indigo[800]!,
    3: Colors.orange[500]!,
    4: Colors.blueGrey[500]!,
  };

  @override
  void initState() {
    super.initState();

    // Animation controller for expand/collapse
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    // Smooth ease-in-out curve for expansion
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Auto-scroll to bottom when expansion finishes
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final double maxScroll =
              widget.scrollController.position.maxScrollExtent;
          final double currentScroll = widget.scrollController.position.pixels;

          if (currentScroll < maxScroll) {
            await widget.scrollController.animateTo(
              maxScroll,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handles tapping on a node to expand or collapse it.
  Future<void> _handleTap(TreeViewCubit cubit, bool expanded) async {
    cubit.toggleNode(widget.node.key);

    if (expanded) {
      await _controller.reverse(); // collapse
    } else {
      await _controller.forward(); // expand
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreeViewCubit, TreeViewState>(
      builder: (BuildContext context, TreeViewState state) {
        final TreeViewCubit cubit = context.read<TreeViewCubit>();

        final bool expanded = cubit.isExpanded(widget.node.key);
        final bool hasChildren = widget.node.children.isNotEmpty;
        final bool showChildren = expanded || _controller.isAnimating;

        // Ensure animation state matches Bloc expansion state
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (expanded && !_controller.isCompleted) {
            await _controller.forward();
          } else if (!expanded && !_controller.isDismissed) {
            await _controller.reverse();
          }
        });

        final double indent = widget.depth * (context.isMobile() ? 5 : 16.0);
        final Color bgColor = colorMapper[widget.depth] ?? Colors.grey[100]!;
        final Color borderColor =
            borderColorMapper[widget.depth] ?? Colors.grey;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Node header (clickable row)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: hasChildren ? () => _handleTap(cubit, expanded) : null,
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  border: Border(bottom: BorderSide(color: borderColor)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                margin: EdgeInsets.only(left: indent * 2, right: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              // Node title
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        widget.node.data.name,
                                        style: context.getStyle().bodyMedium,
                                      ),
                                    ),
                                    if (widget.node.data.description.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          widget.node.data.description,
                                          style: context.getStyle().labelMedium,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              // Optional description

                              // Add Zone / Site buttons (only for certain depths)
                              if (widget.node.data.description.isEmpty &&
                                  (widget.depth < 4) && !context.isMobile()) ...<Widget>[
                                  BaseButton(
                                    onTap: () =>
                                        widget.addChildSite(widget.node),
                                    child: _buildAddButton(
                                      context,
                                      context.getText().site,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  BaseButton(
                                    onTap: () =>
                                        widget.addChildZone(widget.node),
                                    child: _buildAddButton(
                                      context,
                                      context.getText().zone,
                                    ),
                                  ),
                              ],
                              if (!context.isMobile()) ...<Widget>[
                                const SizedBox(width: 20),
                                CustomPopupMenu<EditDeleteEnum>(
                                  menuItems: EditDeleteEnum.values,
                                  onSelected: (EditDeleteEnum value) {
                                    switch (value) {
                                      case EditDeleteEnum.edit:
                                        widget.addChildEditTap(widget.node);
                                      case EditDeleteEnum.delete:
                                        widget.addChildDeleteTap(widget.node);
                                    }
                                  },
                                  iconBuilder: (EditDeleteEnum value) {
                                    switch (value) {
                                      case EditDeleteEnum.edit:
                                        return appSvg.editIcon;
                                      case EditDeleteEnum.delete:
                                        return appSvg.deleteIcon;
                                    }
                                  },
                                  labelBuilder: (EditDeleteEnum value) {
                                    switch (value) {
                                      case EditDeleteEnum.edit:
                                        return context.getText().edit;
                                      case EditDeleteEnum.delete:
                                        return context.getText().delete;
                                    }
                                  },
                                ),
                              ]else...<Widget>[
                                if(widget.node.data.description.isEmpty &&
                                    (widget.depth < 4))
                                CustomPopupMenu<ProjectSettingsPopupEnum>(
                                  menuItems: ProjectSettingsPopupEnum.values,
                                  onSelected:
                                      (ProjectSettingsPopupEnum value) {
                                    switch (value) {
                                      case ProjectSettingsPopupEnum.edit:
                                        widget.addChildEditTap(
                                          widget.node,
                                        );
                                      case ProjectSettingsPopupEnum
                                          .delete:
                                        widget.addChildDeleteTap(
                                          widget.node,
                                        );
                                      case ProjectSettingsPopupEnum
                                          .addSite:
                                        widget.addChildSite(widget.node);
                                      case ProjectSettingsPopupEnum
                                          .addZone:
                                        widget.addChildZone(widget.node);
                                    }
                                  },
                                  iconBuilder:
                                      (ProjectSettingsPopupEnum value) {
                                    switch (value) {
                                      case ProjectSettingsPopupEnum.edit:
                                        return appSvg.editIcon;
                                      case ProjectSettingsPopupEnum
                                          .delete:
                                        return appSvg.deleteIcon;
                                      case ProjectSettingsPopupEnum
                                          .addSite:
                                        return appSvg.addIcon;
                                      case ProjectSettingsPopupEnum
                                          .addZone:
                                        return appSvg.addIcon;
                                    }
                                  },
                                  labelBuilder:
                                      (ProjectSettingsPopupEnum value) {
                                    switch (value) {
                                      case ProjectSettingsPopupEnum.edit:
                                        return context.getText().edit;
                                      case ProjectSettingsPopupEnum
                                          .delete:
                                        return context.getText().delete;
                                      case ProjectSettingsPopupEnum
                                          .addSite:
                                        return context.getText().add_site;
                                      case ProjectSettingsPopupEnum
                                          .addZone:
                                        return context.getText().add_zone;
                                    }
                                  },
                                )
                                else
                                  CustomPopupMenu<EditDeleteEnum>(
                                    menuItems: EditDeleteEnum.values,
                                    onSelected: (EditDeleteEnum value) {
                                      switch (value) {
                                        case EditDeleteEnum.edit:
                                          widget.addChildEditTap(widget.node);
                                        case EditDeleteEnum.delete:
                                          widget.addChildDeleteTap(widget.node);
                                      }
                                    },
                                    iconBuilder: (EditDeleteEnum value) {
                                      switch (value) {
                                        case EditDeleteEnum.edit:
                                          return appSvg.editIcon;
                                        case EditDeleteEnum.delete:
                                          return appSvg.deleteIcon;
                                      }
                                    },
                                    labelBuilder: (EditDeleteEnum value) {
                                      switch (value) {
                                        case EditDeleteEnum.edit:
                                          return context.getText().edit;
                                        case EditDeleteEnum.delete:
                                          return context.getText().delete;
                                      }
                                    },
                                  ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Expansion icon (rotates)
                    if (hasChildren)
                      AnimatedRotation(
                        turns: expanded ? 0.0 : 0.5,
                        duration: const Duration(milliseconds: 250),
                        child: appSvg.expansionIconSmall,
                      )
                    else
                      const SizedBox(width: 23), // empty placeholder
                  ],
                ),
              ),
            ),

            // Animated children list
            SizeTransition(
              sizeFactor: _expandAnimation,
              axisAlignment: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: showChildren
                    ? widget.node.children
                          .map(
                            (TreeNode<UserName> child) => CustomTreeView(
                              scrollController: widget.scrollController,
                              node: child,
                              depth: widget.depth + 1,
                              addChildZone: widget.addChildZone,
                              addChildSite: widget.addChildSite,
                              addChildDeleteTap: widget.addChildDeleteTap,
                              addChildEditTap: widget.addChildEditTap,
                            ),
                          )
                          .toList()
                    : <Widget>[],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Helper widget for "Add" buttons (Zone/Site).
  Widget _buildAddButton(BuildContext context, String label) {
    return Container(
      alignment: Alignment.center,
      width: 103,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(dimensions.radiusXS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.add, size: 20),
          const SizedBox(width: 4),
          Text(label, style: context.getStyle().bodySmall),
        ],
      ),
    );
  }
}

/// Data class representing a user with a name and description.
class UserName {
  /// constructor
  UserName(this.name, this.description, {this.isMapped = false});

  /// name to define each zone or site.
  final String name;

  /// description to define weather its zone or site
  final String description;

  /// is Mapped is used in filtering sites

  bool isMapped;
}

/// Generic tree node model that can hold children recursively.
class TreeNode<T> {
  /// constructor
  TreeNode({required this.key, required this.level, required this.data});

  /// Unique identifier for the node.
  final String key;

  /// Hierarchical level (depth in tree).
  final int level;

  /// Node data (can be any type).
  final T data;

  /// Child nodes.
  final List<TreeNode<T>> children = <TreeNode<T>>[];

  /// Adds a single child.
  void add(TreeNode<T> child) => children.add(child);

  /// Adds multiple children at once.
  void addAll(List<TreeNode<T>> childrenList) => children.addAll(childrenList);

  /// Whether this node has no children.
  bool get isLeaf => children.isEmpty;
}
