import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/model/user_management/user_pagination_entity.dart';
import 'package:avk/model/user_management/user_entity.dart';

import 'package:avk/router/path_exporter.dart';


UserPaginationEntity $UserPaginationEntityFromJson(Map<String, dynamic> json) {
  final UserPaginationEntity userPaginationEntity = UserPaginationEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    userPaginationEntity.total = total;
  }
  final List<UserEntity>? users = (json['users'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<UserEntity>(e) as UserEntity).toList();
  if (users != null) {
    userPaginationEntity.users = users;
  }
  return userPaginationEntity;
}

Map<String, dynamic> $UserPaginationEntityToJson(UserPaginationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['users'] = entity.users?.map((v) => v.toJson()).toList();
  return data;
}

extension UserPaginationEntityExtension on UserPaginationEntity {
  UserPaginationEntity copyWith({
    int? total,
    List<UserEntity>? users,
  }) {
    return UserPaginationEntity()
      ..total = total ?? this.total
      ..users = users ?? this.users;
  }
}