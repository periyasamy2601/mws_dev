import 'package:avk/router/path_exporter.dart';

class FilterSelectionView extends StatefulWidget {
  const FilterSelectionView({super.key, required this.node, required this.scrollController, required this.onToggleMapped});

  final List<TreeNode<UserName>> node;
  final ScrollController scrollController;
  final Function(List<String> siteIds) onToggleMapped;

  @override
  State<FilterSelectionView> createState() => _FilterSelectionViewState();
}

class _FilterSelectionViewState extends State<FilterSelectionView> {

  CommonLogics commonLogics = GetIt.I<CommonLogics>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.node.map((TreeNode<UserName> node) {
        return FilterTreeView(
          node: node,
          scrollController: widget.scrollController,
          onToggleMapped:_toggleClicked,
        );
      }).toList(),
    );
  }

  void _toggleClicked(TreeNode<UserName> node) {
    final bool isSite = node.data.description.isNotEmpty;
    final bool shouldSelect = !node.data.isMapped;
    logger.debugLog('node.data.isMapped ${node.data.isMapped}', node.data.name);

    final List<TreeNode<UserName>> allNodeList = widget.node;

    setState(() {
      if (isSite) {
        node.data.isMapped = shouldSelect;

        if (shouldSelect) {
          mapAncestorsUpToRoot(allNodeList, node);
        } else {
          unmapAncestorsIfNoMappedSites(allNodeList, node);
        }
      } else {
        // Toggle zone and all descendants
        toggleRecursively(node, isSelected: shouldSelect);

        if (shouldSelect) {
          // Also map ancestor zones up to root
          mapAncestorsUpToRoot(allNodeList, node);
        } else {
          // Unmap ancestors if no mapped sites remain
          unmapAncestorsIfNoMappedSites(allNodeList, node);
        }
      }
    });
    final List<String> selectedSiteIds = commonLogics.getSelectedSiteIds(widget.node);
    logger.debugLog('selectedSiteIds',selectedSiteIds);
    widget.onToggleMapped(selectedSiteIds);
  }
  bool hasAnyMappedSiteInSubtree(TreeNode<UserName> node) {
    // If this node is a site and is mapped, return true
    if (node.data.description.isNotEmpty && node.data.isMapped) {
      return true;
    }

    // Recursively check children
    for (final TreeNode<UserName> child in node.children) {
      if (hasAnyMappedSiteInSubtree(child)) {
        return true;
      }
    }

    return false;
  }

  void unmapAncestorsIfNoMappedSites(List<TreeNode<UserName>> allNodes, TreeNode<UserName> node) {
    final TreeNode<UserName>? parent = findParentNode(allNodes, node);
    if (parent != null) {
      bool anyMappedSiteInSubtree = parent.children.any(hasAnyMappedSiteInSubtree);

      if (!anyMappedSiteInSubtree && parent.data.isMapped) {
        parent.data.isMapped = false;
        unmapAncestorsIfNoMappedSites(allNodes, parent);
      }
    }
  }

  TreeNode<UserName>? findParentNode(List<TreeNode<UserName>> allNodes, TreeNode<UserName> target) {
    for (final TreeNode<UserName> node in allNodes) {
      if (node.children.any((TreeNode<UserName> child) => child.key == target.key)) {
        return node;
      }
      final TreeNode<UserName>? parentInChildren = findParentNode(node.children, target);
      if (parentInChildren != null) {
        return parentInChildren;
      }
    }
    return null;
  }

  void mapAncestorsUpToRoot(List<TreeNode<UserName>> allNodes, TreeNode<UserName> node) {
    final TreeNode<UserName>? parent = findParentNode(allNodes, node);
    if (parent != null) {
      if (!parent.data.isMapped) {
        parent.data.isMapped = true;
      }
      mapAncestorsUpToRoot(allNodes, parent);
    }
  }

  void toggleRecursively(TreeNode<UserName> node, {required bool isSelected}) {
    node.data.isMapped = isSelected;
    logger.debugLog('node.children',node.children);
    for (final TreeNode<UserName> child in node.children) {
      toggleRecursively(child,isSelected: isSelected);
    }
  }
}
