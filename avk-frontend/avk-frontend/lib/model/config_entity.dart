import 'package:avk/generated/json/config_entity.g.dart';
import 'package:avk/router/path_exporter.dart';

export 'package:avk/generated/json/config_entity.g.dart';

/// Represents the configuration settings of a project.
///
/// This entity is typically used to hold information about
/// project roles, project IDs, and feature existence flags
/// (like whether zones or project roles exist).
@JsonSerializable()
class ConfigEntity {

	/// Default constructor.
	ConfigEntity();

	/// Creates a [ConfigEntity] from a JSON map.
	factory ConfigEntity.fromJson(Map<String, dynamic> json) =>
			$ConfigEntityFromJson(json);
	/// The name of the configuration or project.
	String? name;

	/// The role ID associated with the project.
	@JSONField(name: 'project_role_id')
	String? projectRoleId;

	/// The numeric role identifier.
	int? role;

	/// The unique identifier of the project.
	@JSONField(name: 'project_id')
	String? projectId;

	/// Whether the zone exists for this project.
	@JSONField(name: 'is_zone_exist')
	bool? isZoneExist;

	/// Whether the project role exists.
	@JSONField(name: 'is_project_role_exist')
	bool? isProjectRoleExist;

	/// Converts this [ConfigEntity] into a JSON map.
	Map<String, dynamic> toJson() => $ConfigEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
