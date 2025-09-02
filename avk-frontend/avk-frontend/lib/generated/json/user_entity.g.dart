import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/model/user_management/user_entity.dart';
import 'package:avk/router/path_exporter.dart';


UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final bool? deleted = jsonConvert.convert<bool>(json['deleted']);
  if (deleted != null) {
    userEntity.deleted = deleted;
  }
  final dynamic deletedOn = json['deletedOn'];
  if (deletedOn != null) {
    userEntity.deletedOn = deletedOn;
  }
  final dynamic deletedBy = json['deletedBy'];
  if (deletedBy != null) {
    userEntity.deletedBy = deletedBy;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userEntity.id = id;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    userEntity.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    userEntity.updatedAt = updatedAt;
  }
  final String? firstName = jsonConvert.convert<String>(json['first_name']);
  if (firstName != null) {
    userEntity.firstName = firstName;
  }
  final String? lastName = jsonConvert.convert<String>(json['last_name']);
  if (lastName != null) {
    userEntity.lastName = lastName;
  }
  final String? organisationName = jsonConvert.convert<String>(
      json['organisation_name']);
  if (organisationName != null) {
    userEntity.organisationName = organisationName;
  }
  final String? designation = jsonConvert.convert<String>(json['designation']);
  if (designation != null) {
    userEntity.designation = designation;
  }
  final String? countryCode = jsonConvert.convert<String>(json['country_code']);
  if (countryCode != null) {
    userEntity.countryCode = countryCode;
  }
  final int? countryNumber = jsonConvert.convert<int>(json['country_number']);
  if (countryNumber != null) {
    userEntity.countryNumber = countryNumber;
  }
  final int? mobileNumber = jsonConvert.convert<int>(json['mobile_number']);
  if (mobileNumber != null) {
    userEntity.mobileNumber = mobileNumber;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    userEntity.email = email;
  }
  final String? projectRoleId = jsonConvert.convert<String>(
      json['project_role_id']);
  if (projectRoleId != null) {
    userEntity.projectRoleId = projectRoleId;
  }
  final int? role = jsonConvert.convert<int>(json['role']);
  if (role != null) {
    userEntity.role = role;
  }
  final String? roleName = jsonConvert.convert<String>(json['roleName']);
  if (roleName != null) {
    userEntity.roleName = roleName;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    userEntity.status = status;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    userEntity.password = password;
  }
  final bool? isLoading = jsonConvert.convert<bool>(json['isLoading']);
  if (isLoading != null) {
    userEntity.isLoading = isLoading;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['deleted'] = entity.deleted;
  data['deletedOn'] = entity.deletedOn;
  data['deletedBy'] = entity.deletedBy;
  data['id'] = entity.id;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['first_name'] = entity.firstName;
  data['last_name'] = entity.lastName;
  data['organisation_name'] = entity.organisationName;
  data['designation'] = entity.designation;
  data['country_code'] = entity.countryCode;
  data['country_number'] = entity.countryNumber;
  data['mobile_number'] = entity.mobileNumber;
  data['email'] = entity.email;
  data['project_role_id'] = entity.projectRoleId;
  data['role'] = entity.role;
  data['roleName'] = entity.roleName;
  data['status'] = entity.status;
  data['password'] = entity.password;
  data['isLoading'] = entity.isLoading;
  return data;
}

extension UserEntityExtension on UserEntity {
  UserEntity copyWith({
    bool? deleted,
    dynamic deletedOn,
    dynamic deletedBy,
    String? id,
    String? createdAt,
    String? updatedAt,
    String? firstName,
    String? lastName,
    String? organisationName,
    String? designation,
    String? countryCode,
    int? countryNumber,
    int? mobileNumber,
    String? email,
    String? projectRoleId,
    int? role,
    String? roleName,
    int? status,
    String? password,
    bool? isLoading,
  }) {
    return UserEntity()
      ..deleted = deleted ?? this.deleted
      ..deletedOn = deletedOn ?? this.deletedOn
      ..deletedBy = deletedBy ?? this.deletedBy
      ..id = id ?? this.id
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..firstName = firstName ?? this.firstName
      ..lastName = lastName ?? this.lastName
      ..organisationName = organisationName ?? this.organisationName
      ..designation = designation ?? this.designation
      ..countryCode = countryCode ?? this.countryCode
      ..countryNumber = countryNumber ?? this.countryNumber
      ..mobileNumber = mobileNumber ?? this.mobileNumber
      ..email = email ?? this.email
      ..projectRoleId = projectRoleId ?? this.projectRoleId
      ..role = role ?? this.role
      ..roleName = roleName ?? this.roleName
      ..status = status ?? this.status
      ..password = password ?? this.password
      ..isLoading = isLoading ?? this.isLoading;
  }
}