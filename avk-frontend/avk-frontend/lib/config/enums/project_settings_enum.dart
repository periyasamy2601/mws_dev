/// device type enum
enum DeviceTypeEnum{
  ///0
  ohtInlet,
  ///1
  ohtOutlet,
  ///2
  dma,
  ///3
  none,
}
/// device type enum
enum RoleEnum{
  ///0
  admin,
  ///1
  deviceConfiguration,
  ///2
  control,
  ///3
  monitoringAccess,
  /// 4
  none,
  ///5
  error
}
/// device type enum
enum ProjectSettingsStateEnum{
  ///0
  success,
  ///1
  error,
  ///2
  projectSettingsNameLoading,
  ///3
  deviceTypeLoading,
  /// 4
  unitsLoading,
  /// 5
  roleLoading,
  /// 6
  zoneLoading,
  /// 7
  initialLoading,
  /// 8
  updateProjectName,
  ///9
  updateRoles,
  ///10
  updateUnits,
  ///11
  updateZones,
  ///12
  updateDeviceType
}

/// flow quantity enum
enum FlowQuantityEnum {
  ///0
  m3,
  ///1
  liters,
  ///2
  ll,
  ///3
  mld,
  ///4
  kl,
}

/// flow rate unit
enum FlowRateEnum {
  /// 0
  lpm ,
  /// 1
  m3hr ,
  /// 2
  lps ,
  /// 3
  klHr ,
}
/// flow Output
enum FlowOutputEnum {
  /// 0
  mA420 ,
  /// 1
  rs485 ,
  /// 2
  pulse ,
}
/// Pressure Unit
enum PressureUnit {
  /// 0
  bar ,
  /// 1
  kgCm ,
  /// 2
  meter ,
}
/// Level Unit
enum LevelUnit {
  /// 0
  meter ,
  /// 1
  bar ,
  /// 2
  liters ,
}
/// Chlorine-Quantity Unit
enum ChlorineQuantityUnit {
  /// 0
  ppm,

  /// 1
  mgL ,
}
/// Chlorine-Quantity Unit
enum ChlorineOutputUnit {
  /// 0
  mA420 ,
  /// 1
  rs485 ,
}

/// Chlorine-Quantity Unit
enum ProjectSettingsPopupEnum{
  /// 0
  delete ,
  /// 1
  edit ,
  ///2
  addSite,
  ///3
  addZone,
}
