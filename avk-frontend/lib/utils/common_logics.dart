import 'package:avk/router/path_exporter.dart';

/// A utility class containing reusable logic for working with zones
/// and converting them into hierarchical tree structures.
class CommonLogics {
  /// Converts a list of [ZoneEntity] objects into a tree of [TreeNode<UserName>].
  ///
  /// Each [ZoneEntity] becomes a root-level node in the tree.
  /// - Zone children are added recursively via [addChildrenRecursively].
  /// - Associated sites (if any) are added as child nodes at level `0`.
  ///
  /// Returns a list of root-level tree nodes.
  List<TreeNode<UserName>> convertZonesToTree(List<ZoneEntity> zones) {
    final List<TreeNode<UserName>> tree = <TreeNode<UserName>>[];

    for (final ZoneEntity zone in zones) {
      final String rootKey = zone.id!; // assume non-null id
      final TreeNode<UserName> rootNode = TreeNode<UserName>(
        key: rootKey,
        level: zone.level ?? 0,
        data: UserName(zone.name ?? 'Unnamed Zone', '',isMapped: zone.isMapped??false),
      );

      // Recursively add child zones
      addChildrenRecursively(zone.children ?? <ZoneChildren>[], rootNode);

      // Add associated sites, if present
      if (zone.sites != null && zone.sites!.isNotEmpty) {
        for (final ZoneChildrenSites site in zone.sites!) {
          final String siteKey = site.id!;
          final TreeNode<UserName> siteNode = TreeNode<UserName>(
            key: siteKey,
            level: 0,
            data: UserName(site.name ?? 'Unnamed Site', '(site)',isMapped: site.isMapped??false),
          );
          rootNode.add(siteNode);
        }
      }

      tree.add(rootNode);
    }

    return tree;
  }

  /// Recursively adds child [ZoneChildren] nodes and their associated sites
  /// into the [parent] tree node.
  ///
  /// - If a child has further nested children, the method calls itself recursively.
  /// - If a child has associated sites, they are added as leaf nodes at level `0`.
  void addChildrenRecursively(
      List<ZoneChildren> children,
      TreeNode<UserName> parent,
      ) {
    for (final ZoneChildren child in children) {
      final String childKey = child.id!;
      final TreeNode<UserName> childNode = TreeNode<UserName>(
        key: childKey,
        level: child.level ?? 0,
        data: UserName(child.name ?? 'Unnamed Zone', '',isMapped: child.isMapped??false),
      );

      // Recursively process nested children
      addChildrenRecursively(child.children ?? <ZoneChildren>[], childNode);

      // Add associated sites
      if (child.sites != null && child.sites!.isNotEmpty) {
        for (final ZoneChildrenSites site in child.sites!) {
          final String siteKey = site.id!;
          final TreeNode<UserName> siteNode = TreeNode<UserName>(
            key: siteKey,
            level: 0,
            data: UserName(site.name ?? 'Unnamed Site', '(site)',isMapped: site.isMapped??false),
          );
          childNode.add(siteNode);
        }
      }

      parent.add(childNode);
    }
  }


  /// get selected site ids my checking is_mapped variable
  List<String> getSelectedSiteIds(List<TreeNode<UserName>> nodeList ) {
    List<String> siteIds = <String>[];

    void collect(TreeNode<UserName> node) {
      if (node.data.description.isNotEmpty && node.data.isMapped) {
        siteIds.add(node.key); // Assuming `id` is the site ID
      }
      node.children.forEach(collect);
    }

    nodeList.forEach(collect);

    return siteIds;
  }

}
