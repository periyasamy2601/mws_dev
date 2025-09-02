part of 'project_settings_bloc.dart';

/// Base class for all project settings events.
///
/// Extend this class to define actions that can be dispatched
/// to the [ProjectSettingsBloc].
@immutable
sealed class ProjectSettingsEvent {}

/// Event to fetch all project settings (initial load or refresh).
class ProjectSettingsGetEvent extends ProjectSettingsEvent {
  /// Creates a [ProjectSettingsGetEvent].
  ProjectSettingsGetEvent();
}

/// Event triggered when the project name is submitted.
class ProjectNameSubmitEvent extends ProjectSettingsEvent {
  /// Creates a [ProjectNameSubmitEvent].
  ProjectNameSubmitEvent({required this.projectName});

  /// Name of the project to be updated/submitted.
  final String projectName;
}

/// Event triggered when device types are submitted.
class DeviceTypeSubmitEvent extends ProjectSettingsEvent {
  /// Creates a [DeviceTypeSubmitEvent].
  DeviceTypeSubmitEvent({required this.deviceTypes});

  /// List of selected device type IDs.
  final List<int> deviceTypes;
}

/// Event triggered when project units are submitted.
///
/// Contains flow, pressure, level, and chlorine unit details
/// along with their min/max values.
class UnitsSubmitEvent extends ProjectSettingsEvent {
  /// Creates a [UnitsSubmitEvent].
  UnitsSubmitEvent({
    required this.flowQuantity,
    required this.flowRate,
    required this.flowOutput,
    required this.pressureUnit,
    required this.pressureMinValue,
    required this.pressureMaxValue,
    required this.levelUnit,
    required this.levelMinValue,
    required this.levelMaxValue,
    required this.chlorineQuantityUnit,
    required this.chlorineOutputUnit,
    required this.chlorineMinValue,
    required this.chlorineMaxValue,
  });

  /// Flow quantity unit.
  final FlowQuantityEnum flowQuantity;

  /// Flow rate unit.
  final FlowRateEnum flowRate;

  /// Flow output unit.
  final FlowOutputEnum flowOutput;

  /// Pressure unit.
  final PressureUnit pressureUnit;

  /// Minimum allowed pressure value.
  final String pressureMinValue;

  /// Maximum allowed pressure value.
  final String pressureMaxValue;

  /// Level unit.
  final LevelUnit levelUnit;

  /// Minimum allowed level value.
  final String levelMinValue;

  /// Maximum allowed level value.
  final String levelMaxValue;

  /// Chlorine quantity unit.
  final ChlorineQuantityUnit chlorineQuantityUnit;

  /// Chlorine output unit.
  final ChlorineOutputUnit chlorineOutputUnit;

  /// Minimum allowed chlorine value.
  final String chlorineMinValue;

  /// Maximum allowed chlorine value.
  final String chlorineMaxValue;
}

/// Event to add a new role in project settings.
class AddRoleEvent extends ProjectSettingsEvent {
  /// Creates an [AddRoleEvent].
  AddRoleEvent({required this.roleName, required this.roleEnum});

  /// Display name of the role.
  final String roleName;

  /// Enum representing the type/category of the role.
  final RoleEnum roleEnum;
}

/// Event to update an existing role in project settings.
class UpdateRoleEvent extends ProjectSettingsEvent {
  /// Creates an [UpdateRoleEvent].
  UpdateRoleEvent({
    required this.roleName,
    required this.roleEnum,
    required this.roleId,
  });

  /// Unique identifier of the role to update.
  final String roleId;

  /// Updated role name.
  final String roleName;

  /// Updated role type/category.
  final RoleEnum roleEnum;
}

/// Event to delete a role from project settings.
class DeleteRoleEvent extends ProjectSettingsEvent {
  /// Creates a [DeleteRoleEvent].
  DeleteRoleEvent({required this.roleId});

  /// Unique identifier of the role to delete.
  final String roleId;
}

/// Event to fetch all roles (with optional update trigger).
class GetRolesEvent extends ProjectSettingsEvent {
  /// Creates a [GetRolesEvent].
  GetRolesEvent({this.updateEnum});

  /// Optional enum to indicate specific update behavior.
  final ProjectSettingsStateEnum? updateEnum;
}

/// Event to fetch the list of zones in the project.
class GetZoneListEvent extends ProjectSettingsEvent {
  /// Creates a [GetZoneListEvent].
  GetZoneListEvent({this.updateEnum});

  /// Optional enum to indicate specific update behavior.
  final ProjectSettingsStateEnum? updateEnum;
}

/// Event to add a new zone at a given level.
class AddZoneEvent extends ProjectSettingsEvent {
  /// Creates an [AddZoneEvent].
  AddZoneEvent({required this.name, required this.level});

  /// Name of the zone.
  final String name;

  /// Hierarchical level of the zone.
  final int level;
}

/// Event to add a child zone under an existing parent zone.
class AddChildZoneEvent extends ProjectSettingsEvent {
  /// Creates an [AddChildZoneEvent].
  AddChildZoneEvent({
    required this.name,
    required this.level,
    required this.parentZoneID,
  });

  /// Name of the child zone.
  final String name;

  /// Unique identifier of the parent zone.
  final String parentZoneID;

  /// Level of the child zone.
  final int level;
}

/// Event to add a child site under an existing parent zone.
class AddChildSiteEvent extends ProjectSettingsEvent {
  /// Creates an [AddChildSiteEvent].
  AddChildSiteEvent({
    required this.name,
    required this.parentZoneID,
  });

  /// Name of the child site.
  final String name;

  /// Unique identifier of the parent zone.
  final String parentZoneID;
}
/// Event to add a child zone under an existing parent zone.
class EditChildZoneEvent extends ProjectSettingsEvent {
  /// Creates an [AddChildZoneEvent].
  EditChildZoneEvent({
    required this.name,
    required this.level,
    required this.parentZoneID,
  });

  /// Name of the child zone.
  final String name;

  /// Unique identifier of the parent zone.
  final String parentZoneID;

  /// Level of the child zone.
  final int level;
}

/// Event to add a child site under an existing parent zone.
class EditChildSiteEvent extends ProjectSettingsEvent {
  /// Creates an [AddChildSiteEvent].
  EditChildSiteEvent({
    required this.name,
    required this.parentZoneID,
  });

  /// Name of the child site.
  final String name;

  /// Unique identifier of the parent zone.
  final String parentZoneID;
}
/// Event to add a child zone under an existing parent zone.
class DeleteChildZoneEvent extends ProjectSettingsEvent {
  /// Creates an [AddChildZoneEvent].
  DeleteChildZoneEvent({
    required this.level,
    required this.parentZoneID,
  });

  /// Unique identifier of the parent zone.
  final String parentZoneID;

  /// Level of the child zone.
  final int level;
}

/// Event to add a child site under an existing parent zone.
class DeleteChildSiteEvent extends ProjectSettingsEvent {
  /// Creates an [AddChildSiteEvent].
  DeleteChildSiteEvent({
    required this.parentZoneID,
  });

  /// Unique identifier of the parent zone.
  final String parentZoneID;
}
