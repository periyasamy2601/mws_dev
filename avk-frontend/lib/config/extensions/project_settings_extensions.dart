import 'package:avk/router/path_exporter.dart';

/// Extension methods for [int] to map numeric role indices
/// to corresponding role names and icons.
///
/// This assumes the integer value corresponds to the index
/// of an enum value in [RoleEnum.values].
extension ProjectSettingsIntExtension on int {
  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getChlorineOutputUnitName(BuildContext context) {
    ChlorineOutputUnit chlorineOutputUnit = ChlorineOutputUnit.values[this];
    switch (chlorineOutputUnit) {
      case ChlorineOutputUnit.mA420:
        return context.getText().ma_420;
      case ChlorineOutputUnit.rs485:
        return context.getText().rs_485;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getChlorineQuantityUnitName(BuildContext context) {
    ChlorineQuantityUnit chlorineQuantityUnit = ChlorineQuantityUnit.values[this];
    switch (chlorineQuantityUnit) {
      case ChlorineQuantityUnit.ppm:
        return context.getText().ppm;
      case ChlorineQuantityUnit.mgL:
        return context.getText().mgl;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getPressureUnitName(BuildContext context) {
    PressureUnit pressureUnit = PressureUnit.values[this];
    switch (pressureUnit) {
      case PressureUnit.bar:
        return context.getText().bar;
      case PressureUnit.kgCm:
        return context.getText().kg_cm;
      case PressureUnit.meter:
        return context.getText().meter;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getPressureUnitSymbol(BuildContext context) {
    PressureUnit pressureUnit = PressureUnit.values[this];
    switch (pressureUnit) {
      case PressureUnit.bar:
        return context.getText().bar.toLowerCase();
      case PressureUnit.kgCm:
        return context.getText().kg_cm.toLowerCase();
      case PressureUnit.meter:
        return context.getText().m;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getLevelUnitName(BuildContext context) {
    LevelUnit levelUnit = LevelUnit.values[this];
    switch (levelUnit) {

      case LevelUnit.meter:
         return context.getText().meter;
      case LevelUnit.bar:
         return context.getText().bar;
      case LevelUnit.liters:
         return context.getText().liters;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getLevelUnitSymbol(BuildContext context) {
    LevelUnit levelUnit = LevelUnit.values[this];
    switch (levelUnit) {

      case LevelUnit.meter:
         return context.getText().m;
      case LevelUnit.bar:
         return context.getText().bar.toLowerCase();
      case LevelUnit.liters:
         return context.getText().l;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getFlowOutputName(BuildContext context) {
    FlowOutputEnum flowOutput = FlowOutputEnum.values[this];
    switch (flowOutput) {

      case FlowOutputEnum.mA420:
        return context.getText().ma_420;
      case FlowOutputEnum.rs485:
        return context.getText().rs_485;
      case FlowOutputEnum.pulse:
        return context.getText().pulse;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getFlowRateName(BuildContext context) {
    FlowRateEnum flowRate = FlowRateEnum.values[this];
    switch (flowRate) {

      case FlowRateEnum.lpm:
        return context.getText().lpm;
      case FlowRateEnum.m3hr:
        return context.getText().m3_hr;
      case FlowRateEnum.lps:
        return context.getText().lps;
      case FlowRateEnum.klHr:
        return context.getText().kl_hr;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getFlowQuantityName(BuildContext context) {
    FlowQuantityEnum flowQuantity = FlowQuantityEnum.values[this];
    switch (flowQuantity) {
      case FlowQuantityEnum.m3:
         return context.getText().m3;
      case FlowQuantityEnum.liters:
         return context.getText().liters;
      case FlowQuantityEnum.ll:
         return context.getText().ll;
      case FlowQuantityEnum.mld:
         return context.getText().mld;
      case FlowQuantityEnum.kl:
         return context.getText().kl;
    }
  }

  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  String getRoleName(BuildContext context) {
    RoleEnum roleEnum = RoleEnum.values[this];
    switch (roleEnum) {
      case RoleEnum.admin:
        return context.getText().admin;
      case RoleEnum.deviceConfiguration:
        return context.getText().device_configuration;
      case RoleEnum.control:
        return context.getText().control;
      case RoleEnum.monitoringAccess:
        return context.getText().monitoring_access;
      case RoleEnum.none:
      case RoleEnum.error:
        throw UnimplementedError();
    }
  }

  /// Returns the corresponding role icon widget based on the
  /// integer's [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleIcon(); // Returns Admin role icon widget
  /// ```
  Widget getRoleIcon() {
    RoleEnum roleEnum = RoleEnum.values[this];
    switch (roleEnum) {
      case RoleEnum.admin:
        return appSvg.projectSettingsAdminIcon;
      case RoleEnum.deviceConfiguration:
        return appSvg.projectSettingsDeviceConfigurationIcon;
      case RoleEnum.control:
        return appSvg.projectSettingsControlIcon;
      case RoleEnum.monitoringAccess:
        return appSvg.projectSettingsMonitoringAccessIcon;
      case RoleEnum.none:
      case RoleEnum.error:
        throw UnimplementedError();
    }
  }
}
