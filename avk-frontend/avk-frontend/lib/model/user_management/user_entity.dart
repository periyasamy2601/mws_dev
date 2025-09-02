import 'package:avk/generated/json/user_entity.g.dart';
import 'package:avk/router/path_exporter.dart';

export 'package:avk/generated/json/user_entity.g.dart';

/// Represents a user within the system.
///
/// This entity is JSON-serializable and is typically used
/// when parsing API responses or serializing requests.
@JsonSerializable()
class UserEntity {

	/// Default constructor.
	UserEntity();

	/// Creates a [UserEntity] instance from a JSON map.
	factory UserEntity.fromJson(Map<String, dynamic> json) =>
			$UserEntityFromJson(json);
	/// Whether the user has been deleted.
	bool? deleted;

	/// Timestamp when the user was deleted (if applicable).
	dynamic deletedOn;

	/// Identifier of the user who performed the deletion.
	dynamic deletedBy;

	/// Unique identifier of the user.
	String? id;

	/// Timestamp when the user was created.
	@JSONField(name: 'created_at')
	String? createdAt;

	/// Timestamp when the user was last updated.
	@JSONField(name: 'updated_at')
	String? updatedAt;

	/// First name of the user.
	@JSONField(name: 'first_name')
	String? firstName;

	/// Last name of the user.
	@JSONField(name: 'last_name')
	String? lastName;

	/// Name of the organization the user belongs to.
	@JSONField(name: 'organisation_name')
	String? organisationName;

	/// Designation/job title of the user.
	String? designation;

	/// Country code associated with the user (e.g., +91).
	@JSONField(name: 'country_code')
	String? countryCode;

	/// Country number associated with the user.
	@JSONField(name: 'country_number')
	int? countryNumber;

	/// Mobile number of the user.
	@JSONField(name: 'mobile_number')
	int? mobileNumber;

	/// Email address of the user.
	String? email;

	/// Role identifier of the user.
	@JSONField(name: 'project_role_id')
	String? projectRoleId;

	/// Role identifier of the user either user or admin.
	int? role;

	/// Role identifier of the user Role.
	String? roleName;

	/// Status of the user (e.g., active/inactive).
	int? status;

	/// password
	String? password;

	/// is loading
	bool? isLoading;

	/// Converts this [UserEntity] instance into a JSON map.
	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
