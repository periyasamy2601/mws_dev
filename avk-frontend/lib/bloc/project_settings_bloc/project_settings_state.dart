part of 'project_settings_bloc.dart';

/// Base class for all project settings states.
///
/// Extend this class to represent different states emitted by
/// the [ProjectSettingsBloc].
@immutable
sealed class ProjectSettingsState {}

/// Initial state of [ProjectSettingsBloc].
///
/// This state is emitted when the bloc is first created
/// before any data is loaded.
final class ProjectSettingsInitial extends ProjectSettingsState {}

/// State emitted when project settings data has been fetched
/// or updated successfully.
///
/// Holds information about the current state, project settings,
/// role list, and zone list.
final class ProjectSettingsResponseState extends ProjectSettingsState {
  /// Creates a [ProjectSettingsResponseState].
  ProjectSettingsResponseState({
    required this.stateEnum,
    required this.projectSettingsEntity,
    required this.roleList,
    required this.zoneList,
    this.updateEnum,
  });

  /// Enum representing the current high-level state of project settings.
  final ProjectSettingsStateEnum stateEnum;

  /// Optional enum to specify which part of the state was updated.
  final ProjectSettingsStateEnum? updateEnum;

  /// Entity representing the project settings details.
  final ProjectSettingsEntity? projectSettingsEntity;

  /// List of roles available in the project settings.
  final List<RoleEntity> roleList;

  /// List of zones represented as a tree structure.
  final List<TreeNode<UserName>> zoneList;
}
