import 'package:avk/router/path_exporter.dart';

/// A view widget that displays the **Project Settings** screen.
///
/// This widget is stateful because the project settings may change
/// based on user interaction (e.g., toggles, inputs, dropdowns).
class ProjectSettingsView extends StatefulWidget {
  /// Creates a [ProjectSettingsView].
  ///
  /// The optional [key] can be used to control the widget’s identity
  /// in the widget tree.
  const ProjectSettingsView({super.key});

  @override
  State<ProjectSettingsView> createState() => _ProjectSettingsViewState();
}

class _ProjectSettingsViewState extends State<ProjectSettingsView> {
  final GlobalKey<FormState> _unitFormKey = GlobalKey<FormState>();

  // Form controller and validation key for project name
  final TextEditingController _projectNameController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  /// ---------------------------- units keys ---------------------------------
  final ValueNotifier<ChooseUnitsModel> _unitsNotifier =
      ValueNotifier<ChooseUnitsModel>(ChooseUnitsModel());
  final GlobalKey<FormFieldState<dynamic>> _projectNameKey =
      GlobalKey<FormFieldState<dynamic>>();

  final TextEditingController _pressureMinRangeController =
      TextEditingController();
  final TextEditingController _pressureMaxRangeController =
      TextEditingController();
  final TextEditingController _levelMinRangeController =
      TextEditingController();
  final TextEditingController _levelMaxRangeController =
      TextEditingController();
  final TextEditingController _chlorineMinRangeController =
      TextEditingController();
  final TextEditingController _chlorineMaxRangeController =
      TextEditingController();

  // Device type selection notifier
  final ValueNotifier<List<DeviceTypeEnum>> _deviceTypeMultiNotifier =
      ValueNotifier<List<DeviceTypeEnum>>(<DeviceTypeEnum>[]);
  bool _showDeviceTypeError = false;

  // Role-related notifiers
  final ValueNotifier<RoleEnum> _roleTypeNotifier = ValueNotifier<RoleEnum>(
    RoleEnum.none,
  );
  final ValueNotifier<bool> _roleExpansionNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<List<RoleEntity>> _roleListNotifier =
      ValueNotifier<List<RoleEntity>>(<RoleEntity>[]);

  // Zone-related notifiers
  final ValueNotifier<bool> _zoneExpansionNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<List<TreeNode<UserName>>> _zoneListNotifier =
      ValueNotifier<List<TreeNode<UserName>>>(<TreeNode<UserName>>[]);

  // Hardcoded zone list for display

  // Bloc for handling settings logic
  late ProjectSettingsBloc _settingsBloc;

  @override
  void initState() {
    _settingsBloc = BlocProvider.of(context)..add(ProjectSettingsGetEvent());

    // Set expansion defaults based on content
    _roleExpansionNotifier.value = _roleListNotifier.value.isNotEmpty;
    _zoneExpansionNotifier.value = _zoneListNotifier.value.isNotEmpty;

    super.initState();
  }

  @override
  void dispose() {
    _pressureMinRangeController.dispose();
    _levelMinRangeController.dispose();
    _levelMaxRangeController.dispose();
    _chlorineMinRangeController.dispose();
    _chlorineMaxRangeController.dispose();
    _unitFormKey.currentState?.dispose();
    _pressureMaxRangeController.dispose();
    _projectNameController.dispose();
    _unitsNotifier.dispose();
    _projectNameKey.currentState?.dispose();
    _deviceTypeMultiNotifier.dispose();
    _roleTypeNotifier.dispose();
    _roleListNotifier.dispose();
    _roleExpansionNotifier.dispose();
    _zoneListNotifier.dispose();
    _zoneExpansionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectSettingsBloc, ProjectSettingsState>(
      listener: (BuildContext context, ProjectSettingsState state) {
        if (state is ProjectSettingsResponseState &&
            state.stateEnum == ProjectSettingsStateEnum.success) {
          _handleSuccess(state);
        }
      },
      builder: (BuildContext context, ProjectSettingsState state) {

        return DashboardScaffold(
            scrollController: _scrollController,
          isLoading: !(state is ProjectSettingsResponseState && state.stateEnum != ProjectSettingsStateEnum.initialLoading),
          child: _bodyView(state),
        );
      },
    );
  }

  Widget _bodyView(ProjectSettingsState state){
    if (state is ProjectSettingsResponseState &&
        state.stateEnum != ProjectSettingsStateEnum.initialLoading) {
      return Column(
        spacing: dimensions.spacingM,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(context),
          _buildProjectNameSelector(state),
          const BaseDivider(),
          FadeAndDisableWrapper(
            isFade: state.projectSettingsEntity?.id?.isEmpty ?? true,
            isDisable: (state.projectSettingsEntity?.id?.isEmpty ?? true) ||
                state.stateEnum != ProjectSettingsStateEnum.success,
            child: Column(
              spacing: dimensions.spacingM,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildDeviceTypeSelector(state),
                const BaseDivider(),
                _buildUnitsSection(state),
                const BaseDivider(),
                _buildRoleSection(state),
                const BaseDivider(),
                _buildZoneSection(state),
              ],
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }

  void _handleSuccess(ProjectSettingsResponseState state) {
    if (state.updateEnum == ProjectSettingsStateEnum.updateProjectName) {
      _updateProjectName(state);
    } else if (state.updateEnum == ProjectSettingsStateEnum.updateDeviceType) {
      _updateDeviceType(state);
    } else if (state.updateEnum == ProjectSettingsStateEnum.updateUnits) {
      _updateUnits(state);
    } else if (state.updateEnum == ProjectSettingsStateEnum.updateRoles) {
      _updateRole(state);
    } else if (state.updateEnum == ProjectSettingsStateEnum.updateZones) {
      _updateZone(state);
    } else {
      _updateProjectName(state);
      _updateDeviceType(state);
      _updateUnits(state);
      _updateRole(state);
      _updateZone(state);
    }
  }

  void _updateZone(ProjectSettingsResponseState state) {
    _zoneListNotifier.value = state.zoneList;
    _zoneExpansionNotifier.value = _zoneListNotifier.value.isNotEmpty;
  }

  void _updateRole(ProjectSettingsResponseState state) {
    _roleListNotifier.value = state.roleList;
    _roleExpansionNotifier.value = _roleListNotifier.value.isNotEmpty;
  }

  void _updateProjectName(ProjectSettingsResponseState state) {
    _projectNameController.text = state.projectSettingsEntity?.name ?? '';
  }

  void _updateDeviceType(ProjectSettingsResponseState state) {
    _deviceTypeMultiNotifier.value =
        (state.projectSettingsEntity?.deviceTypes ?? <int>[])
            .map((int index) => DeviceTypeEnum.values[index])
            .toList();
  }

  void _updateUnits(ProjectSettingsResponseState state) {
    _unitsNotifier.value = ChooseUnitsModel(
      flowOutputEnum: FlowOutputEnum
          .values[state.projectSettingsEntity?.flowSensorOutput ?? 0],
      flowRateEnum:
          FlowRateEnum.values[state.projectSettingsEntity?.flowRate ?? 0],
      flowQuantityEnum:
          FlowQuantityEnum.values[state.projectSettingsEntity?.flow ?? 0],
      pressureUnit:
          PressureUnit.values[state.projectSettingsEntity?.pressure ?? 0],
      levelUnit: LevelUnit.values[state.projectSettingsEntity?.level ?? 0],
      chlorineQuantityUnit: ChlorineQuantityUnit
          .values[state.projectSettingsEntity?.chlorineSensor ?? 0],
      chlorineOutputUnit: ChlorineOutputUnit
          .values[state.projectSettingsEntity?.chlorineSensorOutput ?? 0],
    );
    _pressureMinRangeController.text =
        (state.projectSettingsEntity?.minimumPressure ?? 0).toString();
    _pressureMaxRangeController.text =
        (state.projectSettingsEntity?.maximumPressure ?? 25).toString();
    _levelMinRangeController.text =
        (state.projectSettingsEntity?.minimumLevel ?? 0).toString();
    _levelMaxRangeController.text =
        (state.projectSettingsEntity?.maximumLevel ?? 9).toString();
    _chlorineMinRangeController.text =
        (state.projectSettingsEntity?.chlorineRangeMin ?? 0).toString();
    _chlorineMaxRangeController.text =
        (state.projectSettingsEntity?.chlorineRangeMax ?? 20).toString();
  }

  /// Header with page title
  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _headerTextBuilder(context.getText().project_settings),
      ],
    );
  }

  /// Project name input with submit button
  Widget _buildProjectNameInput(ProjectSettingsResponseState state) {
    return BaseTextFormField(
      formKey: _projectNameKey,
      isSmall: true,
      label: context.getText().project_name,
      editingController: _projectNameController,
      validator: (String? val) =>
          validationHelper.projectSettingsNameValidator(val, context),
      inputFormatters: regexHelper.projectNameFormatters,
      maxLength: appConstants.fieldLimit50,
    );
  }

  Widget _buildProjectNameSelector(ProjectSettingsResponseState state) {
    return Column(
      spacing: dimensions.spacingM,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _subHeaderTextBuilder(context.getText().project_details),
            PrimaryAppButton(
              key: const Key('project_details_submit_button'),
              isLoading:
                  state.stateEnum ==
                  ProjectSettingsStateEnum.projectSettingsNameLoading,
              isSmall: true,
              buttonLabel: context.getText().submit,
              onButtonTap: _onProjectNameTap,
            ),
          ],
        ),
        _buildProjectNameInput(state),
      ],
    );
  }

  /// Device type checkbox with error handling and submit
  Widget _buildDeviceTypeSelector(ProjectSettingsResponseState state) {
    return Column(
      spacing: dimensions.spacingM,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _headerTextBuilder(context.getText().device_type),
            PrimaryAppButton(
              isLoading:
                  state.stateEnum == ProjectSettingsStateEnum.deviceTypeLoading,
              isSmall: true,
              buttonLabel: context.getText().submit,
              onButtonTap: _onDeviceSubmitTap,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BaseCheckBoxWidget<DeviceTypeEnum>(
              valueNotifier: _deviceTypeMultiNotifier,
              options: const <DeviceTypeEnum>[
                DeviceTypeEnum.ohtInlet,
                DeviceTypeEnum.ohtOutlet,
                DeviceTypeEnum.dma,
              ],
              noneValue: DeviceTypeEnum.none,
              isMultiSelect: true,
              labelBuilder: (DeviceTypeEnum type) {
                switch (type) {
                  case DeviceTypeEnum.ohtInlet:
                    return context.getText().oht_inlet;
                  case DeviceTypeEnum.ohtOutlet:
                    return context.getText().oht_outlet;
                  case DeviceTypeEnum.dma:
                    return context.getText().dma;
                  case DeviceTypeEnum.none:
                    return '';
                }
              },
            ),
            ValueListenableBuilder<List<DeviceTypeEnum>>(
              valueListenable: _deviceTypeMultiNotifier,
              builder: (BuildContext context, List<DeviceTypeEnum> value, _) {
                return Visibility(
                  visible: value.isEmpty && _showDeviceTypeError,
                  child: Text(
                    context.getText().please_select_device_type,
                    style: context.getStyle().bodySmall?.copyWith(
                      color: context.getColor().error,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Role list with expansion, role cards, and add button
  Widget _buildUnitsSection(ProjectSettingsResponseState state) {
    return ValueListenableBuilder<ChooseUnitsModel>(
      valueListenable: _unitsNotifier,
      builder: (BuildContext context, ChooseUnitsModel units, Widget? child) {
        return Form(
          key: _unitFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: dimensions.spacingM,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _headerTextBuilder(context.getText().choose_units),
                  PrimaryAppButton(
                    key: const Key('units_submit_button'),
                    isLoading:
                        state.stateEnum ==
                        ProjectSettingsStateEnum.unitsLoading,
                    buttonLabel: context.getText().submit,
                    isSmall: true,
                    onButtonTap: _onChooseUnitsTap,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: dimensions.spacingS,
                children: <Widget>[
                  _subHeaderTextBuilder(context.getText().flow_sensor),
                  Wrap(
                    spacing: dimensions.spacingS,
                    runSpacing: dimensions.spacingS,
                    children: <Widget>[
                      EnumDropdown<FlowQuantityEnum>(
                        items: FlowQuantityEnum.values,
                        selectedItem: units.flowQuantityEnum,
                        onChanged: _onFlowQuantityChanged,
                        itemLabelBuilder: (FlowQuantityEnum item) =>
                            item.index.getFlowQuantityName(context),
                        headerLabelBuilder: (FlowQuantityEnum item) =>
                            item.index.getFlowQuantityName(context),
                        hintText: context.getText().flow_quantity,
                      ),
                      EnumDropdown<FlowRateEnum>(
                        items: FlowRateEnum.values,
                        selectedItem: units.flowRateEnum,
                        onChanged: _onFlowRateChanged,
                        itemLabelBuilder: (FlowRateEnum item) =>
                            item.index.getFlowRateName(context),
                        headerLabelBuilder: (FlowRateEnum item) =>
                            item.index.getFlowRateName(context),
                        hintText: context.getText().flow_rate,
                      ),
                      EnumDropdown<FlowOutputEnum>(
                        items: FlowOutputEnum.values,
                        selectedItem: units.flowOutputEnum,
                        onChanged: _onFlowOutputChanged,
                        itemLabelBuilder: (FlowOutputEnum item) =>
                            item.index.getFlowOutputName(context),
                        headerLabelBuilder: (FlowOutputEnum item) =>
                            item.index.getFlowOutputName(context),
                        hintText: context.getText().output,
                      ),
                    ],
                  ),
                  _subHeaderTextBuilder(
                    context.getText().pressure_sensor,
                    subTitle: context.getText().output_4_20_ma,
                  ),
                  Wrap(
                    spacing: dimensions.spacingS,
                    runSpacing: dimensions.spacingS,
                    children: <Widget>[
                      EnumDropdown<PressureUnit>(
                        items: PressureUnit.values,
                        selectedItem: units.pressureUnit,
                        onChanged: _onPressureUnitChanged,
                        itemLabelBuilder: (PressureUnit item) =>
                            item.index.getPressureUnitName(context),
                        headerLabelBuilder: (PressureUnit item) =>
                            item.index.getPressureUnitName(context),
                        hintText: context.getText().pressure,
                      ),
                      BaseTextFormField(
                        key: const Key('pressure_min_range'),
                        isExtraSmall: true,
                        label: context.getText().minimum_range,
                        editingController: _pressureMinRangeController,
                        validator: (String? val) =>
                            validationHelper.pressureMinValidator(
                              val,
                              context,
                              _pressureMaxRangeController.text,
                            ),
                        inputFormatters:
                            regexHelper.projectSettingsPressureMinMaxFormatters,
                        suffixText: units.pressureUnit.index
                            .getPressureUnitSymbol(context),
                      ),
                      BaseTextFormField(
                        key: const Key('pressure_max_range'),
                        isExtraSmall: true,
                        label: context.getText().maximum_range,
                        editingController: _pressureMaxRangeController,
                        validator: (String? val) =>
                            validationHelper.pressureMaxValidator(
                              val,
                              context,
                              _pressureMinRangeController.text,
                            ),
                        inputFormatters:
                            regexHelper.projectSettingsPressureMinMaxFormatters,
                        suffixText: units.pressureUnit.index
                            .getPressureUnitSymbol(context),
                      ),
                    ],
                  ),
                  _subHeaderTextBuilder(
                    context.getText().level_sensor,
                    subTitle: context.getText().output_4_20_ma,
                  ),
                  Wrap(
                    spacing: dimensions.spacingS,
                    runSpacing: dimensions.spacingS,
                    children: <Widget>[
                      EnumDropdown<LevelUnit>(
                        items: LevelUnit.values,
                        selectedItem: units.levelUnit,
                        onChanged: _onLevelUnitChanged,
                        itemLabelBuilder: (LevelUnit item) =>
                            item.index.getLevelUnitName(context),
                        headerLabelBuilder: (LevelUnit item) =>
                            item.index.getLevelUnitName(context),
                        hintText: context.getText().level,
                      ),
                      BaseTextFormField(
                        key: const Key('level_min_range'),
                        isExtraSmall: true,
                        label: context.getText().minimum_range,
                        editingController: _levelMinRangeController,
                        validator: (String? val) =>
                            validationHelper.pressureMinValidator(
                              val,
                              context,
                              _levelMaxRangeController.text,
                            ),
                        inputFormatters: regexHelper
                            .projectSettingsMinMaxFormatters(),
                        suffixText: units.levelUnit.index.getLevelUnitSymbol(
                          context,
                        ),
                      ),
                      BaseTextFormField(
                        key: const Key('level_max_range'),
                        isExtraSmall: true,
                        label: context.getText().maximum_range,
                        editingController: _levelMaxRangeController,
                        validator: (String? val) =>
                            validationHelper.pressureMaxValidator(
                              val,
                              context,
                              _levelMinRangeController.text,
                            ),
                        inputFormatters: regexHelper
                            .projectSettingsMinMaxFormatters(),
                        suffixText: units.levelUnit.index.getLevelUnitSymbol(
                          context,
                        ),
                      ),
                    ],
                  ),
                  _subHeaderTextBuilder(
                    context.getText().residual_chlorine_sensor,
                  ),
                  Wrap(
                    spacing: dimensions.spacingS,
                    runSpacing: dimensions.spacingS,
                    children: <Widget>[
                      EnumDropdown<ChlorineQuantityUnit>(
                        items: ChlorineQuantityUnit.values,
                        selectedItem: units.chlorineQuantityUnit,
                        onChanged: _onChlorineQuantityUnitChanged,
                        itemLabelBuilder: (ChlorineQuantityUnit item) =>
                            item.index.getChlorineQuantityUnitName(context),
                        headerLabelBuilder: (ChlorineQuantityUnit item) =>
                            item.index.getChlorineQuantityUnitName(context),
                        hintText: context.getText().chlorine_quantity,
                      ),
                      EnumDropdown<ChlorineOutputUnit>(
                        items: ChlorineOutputUnit.values,
                        selectedItem: units.chlorineOutputUnit,
                        onChanged: _onChlorineOutputUnitChanged,
                        itemLabelBuilder: (ChlorineOutputUnit item) =>
                            item.index.getChlorineOutputUnitName(context),
                        headerLabelBuilder: (ChlorineOutputUnit item) =>
                            item.index.getChlorineOutputUnitName(context),
                        hintText: context.getText().output,
                      ),
                      BaseTextFormField(
                        key: const Key('chlorine_min_range'),
                        isExtraSmall: true,
                        label: context.getText().minimum_range,
                        editingController: _chlorineMinRangeController,
                        validator: (String? val) =>
                            validationHelper.pressureMinValidator(
                              val,
                              context,
                              _chlorineMaxRangeController.text,
                            ),
                        inputFormatters: regexHelper
                            .projectSettingsMinMaxFormatters(maxValue: 20),
                        suffixText: units.chlorineQuantityUnit.index
                            .getChlorineQuantityUnitName(context),
                      ),
                      BaseTextFormField(
                        key: const Key('chlorine_max_range'),
                        isExtraSmall: true,
                        label: context.getText().maximum_range,
                        editingController: _chlorineMaxRangeController,
                        validator: (String? val) =>
                            validationHelper.pressureMaxValidator(
                              val,
                              context,
                              _chlorineMinRangeController.text,
                            ),
                        inputFormatters: regexHelper
                            .projectSettingsMinMaxFormatters(maxValue: 20),
                        suffixText: units.chlorineQuantityUnit.index
                            .getChlorineQuantityUnitName(context),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Role list with expansion, role cards, and add button
  Widget _buildRoleSection(ProjectSettingsResponseState state) {
    return RoleSection(
      roleExpansionNotifier: _roleExpansionNotifier,
      roleListNotifier: _roleListNotifier,
      onAddRoleTap: _onAddRoleTap,
      headerWidget: _headerTextBuilder(context.getText().add_role),
      loader: state.stateEnum == ProjectSettingsStateEnum.roleLoading,
      onEditTap: _onEditRoleTap,
      onDeleteTap: (RoleEntity role) async {
        await dialogHelper.showDeletePopup(
          context.getText().delete_role,
          context,
          () {
            _settingsBloc.add(DeleteRoleEvent(roleId: role.id ?? ''));
          },
          subtitle: context.getText().delete_role_message,
        );
      },
    );
  }

  Future<void> _onEditRoleTap(RoleEntity role) async {
    _roleTypeNotifier.value = RoleEnum.values[role.role ?? 0];
    await dialogHelper.showAddRoleDialog(
      context,
      (String roleName) {
        _settingsBloc.add(
          UpdateRoleEvent(
            roleName: roleName,
            roleEnum: _roleTypeNotifier.value,
            roleId: role.id!,
          ),
        );
        _roleTypeNotifier.value = RoleEnum.none;
      },
      _roleTypeNotifier,
      roleName: role.name,
    );
  }

  /// Zones section with expansion and zone tree
  Widget _buildZoneSection(ProjectSettingsResponseState state) {
    return ZoneSection(
      scrollController: _scrollController,
      zoneExpansionNotifier: _zoneExpansionNotifier,
      zoneListNotifier: _zoneListNotifier,
      onAddZoneTap: _onAddZoneTap,
      headerWidget: _headerTextBuilder(context.getText().add_zone),
      loader: state.stateEnum == ProjectSettingsStateEnum.zoneLoading,
      onAddChildZoneTap: _onAddChildZoneTap,
      onAddChildSiteTap: _onAddChildSiteTap,
      addChildDeleteTap: _onAddChildDeleteTap,
      addChildEditTap: _onAddChildEditTap,
    );
  }

  /// Styled header with optional error text
  Widget _headerTextBuilder(String label, {String? errorText}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: context.getStyle().headlineLarge,
        children: <InlineSpan>[
          if (errorText != null)
            TextSpan(
              text: '\t($errorText)',
              style: context.getStyle().bodySmall?.copyWith(
                color: context.getColor().error,
              ),
            ),
        ],
      ),
    );
  }

  Widget _subHeaderTextBuilder(String label, {String? subTitle}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: context.getStyle().titleMedium,
        children: <InlineSpan>[
          if (subTitle != null)
            TextSpan(
              text: '\t($subTitle)',
              style: context.getStyle().bodyMedium,
            ),
        ],
      ),
    );
  }

  // === Event Handlers ===

  void _onProjectNameTap() {
    if (_projectNameKey.currentState?.validate() ?? false) {
      _settingsBloc.add(
        ProjectNameSubmitEvent(projectName: _projectNameController.text.trim()),
      );
    }
  }

  void _onDeviceSubmitTap() {
    if (_deviceTypeMultiNotifier.value.isEmpty) {
      _showDeviceTypeError = true;
      _deviceTypeMultiNotifier.value = <DeviceTypeEnum>[]; // Triggers UI update
    } else {
      _showDeviceTypeError = false;
      _settingsBloc.add(
        DeviceTypeSubmitEvent(
          deviceTypes: _deviceTypeMultiNotifier.value
              .map((DeviceTypeEnum e) => e.index)
              .toList(),
        ),
      );
    }
  }

  Future<void> _onAddRoleTap() async {
    _roleTypeNotifier.value = RoleEnum.none;
    await dialogHelper.showAddRoleDialog(context, (String roleName) {
      _settingsBloc.add(
        AddRoleEvent(roleName: roleName, roleEnum: _roleTypeNotifier.value),
      );
      _roleTypeNotifier.value = RoleEnum.none;
    }, _roleTypeNotifier);
  }

  Future<void> _onAddZoneTap() async {
    await dialogHelper.showAddRoleZoneDialog(context, (String zoneName) {
      _settingsBloc.add(AddZoneEvent(name: zoneName, level: 0));
    });
  }

  Future<void> _onAddChildZoneTap(TreeNode<UserName> p1) async {
    await dialogHelper.showAddRoleZoneDialog(context, (String zoneName) {
      _settingsBloc.add(
        AddChildZoneEvent(
          name: zoneName,
          level: p1.level,
          parentZoneID: p1.key,
        ),
      );
    });
  }

  Future<void> _onAddChildSiteTap(TreeNode<UserName> p1) async {
    await dialogHelper.showAddRoleZoneDialog(context, (String zoneName) {
      _settingsBloc.add(
        AddChildSiteEvent(name: zoneName, parentZoneID: p1.key),
      );
    }, isSite: true);
  }

  void _onChooseUnitsTap() {
    if (_unitFormKey.currentState?.validate() ?? false) {
      _settingsBloc.add(
        UnitsSubmitEvent(
          flowQuantity: _unitsNotifier.value.flowQuantityEnum,
          flowRate: _unitsNotifier.value.flowRateEnum,
          flowOutput: _unitsNotifier.value.flowOutputEnum,
          pressureUnit: _unitsNotifier.value.pressureUnit,
          pressureMinValue: _pressureMinRangeController.text,
          pressureMaxValue: _pressureMaxRangeController.text,
          levelUnit: _unitsNotifier.value.levelUnit,
          levelMinValue: _levelMinRangeController.text,
          levelMaxValue: _levelMaxRangeController.text,
          chlorineQuantityUnit: _unitsNotifier.value.chlorineQuantityUnit,
          chlorineOutputUnit: _unitsNotifier.value.chlorineOutputUnit,
          chlorineMinValue: _chlorineMinRangeController.text,
          chlorineMaxValue: _chlorineMaxRangeController.text,
        ),
      );
    }
  }

  void _onFlowQuantityChanged(FlowQuantityEnum? p1) {
    if (p1 != null) {
      ChooseUnitsModel data = _unitsNotifier.value.copyWith(
        flowQuantityEnum: p1,
      );
      _unitsNotifier.value = data;
    }
  }

  void _onFlowRateChanged(FlowRateEnum? p1) {
    if (p1 != null) {
      ChooseUnitsModel data = _unitsNotifier.value.copyWith(flowRateEnum: p1);
      _unitsNotifier.value = data;
    }
  }

  void _onFlowOutputChanged(FlowOutputEnum? p1) {
    if (p1 != null) {
      ChooseUnitsModel data = _unitsNotifier.value.copyWith(flowOutputEnum: p1);
      _unitsNotifier.value = data;
    }
  }

  void _onPressureUnitChanged(PressureUnit? p1) {
    if (p1 != null) {
      ChooseUnitsModel data = _unitsNotifier.value.copyWith(pressureUnit: p1);
      _unitsNotifier.value = data;
    }
  }

  void _onLevelUnitChanged(LevelUnit? p1) {
    if (p1 != null) {
      ChooseUnitsModel data = _unitsNotifier.value.copyWith(levelUnit: p1);
      _unitsNotifier.value = data;
    }
  }

  void _onChlorineQuantityUnitChanged(ChlorineQuantityUnit? p1) {
    if (p1 != null) {
      ChooseUnitsModel data = _unitsNotifier.value.copyWith(
        chlorineQuantityUnit: p1,
      );
      _unitsNotifier.value = data;
    }
  }

  void _onChlorineOutputUnitChanged(ChlorineOutputUnit? p1) {
    if (p1 != null) {
      ChooseUnitsModel data = _unitsNotifier.value.copyWith(
        chlorineOutputUnit: p1,
      );
      _unitsNotifier.value = data;
    }
  }

  void _onAddChildDeleteTap(TreeNode<UserName> site) {
    if (site.data.description.isNotEmpty) {
      unawaited(
        dialogHelper.showDeletePopup(
          context.getText().delete_site,
          context,
          () {
            _settingsBloc.add(DeleteChildSiteEvent(parentZoneID: site.key));
          },
          subtitle: context.getText().delete_site_content,
        ),
      );
    } else {
      unawaited(
        dialogHelper.showDeletePopup(
          context.getText().delete_zone,
          context,
          () {
            _settingsBloc.add(
              DeleteChildZoneEvent(level: site.level, parentZoneID: site.key),
            );
          },
          subtitle: context.getText().delete_zone_content,
        ),
      );
    }
  }

  Future<void> _onAddChildEditTap(TreeNode<UserName> zone) async {
    if (zone.data.description.isNotEmpty) {
      await dialogHelper.showAddRoleZoneDialog(
        context,
        (String zoneName) {
          _settingsBloc.add(
            EditChildSiteEvent(name: zoneName, parentZoneID: zone.key),
          );
        },
        name: zone.data.name,
        isSite: true,
      );
    } else {
      await dialogHelper.showAddRoleZoneDialog(context, (String zoneName) {
        _settingsBloc.add(
          EditChildZoneEvent(
            name: zoneName,
            level: zone.level,
            parentZoneID: zone.key,
          ),
        );
      }, name: zone.data.name);
    }
  }
}

/// Model class to hold selected units for various measurements.
///
/// Provides default values for each unit type and a convenient
/// [copyWith] method to create updated instances.
class ChooseUnitsModel {
  /// Creates a [ChooseUnitsModel] with optional overrides.
  ///
  /// Defaults:
  /// - [flowQuantityEnum] → [FlowQuantityEnum.liters]
  /// - [flowRateEnum] → [FlowRateEnum.lpm]
  /// - [flowOutputEnum] → [FlowOutputEnum.pulse]
  /// - [pressureUnit] → [PressureUnit.bar]
  /// - [levelUnit] → [LevelUnit.meter]
  /// - [chlorineQuantityUnit] → [ChlorineQuantityUnit.ppm]
  /// - [chlorineOutputUnit] → [ChlorineOutputUnit.mA420]
  ChooseUnitsModel({
    this.flowQuantityEnum = FlowQuantityEnum.liters,
    this.flowRateEnum = FlowRateEnum.lpm,
    this.flowOutputEnum = FlowOutputEnum.pulse,
    this.pressureUnit = PressureUnit.bar,
    this.levelUnit = LevelUnit.meter,
    this.chlorineQuantityUnit = ChlorineQuantityUnit.ppm,
    this.chlorineOutputUnit = ChlorineOutputUnit.mA420,
  });

  /// Unit used for measuring flow quantity.
  FlowQuantityEnum flowQuantityEnum;

  /// Unit used for measuring flow rate.
  FlowRateEnum flowRateEnum;

  /// Unit used for representing flow output.
  FlowOutputEnum flowOutputEnum;

  /// Unit used for measuring pressure.
  PressureUnit pressureUnit;

  /// Unit used for measuring levels (e.g., height, depth).
  LevelUnit levelUnit;

  /// Unit used for measuring chlorine quantity.
  ChlorineQuantityUnit chlorineQuantityUnit;

  /// Unit used for representing chlorine output.
  ChlorineOutputUnit chlorineOutputUnit;

  /// Creates a copy of this [ChooseUnitsModel] with updated values.
  ///
  /// If a parameter is not provided, the current value is retained.
  ChooseUnitsModel copyWith({
    FlowQuantityEnum? flowQuantityEnum,
    FlowRateEnum? flowRateEnum,
    FlowOutputEnum? flowOutputEnum,
    PressureUnit? pressureUnit,
    LevelUnit? levelUnit,
    ChlorineQuantityUnit? chlorineQuantityUnit,
    ChlorineOutputUnit? chlorineOutputUnit,
  }) {
    return ChooseUnitsModel(
      flowQuantityEnum: flowQuantityEnum ?? this.flowQuantityEnum,
      flowRateEnum: flowRateEnum ?? this.flowRateEnum,
      flowOutputEnum: flowOutputEnum ?? this.flowOutputEnum,
      pressureUnit: pressureUnit ?? this.pressureUnit,
      levelUnit: levelUnit ?? this.levelUnit,
      chlorineQuantityUnit: chlorineQuantityUnit ?? this.chlorineQuantityUnit,
      chlorineOutputUnit: chlorineOutputUnit ?? this.chlorineOutputUnit,
    );
  }
}
