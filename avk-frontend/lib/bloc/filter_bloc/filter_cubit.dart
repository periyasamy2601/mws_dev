import 'package:avk/router/path_exporter.dart';

/// State class for the [FilterCubit].
///
/// Holds a map of node keys and their expanded/collapsed state.
class FilterState {
  /// Creates a [FilterState] with the given [expandedMap].
  FilterState({required this.expandedMap});

  /// A map that stores the expanded state of each node.
  ///
  /// - `true` means the node is expanded.
  /// - `false` means the node is collapsed.
  final Map<String, bool> expandedMap;

  /// Returns a new [FilterState] with updated values.
  ///
  /// If [expandedMap] is not provided, the existing map is retained.
  FilterState copyWith({Map<String, bool>? expandedMap}) {
    return FilterState(
      expandedMap: expandedMap ?? this.expandedMap,
    );
  }
}

/// A Cubit for managing the expanded/collapsed state of a tree view.
///
/// Provides methods to toggle and check the expansion state of nodes.
class FilterCubit extends Cubit<FilterState> {
  /// Creates a [FilterCubit] with an empty expandedMap.
  FilterCubit() : super(FilterState(expandedMap: <String, bool>{}));

  /// Toggles the expansion state of a node identified by [key].
  void toggleNode(String key) {
    final bool current = state.expandedMap[key] ?? false;
    emit(FilterState(
      expandedMap: <String, bool>{
        ...state.expandedMap,
        key: !current,
      },
    ));
  }

  /// Returns `true` if the node with [key] is expanded, otherwise `false`.
  bool isExpanded(String key) => state.expandedMap[key] ?? false;
}
