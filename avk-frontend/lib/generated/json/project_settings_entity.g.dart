import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/model/project_settings/project_settings_entity.dart';
import 'package:avk/router/path_exporter.dart';


ProjectSettingsEntity $ProjectSettingsEntityFromJson(
    Map<String, dynamic> json) {
  final ProjectSettingsEntity projectSettingsEntity = ProjectSettingsEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    projectSettingsEntity.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    projectSettingsEntity.name = name;
  }
  final List<int>? deviceTypes = (json['device_types'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (deviceTypes != null) {
    projectSettingsEntity.deviceTypes = deviceTypes;
  }
  final int? flow = jsonConvert.convert<int>(json['flow']);
  if (flow != null) {
    projectSettingsEntity.flow = flow;
  }
  final int? flowRate = jsonConvert.convert<int>(json['flow_rate']);
  if (flowRate != null) {
    projectSettingsEntity.flowRate = flowRate;
  }
  final int? flowSensorOutput = jsonConvert.convert<int>(
      json['flow_sensor_output']);
  if (flowSensorOutput != null) {
    projectSettingsEntity.flowSensorOutput = flowSensorOutput;
  }
  final int? pressure = jsonConvert.convert<int>(json['pressure']);
  if (pressure != null) {
    projectSettingsEntity.pressure = pressure;
  }
  final int? minimumPressure = jsonConvert.convert<int>(
      json['minimum_pressure']);
  if (minimumPressure != null) {
    projectSettingsEntity.minimumPressure = minimumPressure;
  }
  final int? maximumPressure = jsonConvert.convert<int>(
      json['maximum_pressure']);
  if (maximumPressure != null) {
    projectSettingsEntity.maximumPressure = maximumPressure;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    projectSettingsEntity.level = level;
  }
  final int? minimumLevel = jsonConvert.convert<int>(json['minimum_level']);
  if (minimumLevel != null) {
    projectSettingsEntity.minimumLevel = minimumLevel;
  }
  final int? maximumLevel = jsonConvert.convert<int>(json['maximum_level']);
  if (maximumLevel != null) {
    projectSettingsEntity.maximumLevel = maximumLevel;
  }
  final int? chlorineSensor = jsonConvert.convert<int>(json['chlorine_sensor']);
  if (chlorineSensor != null) {
    projectSettingsEntity.chlorineSensor = chlorineSensor;
  }
  final int? chlorineSensorOutput = jsonConvert.convert<int>(
      json['chlorine_sensor_output']);
  if (chlorineSensorOutput != null) {
    projectSettingsEntity.chlorineSensorOutput = chlorineSensorOutput;
  }
  final int? chlorineRangeMin = jsonConvert.convert<int>(
      json['chlorine_range_min']);
  if (chlorineRangeMin != null) {
    projectSettingsEntity.chlorineRangeMin = chlorineRangeMin;
  }
  final int? chlorineRangeMax = jsonConvert.convert<int>(
      json['chlorine_range_max']);
  if (chlorineRangeMax != null) {
    projectSettingsEntity.chlorineRangeMax = chlorineRangeMax;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    projectSettingsEntity.status = status;
  }
  return projectSettingsEntity;
}

Map<String, dynamic> $ProjectSettingsEntityToJson(
    ProjectSettingsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['device_types'] = entity.deviceTypes;
  data['flow'] = entity.flow;
  data['flow_rate'] = entity.flowRate;
  data['flow_sensor_output'] = entity.flowSensorOutput;
  data['pressure'] = entity.pressure;
  data['minimum_pressure'] = entity.minimumPressure;
  data['maximum_pressure'] = entity.maximumPressure;
  data['level'] = entity.level;
  data['minimum_level'] = entity.minimumLevel;
  data['maximum_level'] = entity.maximumLevel;
  data['chlorine_sensor'] = entity.chlorineSensor;
  data['chlorine_sensor_output'] = entity.chlorineSensorOutput;
  data['chlorine_range_min'] = entity.chlorineRangeMin;
  data['chlorine_range_max'] = entity.chlorineRangeMax;
  data['status'] = entity.status;
  return data;
}

extension ProjectSettingsEntityExtension on ProjectSettingsEntity {
  ProjectSettingsEntity copyWith({
    String? id,
    String? name,
    List<int>? deviceTypes,
    int? flow,
    int? flowRate,
    int? flowSensorOutput,
    int? pressure,
    int? minimumPressure,
    int? maximumPressure,
    int? level,
    int? minimumLevel,
    int? maximumLevel,
    int? chlorineSensor,
    int? chlorineSensorOutput,
    int? chlorineRangeMin,
    int? chlorineRangeMax,
    int? status,
  }) {
    return ProjectSettingsEntity()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..deviceTypes = deviceTypes ?? this.deviceTypes
      ..flow = flow ?? this.flow
      ..flowRate = flowRate ?? this.flowRate
      ..flowSensorOutput = flowSensorOutput ?? this.flowSensorOutput
      ..pressure = pressure ?? this.pressure
      ..minimumPressure = minimumPressure ?? this.minimumPressure
      ..maximumPressure = maximumPressure ?? this.maximumPressure
      ..level = level ?? this.level
      ..minimumLevel = minimumLevel ?? this.minimumLevel
      ..maximumLevel = maximumLevel ?? this.maximumLevel
      ..chlorineSensor = chlorineSensor ?? this.chlorineSensor
      ..chlorineSensorOutput = chlorineSensorOutput ?? this.chlorineSensorOutput
      ..chlorineRangeMin = chlorineRangeMin ?? this.chlorineRangeMin
      ..chlorineRangeMax = chlorineRangeMax ?? this.chlorineRangeMax
      ..status = status ?? this.status;
  }
}