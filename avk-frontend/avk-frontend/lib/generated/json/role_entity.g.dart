import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/model/project_settings/role_entity.dart';
import 'package:avk/router/path_exporter.dart';


RoleEntity $RoleEntityFromJson(Map<String, dynamic> json) {
  final RoleEntity roleEntity = RoleEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    roleEntity.id = id;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    roleEntity.createdAt = createdAt;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    roleEntity.name = name;
  }
  final int? role = jsonConvert.convert<int>(json['role']);
  if (role != null) {
    roleEntity.role = role;
  }
  final String? projectId = jsonConvert.convert<String>(json['project_id']);
  if (projectId != null) {
    roleEntity.projectId = projectId;
  }
  return roleEntity;
}

Map<String, dynamic> $RoleEntityToJson(RoleEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['created_at'] = entity.createdAt;
  data['name'] = entity.name;
  data['role'] = entity.role;
  data['project_id'] = entity.projectId;
  return data;
}

extension RoleEntityExtension on RoleEntity {
  RoleEntity copyWith({
    String? id,
    String? createdAt,
    String? name,
    int? role,
    String? projectId,
  }) {
    return RoleEntity()
      ..id = id ?? this.id
      ..createdAt = createdAt ?? this.createdAt
      ..name = name ?? this.name
      ..role = role ?? this.role
      ..projectId = projectId ?? this.projectId;
  }
}