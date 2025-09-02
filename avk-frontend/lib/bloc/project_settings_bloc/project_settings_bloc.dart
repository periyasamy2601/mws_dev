import 'package:avk/router/path_exporter.dart';

part 'project_settings_event.dart';
part 'project_settings_state.dart';

/// Bloc that manages the state and events related to **Project Settings**.
///
/// Handles actions such as loading, updating, and persisting project settings,
/// and emits corresponding states for the UI to react to.
class ProjectSettingsBloc
    extends Bloc<ProjectSettingsEvent, ProjectSettingsState> {
  /// Creates a [ProjectSettingsBloc].
  ///
  /// - [_projectSettingsController] : A controller/service class responsible
  ///   for handling project settings logic such as API calls or local storage.
  ProjectSettingsBloc(this._projectSettingsController)
    : super(ProjectSettingsInitial()) {
    on<ProjectSettingsGetEvent>(_onProjectSettingsGetEvent);
    on<ProjectNameSubmitEvent>(_onProjectNameSubmitEvent);
    on<DeviceTypeSubmitEvent>(_onDeviceTypeSubmitEvent);
    on<UnitsSubmitEvent>(_onUnitsSubmitEvent);
    on<AddRoleEvent>(_onAddRoleEvent);
    on<GetRolesEvent>(_onGetRolesEvent);
    on<UpdateRoleEvent>(_onUpdateRoleEvent);
    on<DeleteRoleEvent>(_onDeleteRoleEvent);
    on<GetZoneListEvent>(_onGetZoneListEvent);
    on<AddZoneEvent>(_onAddZoneEvent);
    on<AddChildZoneEvent>(_onAddChildZoneEvent);
    on<AddChildSiteEvent>(_onAddChildSiteEvent);
    on<EditChildSiteEvent>(_onEditChildSiteEvent);
    on<EditChildZoneEvent>(_onEditChildZoneEvent);
    on<DeleteChildZoneEvent>(_onDeleteChildZoneEvent);
    on<DeleteChildSiteEvent>(_onDeleteChildSiteEvent);
  }

  final ProjectSettingsController _projectSettingsController;

  ProjectSettingsEntity? _projectSettingsEntity;

  List<RoleEntity> _roleList = <RoleEntity>[];
  List<TreeNode<UserName>> _zoneList = <TreeNode<UserName>>[];

  FutureOr<void> _onProjectSettingsGetEvent(
    ProjectSettingsGetEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    _emitState(emit, ProjectSettingsStateEnum.initialLoading);
    _projectSettingsEntity = await _projectSettingsController
        .getProjectSettingsData();
    if (_projectSettingsEntity != null) {
      if (_projectSettingsEntity?.id != null) {
        add(GetRolesEvent());
        add(GetZoneListEvent());
      } else {
        _emitState(emit, ProjectSettingsStateEnum.success);
      }
    } else {
      _emitState(emit, ProjectSettingsStateEnum.error);
    }
  }

  void _emitState(
    Emitter<ProjectSettingsState> emit,
    ProjectSettingsStateEnum stateEnum, {
    ProjectSettingsStateEnum? updateEnum,
  }) {
    emit(
      ProjectSettingsResponseState(
        roleList: _roleList,
        zoneList: _zoneList,
        updateEnum: updateEnum,
        stateEnum: stateEnum,
        projectSettingsEntity: _projectSettingsEntity,
      ),
    );
  }

  FutureOr<void> _onProjectNameSubmitEvent(
    ProjectNameSubmitEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    if (_projectSettingsEntity != null) {
      ProjectSettingsEntity projectSettingsEntity = ProjectSettingsEntity()
        ..name = event.projectName;
      _projectSettingsEntity?.name = event.projectName;
      _emitState(emit, ProjectSettingsStateEnum.projectSettingsNameLoading);
      await _projectSettingsController.putProjectSettingsData(
        projectSettingsEntity,
      );
      _emitState(
        emit,
        ProjectSettingsStateEnum.success,
        updateEnum: ProjectSettingsStateEnum.updateProjectName,
      );
    } else {
      _projectSettingsEntity = ProjectSettingsEntity()
        ..name = event.projectName;
      _emitState(emit, ProjectSettingsStateEnum.projectSettingsNameLoading);
      await _projectSettingsController.postProjectSettingsData(
        _projectSettingsEntity!,
      );
      add(ProjectSettingsGetEvent());
    }
  }

  FutureOr<void> _onDeviceTypeSubmitEvent(
    DeviceTypeSubmitEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    _emitState(emit, ProjectSettingsStateEnum.deviceTypeLoading);
    ProjectSettingsEntity projectSettingsEntity = ProjectSettingsEntity()
      ..deviceTypes = event.deviceTypes;
    _projectSettingsEntity?.deviceTypes = event.deviceTypes;
    await _projectSettingsController.putProjectSettingsData(
      projectSettingsEntity,
    );
    _emitState(
      emit,
      ProjectSettingsStateEnum.success,
      updateEnum: ProjectSettingsStateEnum.updateDeviceType,
    );
  }

  FutureOr<void> _onUnitsSubmitEvent(
    UnitsSubmitEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    _emitState(emit, ProjectSettingsStateEnum.deviceTypeLoading);
    ProjectSettingsEntity projectSettingsEntity = ProjectSettingsEntity()
      ..flow = event.flowQuantity.index
      ..flowRate = event.flowRate.index
      ..flowSensorOutput = event.flowOutput.index
      ..pressure = event.pressureUnit.index
      ..minimumPressure = event.pressureMinValue.toInt()
      ..maximumPressure = event.pressureMaxValue.toInt()
      ..level = event.levelUnit.index
      ..minimumLevel = event.levelMinValue.toInt()
      ..maximumLevel = event.levelMaxValue.toInt()
      ..chlorineSensor = event.chlorineQuantityUnit.index
      ..chlorineSensorOutput = event.chlorineOutputUnit.index
      ..chlorineRangeMin = event.chlorineMinValue.toInt()
      ..chlorineRangeMax = event.chlorineMaxValue.toInt()
      ..flow = event.flowQuantity.index;
    _projectSettingsEntity?.flow = event.flowQuantity.index;
    _projectSettingsEntity?.flowRate = event.flowRate.index;
    _projectSettingsEntity?.flowSensorOutput = event.flowOutput.index;
    _projectSettingsEntity?.pressure = event.pressureUnit.index;
    _projectSettingsEntity?.minimumPressure = event.pressureMinValue.toInt();
    _projectSettingsEntity?.maximumPressure = event.pressureMaxValue.toInt();
    _projectSettingsEntity?.level = event.levelUnit.index;
    _projectSettingsEntity?.minimumLevel = event.levelMinValue.toInt();
    _projectSettingsEntity?.maximumLevel = event.levelMaxValue.toInt();
    _projectSettingsEntity?.chlorineSensor = event.chlorineQuantityUnit.index;
    _projectSettingsEntity?.chlorineSensorOutput =
        event.chlorineOutputUnit.index;
    _projectSettingsEntity?.chlorineRangeMin = event.chlorineMinValue.toInt();
    _projectSettingsEntity?.chlorineRangeMax = event.chlorineMaxValue.toInt();
    await _projectSettingsController.putProjectSettingsData(
      projectSettingsEntity,
    );
    _emitState(
      emit,
      ProjectSettingsStateEnum.success,
      updateEnum: ProjectSettingsStateEnum.updateUnits,
    );
  }

  FutureOr<void> _onAddRoleEvent(
    AddRoleEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    _emitState(emit, ProjectSettingsStateEnum.roleLoading);
    RoleEntity roleEntity = RoleEntity()
      ..name = event.roleName
      ..projectId = _projectSettingsEntity?.id
      ..role = event.roleEnum.index;
    await _projectSettingsController.postRole(roleEntity);
    add(GetRolesEvent(updateEnum: ProjectSettingsStateEnum.updateRoles));
  }

  FutureOr<void> _onGetRolesEvent(
    GetRolesEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    _roleList = await _projectSettingsController.getRoles() ?? <RoleEntity>[];

    _emitState(
      emit,
      ProjectSettingsStateEnum.success,
      updateEnum: event.updateEnum,
    );
  }

  FutureOr<void> _onUpdateRoleEvent(
    UpdateRoleEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    RoleEntity roleEntity = RoleEntity()
      ..name = event.roleName
      ..id = event.roleId
      ..role = event.roleEnum.index;
    await _projectSettingsController.putRole(roleEntity);
    add(GetRolesEvent(updateEnum: ProjectSettingsStateEnum.updateRoles));
  }

  FutureOr<void> _onDeleteRoleEvent(
    DeleteRoleEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    await _projectSettingsController.deleteRole(event.roleId);
    add(GetRolesEvent(updateEnum: ProjectSettingsStateEnum.updateRoles));
  }

  FutureOr<void> _onGetZoneListEvent(
    GetZoneListEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    List<ZoneEntity> zones =
        await _projectSettingsController.getZonesList() ?? <ZoneEntity>[];
    _zoneList = GetIt.I<CommonLogics>().convertZonesToTree(zones);
    _emitState(
      emit,
      ProjectSettingsStateEnum.success,
      updateEnum: event.updateEnum,
    );
  }

  FutureOr<void> _onAddZoneEvent(
    AddZoneEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    _emitState(emit, ProjectSettingsStateEnum.zoneLoading);
    ZoneEntity zoneEntity = ZoneEntity()
      ..name = event.name
      ..level = event.level;
    await _projectSettingsController.addZone(zoneEntity);
    add(GetZoneListEvent(updateEnum: ProjectSettingsStateEnum.updateZones));
  }

  FutureOr<void> _onAddChildSiteEvent(
    AddChildSiteEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    ZoneEntity zoneEntity = ZoneEntity()
      ..name = event.name
      ..projectZoneId = event.parentZoneID;
    await _projectSettingsController.addSite(zoneEntity);
    add(GetZoneListEvent(updateEnum: ProjectSettingsStateEnum.updateZones));
  }

  FutureOr<void> _onAddChildZoneEvent(
    AddChildZoneEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    ZoneEntity zoneEntity = ZoneEntity()
      ..name = event.name
      ..level = event.level
      ..zoneParentId = event.parentZoneID;
    await _projectSettingsController.addZone(zoneEntity);
    add(GetZoneListEvent(updateEnum: ProjectSettingsStateEnum.updateZones));
  }

  FutureOr<void> _onEditChildSiteEvent(
    EditChildSiteEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    ZoneEntity zoneEntity = ZoneEntity()..name = event.name;
    await _projectSettingsController.editSite(zoneEntity, event.parentZoneID);
    add(GetZoneListEvent(updateEnum: ProjectSettingsStateEnum.updateZones));
  }

  FutureOr<void> _onEditChildZoneEvent(
    EditChildZoneEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    ZoneEntity zoneEntity = ZoneEntity()
      ..name = event.name
      ..level = event.level;
    await _projectSettingsController.editZone(zoneEntity, event.parentZoneID);
    add(GetZoneListEvent(updateEnum: ProjectSettingsStateEnum.updateZones));
  }

  FutureOr<void> _onDeleteChildZoneEvent(
    DeleteChildZoneEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    await _projectSettingsController.deleteZone(event.parentZoneID);
    add(GetZoneListEvent(updateEnum: ProjectSettingsStateEnum.updateZones));
  }

  FutureOr<void> _onDeleteChildSiteEvent(
    DeleteChildSiteEvent event,
    Emitter<ProjectSettingsState> emit,
  ) async {
    await _projectSettingsController.deleteSite(event.parentZoneID);
    add(GetZoneListEvent(updateEnum: ProjectSettingsStateEnum.updateZones));
  }
}
