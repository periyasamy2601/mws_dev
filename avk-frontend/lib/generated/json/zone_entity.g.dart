import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/model/project_settings/zone_entity.dart';
import 'package:avk/router/path_exporter.dart';


ZoneEntity $ZoneEntityFromJson(Map<String, dynamic> json) {
  final ZoneEntity zoneEntity = ZoneEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    zoneEntity.id = id;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    zoneEntity.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    zoneEntity.updatedAt = updatedAt;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    zoneEntity.name = name;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    zoneEntity.level = level;
  }
  final String? zoneParentId = jsonConvert.convert<String>(
      json['zone_parent_id']);
  if (zoneParentId != null) {
    zoneEntity.zoneParentId = zoneParentId;
  }
  final String? projectId = jsonConvert.convert<String>(json['project_id']);
  if (projectId != null) {
    zoneEntity.projectId = projectId;
  }
  final String? projectZoneId = jsonConvert.convert<String>(
      json['project_zone_id']);
  if (projectZoneId != null) {
    zoneEntity.projectZoneId = projectZoneId;
  }
  final List<ZoneChildren>? children = (json['children'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ZoneChildren>(e) as ZoneChildren)
      .toList();
  if (children != null) {
    zoneEntity.children = children;
  }
  final List<ZoneChildrenSites>? sites = (json['sites'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ZoneChildrenSites>(e) as ZoneChildrenSites)
      .toList();
  if (sites != null) {
    zoneEntity.sites = sites;
  }
  final bool? isMapped = jsonConvert.convert<bool>(json['isMapped']);
  if (isMapped != null) {
    zoneEntity.isMapped = isMapped;
  }
  return zoneEntity;
}

Map<String, dynamic> $ZoneEntityToJson(ZoneEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['name'] = entity.name;
  data['level'] = entity.level;
  data['zone_parent_id'] = entity.zoneParentId;
  data['project_id'] = entity.projectId;
  data['project_zone_id'] = entity.projectZoneId;
  data['children'] = entity.children?.map((v) => v.toJson()).toList();
  data['sites'] = entity.sites?.map((v) => v.toJson()).toList();
  data['isMapped'] = entity.isMapped;
  return data;
}

extension ZoneEntityExtension on ZoneEntity {
  ZoneEntity copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? name,
    int? level,
    String? zoneParentId,
    String? projectId,
    String? projectZoneId,
    List<ZoneChildren>? children,
    List<ZoneChildrenSites>? sites,
    bool? isMapped,
  }) {
    return ZoneEntity()
      ..id = id ?? this.id
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..name = name ?? this.name
      ..level = level ?? this.level
      ..zoneParentId = zoneParentId ?? this.zoneParentId
      ..projectId = projectId ?? this.projectId
      ..projectZoneId = projectZoneId ?? this.projectZoneId
      ..children = children ?? this.children
      ..sites = sites ?? this.sites
      ..isMapped = isMapped ?? this.isMapped;
  }
}

ZoneChildren $ZoneChildrenFromJson(Map<String, dynamic> json) {
  final ZoneChildren zoneChildren = ZoneChildren();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    zoneChildren.id = id;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    zoneChildren.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    zoneChildren.updatedAt = updatedAt;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    zoneChildren.name = name;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    zoneChildren.level = level;
  }
  final String? zoneParentId = jsonConvert.convert<String>(
      json['zone_parent_id']);
  if (zoneParentId != null) {
    zoneChildren.zoneParentId = zoneParentId;
  }
  final String? projectId = jsonConvert.convert<String>(json['project_id']);
  if (projectId != null) {
    zoneChildren.projectId = projectId;
  }
  final List<ZoneChildren>? children = (json['children'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ZoneChildren>(e) as ZoneChildren)
      .toList();
  if (children != null) {
    zoneChildren.children = children;
  }
  final List<ZoneChildrenSites>? sites = (json['sites'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ZoneChildrenSites>(e) as ZoneChildrenSites)
      .toList();
  if (sites != null) {
    zoneChildren.sites = sites;
  }
  final bool? isMapped = jsonConvert.convert<bool>(json['isMapped']);
  if (isMapped != null) {
    zoneChildren.isMapped = isMapped;
  }
  return zoneChildren;
}

Map<String, dynamic> $ZoneChildrenToJson(ZoneChildren entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['name'] = entity.name;
  data['level'] = entity.level;
  data['zone_parent_id'] = entity.zoneParentId;
  data['project_id'] = entity.projectId;
  data['children'] = entity.children?.map((v) => v.toJson()).toList();
  data['sites'] = entity.sites?.map((v) => v.toJson()).toList();
  data['isMapped'] = entity.isMapped;
  return data;
}

extension ZoneChildrenExtension on ZoneChildren {
  ZoneChildren copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? name,
    int? level,
    String? zoneParentId,
    String? projectId,
    List<ZoneChildren>? children,
    List<ZoneChildrenSites>? sites,
    bool? isMapped,
  }) {
    return ZoneChildren()
      ..id = id ?? this.id
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..name = name ?? this.name
      ..level = level ?? this.level
      ..zoneParentId = zoneParentId ?? this.zoneParentId
      ..projectId = projectId ?? this.projectId
      ..children = children ?? this.children
      ..sites = sites ?? this.sites
      ..isMapped = isMapped ?? this.isMapped;
  }
}

ZoneChildrenSites $ZoneChildrenSitesFromJson(Map<String, dynamic> json) {
  final ZoneChildrenSites zoneChildrenSites = ZoneChildrenSites();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    zoneChildrenSites.id = id;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    zoneChildrenSites.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    zoneChildrenSites.updatedAt = updatedAt;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    zoneChildrenSites.name = name;
  }
  final String? projectZoneId = jsonConvert.convert<String>(
      json['project_zone_id']);
  if (projectZoneId != null) {
    zoneChildrenSites.projectZoneId = projectZoneId;
  }
  final bool? isMapped = jsonConvert.convert<bool>(json['isMapped']);
  if (isMapped != null) {
    zoneChildrenSites.isMapped = isMapped;
  }
  return zoneChildrenSites;
}

Map<String, dynamic> $ZoneChildrenSitesToJson(ZoneChildrenSites entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['name'] = entity.name;
  data['project_zone_id'] = entity.projectZoneId;
  data['isMapped'] = entity.isMapped;
  return data;
}

extension ZoneChildrenSitesExtension on ZoneChildrenSites {
  ZoneChildrenSites copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? projectZoneId,
    bool? isMapped,
  }) {
    return ZoneChildrenSites()
      ..id = id ?? this.id
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..name = name ?? this.name
      ..projectZoneId = projectZoneId ?? this.projectZoneId
      ..isMapped = isMapped ?? this.isMapped;
  }
}