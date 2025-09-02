import 'package:avk/router/path_exporter.dart';

export 'package:avk/generated/json/zone_entity.g.dart';

/// Represents a zone entity that may contain child zones and sites.
@JsonSerializable()
class ZoneEntity {
  /// Default constructor for [ZoneEntity].
  ZoneEntity();

  /// Creates a new [ZoneEntity] instance from a JSON object.
  factory ZoneEntity.fromJson(Map<String, dynamic> json) =>
      $ZoneEntityFromJson(json);

  /// Unique identifier of the zone.
  String? id;

  /// The creation timestamp of the zone.
  @JSONField(name: 'created_at')
  String? createdAt;

  /// The last updated timestamp of the zone.
  @JSONField(name: 'updated_at')
  String? updatedAt;

  /// The name of the zone.
  String? name;

  /// The hierarchical level of the zone.
  int? level;

  /// ID of the parent zone, if any.
  @JSONField(name: 'zone_parent_id')
  String? zoneParentId;

  /// ID of the project this zone is associated with.
  @JSONField(name: 'project_id')
  String? projectId;

  /// ID of the project this zone is associated with.
  @JSONField(name: 'project_zone_id')
  String? projectZoneId;

  /// List of child zones under this zone.
  List<ZoneChildren>? children;

  /// List of sites associated with this zone.
  List<ZoneChildrenSites>? sites;

  /// boolean value is mapped for filters
  bool? isMapped;

  /// Converts the [ZoneEntity] instance to a JSON object.
  Map<String, dynamic> toJson() => $ZoneEntityToJson(this);

  @override
  String toString() => jsonEncode(this);
}

/// Represents a child zone, which can also have its own children and sites.
@JsonSerializable()
class ZoneChildren {
  /// Default constructor for [ZoneChildren].
  ZoneChildren();

  /// Creates a new [ZoneChildren] instance from a JSON object.
  factory ZoneChildren.fromJson(Map<String, dynamic> json) =>
      $ZoneChildrenFromJson(json);

  /// Unique identifier of the child zone.
  String? id;

  /// The creation timestamp of the child zone.
  @JSONField(name: 'created_at')
  String? createdAt;

  /// The last updated timestamp of the child zone.
  @JSONField(name: 'updated_at')
  String? updatedAt;

  /// The name of the child zone.
  String? name;

  /// The hierarchical level of the child zone.
  int? level;

  /// ID of the parent zone.
  @JSONField(name: 'zone_parent_id')
  String? zoneParentId;

  /// ID of the project associated with this child zone.
  @JSONField(name: 'project_id')
  String? projectId;

  /// List of nested child zones under this child zone.
  List<ZoneChildren>? children;

  /// List of sites associated with this child zone.
  List<ZoneChildrenSites>? sites;

  /// boolean value is mapped for filters
  bool? isMapped;

  /// Converts the [ZoneChildren] instance to a JSON object.
  Map<String, dynamic> toJson() => $ZoneChildrenToJson(this);

  @override
  String toString() => jsonEncode(this);
}

/// Represents a site that belongs to a specific zone or child zone.
@JsonSerializable()
class ZoneChildrenSites {
  /// Default constructor for [ZoneChildrenSites].
  ZoneChildrenSites();

  /// Creates a new [ZoneChildrenSites] instance from a JSON object.
  factory ZoneChildrenSites.fromJson(Map<String, dynamic> json) =>
      $ZoneChildrenSitesFromJson(json);

  /// Unique identifier of the site.
  String? id;

  /// The creation timestamp of the site.
  @JSONField(name: 'created_at')
  String? createdAt;

  /// The last updated timestamp of the site.
  @JSONField(name: 'updated_at')
  String? updatedAt;

  /// The name of the site.
  String? name;

  /// ID of the project zone that this site belongs to.
  @JSONField(name: 'project_zone_id')
  String? projectZoneId;

  /// boolean value is mapped for filters
  bool? isMapped;

  /// Converts the [ZoneChildrenSites] instance to a JSON object.
  Map<String, dynamic> toJson() => $ZoneChildrenSitesToJson(this);

  @override
  String toString() => jsonEncode(this);
}
