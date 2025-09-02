import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/model/common_entity.dart';
import 'package:avk/router/path_exporter.dart';


CommonEntity $CommonEntityFromJson(Map<String, dynamic> json) {
  final CommonEntity commonEntity = CommonEntity();
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    commonEntity.password = password;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    commonEntity.userId = userId;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    commonEntity.status = status;
  }
  final int? registerStatus = jsonConvert.convert<int>(json['register_status']);
  if (registerStatus != null) {
    commonEntity.registerStatus = registerStatus;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    commonEntity.token = token;
  }
  return commonEntity;
}

Map<String, dynamic> $CommonEntityToJson(CommonEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['password'] = entity.password;
  data['user_id'] = entity.userId;
  data['status'] = entity.status;
  data['register_status'] = entity.registerStatus;
  data['token'] = entity.token;
  return data;
}

extension CommonEntityExtension on CommonEntity {
  CommonEntity copyWith({
    String? password,
    String? userId,
    int? status,
    int? registerStatus,
    String? token,
  }) {
    return CommonEntity()
      ..password = password ?? this.password
      ..userId = userId ?? this.userId
      ..status = status ?? this.status
      ..registerStatus = registerStatus ?? this.registerStatus
      ..token = token ?? this.token;
  }
}