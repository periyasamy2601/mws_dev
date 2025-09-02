import 'package:avk/router/path_exporter.dart';

class FilterTreeView extends StatefulWidget {
  const FilterTreeView({
    required this.node,
    required this.scrollController,
    required this.onToggleMapped,
    super.key,
    this.depth = 0,
  });

  final TreeNode<UserName> node;
  final int depth;
  final ScrollController scrollController;
  final Function(TreeNode<UserName> child) onToggleMapped;

  @override
  State<FilterTreeView> createState() => _FilterTreeViewState();
}

class _FilterTreeViewState extends State<FilterTreeView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  Map<int, Color> get colorMapper => <int, Color>{
    0: Colors.indigo[100]!,
    1: Colors.orange[100]!,
    2: Colors.indigo[50]!,
    3: Colors.orange[50]!,
    4: Colors.blueGrey[100]!,
  };

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
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
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

  Future<void> _handleTap(FilterCubit cubit, bool expanded) async {
    cubit.toggleNode(widget.node.key);
    if (expanded) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (BuildContext context, FilterState state) {
        final FilterCubit cubit = context.read<FilterCubit>();
        final bool expanded = cubit.isExpanded(widget.node.key);
        final bool hasChildren = widget.node.children.isNotEmpty;
        final bool showChildren = expanded || _controller.isAnimating;

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (expanded && !_controller.isCompleted) {
            await _controller.forward();
          } else if (!expanded && !_controller.isDismissed) {
            await _controller.reverse();
          }
        });

        final num indent = widget.depth * (context.isMobile() ? 5 : 16.0);
        final Color bgColor = colorMapper[widget.depth] ?? Colors.grey[100]!;
        final Color borderColor = borderColorMapper[widget.depth] ?? Colors.grey;

        final bool hasChild = widget.node.children.isNotEmpty;
        final bool isSite = widget.node.data.description.isNotEmpty;
        final bool isSelected = widget.node.data.isMapped;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {

                  await _handleTap(cubit, expanded);

              },
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  border: Border(bottom: BorderSide(color: borderColor)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                margin: EdgeInsets.only(left: indent * 2, right: 8),
                child: Row(
                  children: <Widget>[

                    if(hasChild || isSite)...<Widget>[
                      SizedBox(
                        height: 24,
                        child: Checkbox(
                          side: BorderSide(color: context.getColor().primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          value: isSelected,
                          onChanged:(bool? checked) {
                            widget.onToggleMapped(widget.node);
                          },
                        ),
                      )
                    ],
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
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                widget.node.data.description,
                                style: context.getStyle().labelMedium,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (hasChildren)
                      AnimatedRotation(
                        turns: expanded ? 0.0 : 0.5,
                        duration: const Duration(milliseconds: 250),
                        child: appSvg.expansionIconSmall,
                      )
                    else
                      const SizedBox(width: 23),
                  ],
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _expandAnimation,
              axisAlignment: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: showChildren
                    ? widget.node.children.map(
                      (TreeNode<UserName> child) => FilterTreeView(
                    scrollController: widget.scrollController,
                    node: child,
                    depth: widget.depth + 1,
                    onToggleMapped: (TreeNode<UserName> onToggleMapped) {
                      widget.onToggleMapped(onToggleMapped);
                    },
                  ),
                ).toList()
                    : <Widget>[],
              ),
            ),
          ],
        );
      },
    );
  }
}
