import 'package:avk/generated/json/user_pagination_entity.g.dart';
import 'package:avk/model/user_management/user_entity.dart';
import 'package:avk/router/path_exporter.dart';

export 'package:avk/generated/json/user_pagination_entity.g.dart';

/// Represents a paginated response of users.
///
/// Typically returned by APIs that support pagination
/// for user management endpoints.
@JsonSerializable()
class UserPaginationEntity {

	/// Default constructor.
	UserPaginationEntity();

	/// Creates a [UserPaginationEntity] instance from a JSON map.
	factory UserPaginationEntity.fromJson(Map<String, dynamic> json) =>
			$UserPaginationEntityFromJson(json);
	/// Total number of users available (for pagination).
	int? total;

	/// List of users for the current page.
	List<UserEntity>? users;

	/// Converts this [UserPaginationEntity] instance into a JSON map.
	Map<String, dynamic> toJson() => $UserPaginationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
