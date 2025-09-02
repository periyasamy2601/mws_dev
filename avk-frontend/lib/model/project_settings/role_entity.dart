import 'package:avk/generated/json/role_entity.g.dart';
import 'package:avk/router/path_exporter.dart';
export 'package:avk/generated/json/role_entity.g.dart';

@JsonSerializable()
class RoleEntity {
	String? id;
	@JSONField(name: "created_at")
	String? createdAt;
	String? name;
	int? role;
	@JSONField(name: "project_id")
	String? projectId;

	RoleEntity();

	factory RoleEntity.fromJson(Map<String, dynamic> json) => $RoleEntityFromJson(json);

	Map<String, dynamic> toJson() => $RoleEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}