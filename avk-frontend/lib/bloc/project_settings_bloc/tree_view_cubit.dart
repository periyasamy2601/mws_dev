import 'package:avk/router/path_exporter.dart';

/// State class for the [TreeViewCubit].
///
/// Holds a map of node keys and their expanded/collapsed state.
class TreeViewState {
  /// Creates a [TreeViewState] with the given [expandedMap].
  TreeViewState({required this.expandedMap});

  /// A map that stores the expanded state of each node.
  ///
  /// - `true` means the node is expanded.
  /// - `false` means the node is collapsed.
  final Map<String, bool> expandedMap;

  /// Returns a new [TreeViewState] with updated values.
  ///
  /// If [expandedMap] is not provided, the existing map is retained.
  TreeViewState copyWith({Map<String, bool>? expandedMap}) {
    return TreeViewState(
      expandedMap: expandedMap ?? this.expandedMap,
    );
  }
}

/// A Cubit for managing the expanded/collapsed state of a tree view.
///
/// Provides methods to toggle and check the expansion state of nodes.
class TreeViewCubit extends Cubit<TreeViewState> {
  /// Creates a [TreeViewCubit] with an empty expandedMap.
  TreeViewCubit() : super(TreeViewState(expandedMap: <String, bool>{}));

  /// Toggles the expansion state of a node identified by [key].
  void toggleNode(String key) {
    final bool current = state.expandedMap[key] ?? false;
    emit(TreeViewState(
      expandedMap: <String, bool>{
        ...state.expandedMap,
        key: !current,
      },
    ));
  }

  /// Returns `true` if the node with [key] is expanded, otherwise `false`.
  bool isExpanded(String key) => state.expandedMap[key] ?? false;
}
