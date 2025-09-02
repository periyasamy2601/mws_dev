import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/model/config_entity.dart';

ConfigEntity $ConfigEntityFromJson(Map<String, dynamic> json) {
  final ConfigEntity configEntity = ConfigEntity();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    configEntity.name = name;
  }
  final String? projectRoleId = jsonConvert.convert<String>(
      json['project_role_id']);
  if (projectRoleId != null) {
    configEntity.projectRoleId = projectRoleId;
  }
  final int? role = jsonConvert.convert<int>(json['role']);
  if (role != null) {
    configEntity.role = role;
  }
  final String? projectId = jsonConvert.convert<String>(json['project_id']);
  if (projectId != null) {
    configEntity.projectId = projectId;
  }
  final bool? isZoneExist = jsonConvert.convert<bool>(json['is_zone_exist']);
  if (isZoneExist != null) {
    configEntity.isZoneExist = isZoneExist;
  }
  final bool? isProjectRoleExist = jsonConvert.convert<bool>(
      json['is_project_role_exist']);
  if (isProjectRoleExist != null) {
    configEntity.isProjectRoleExist = isProjectRoleExist;
  }
  return configEntity;
}

Map<String, dynamic> $ConfigEntityToJson(ConfigEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['project_role_id'] = entity.projectRoleId;
  data['role'] = entity.role;
  data['project_id'] = entity.projectId;
  data['is_zone_exist'] = entity.isZoneExist;
  data['is_project_role_exist'] = entity.isProjectRoleExist;
  return data;
}

extension ConfigEntityExtension on ConfigEntity {
  ConfigEntity copyWith({
    String? name,
    String? projectRoleId,
    int? role,
    String? projectId,
    bool? isZoneExist,
    bool? isProjectRoleExist,
  }) {
    return ConfigEntity()
      ..name = name ?? this.name
      ..projectRoleId = projectRoleId ?? this.projectRoleId
      ..role = role ?? this.role
      ..projectId = projectId ?? this.projectId
      ..isZoneExist = isZoneExist ?? this.isZoneExist
      ..isProjectRoleExist = isProjectRoleExist ?? this.isProjectRoleExist;
  }
}