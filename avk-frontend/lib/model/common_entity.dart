import 'package:avk/generated/json/common_entity.g.dart';
import 'package:avk/router/path_exporter.dart';

export 'package:avk/generated/json/common_entity.g.dart';

/// Represents a common entity used across multiple API responses.
///
/// This class can be extended or reused where
/// only a password field or simple entity is required.
@JsonSerializable()
class CommonEntity {

	/// Default constructor.
	CommonEntity();

	/// Creates a [CommonEntity] instance from a JSON map.
	factory CommonEntity.fromJson(Map<String, dynamic> json) =>
			$CommonEntityFromJson(json);
	/// The password associated with this entity.
	String? password;
	/// The user id associated with this entity.
	@JSONField(name: 'user_id')
	String? userId;

	/// reset password status status i.e `RegisterEnum`
	int? status;

	/// registration status i.e `RegisterEnum`
	@JSONField(name: 'register_status')
	int? registerStatus;


	/// token for authentication
	String? token;

	/// Converts this [CommonEntity] instance into a JSON map.
	Map<String, dynamic> toJson() => $CommonEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
