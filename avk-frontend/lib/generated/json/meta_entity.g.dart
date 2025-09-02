import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/core/model/meta_entity.dart';
import 'package:avk/router/path_exporter.dart';


MetaEntity $MetaEntityFromJson(Map<String, dynamic> json) {
  final MetaEntity metaEntity = MetaEntity();
  final int? statusCode = jsonConvert.convert<int>(json['status_code']);
  if (statusCode != null) {
    metaEntity.statusCode = statusCode;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    metaEntity.message = message;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    metaEntity.token = token;
  }
  final dynamic data = json['data'];
  if (data != null) {
    metaEntity.data = data;
  }
  final ErrorDataEntity? error = jsonConvert.convert<ErrorDataEntity>(
      json['error']);
  if (error != null) {
    metaEntity.error = error;
  }
  return metaEntity;
}

Map<String, dynamic> $MetaEntityToJson(MetaEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['message'] = entity.message;
  data['token'] = entity.token;
  data['data'] = entity.data;
  data['error'] = entity.error?.toJson();
  return data;
}

extension MetaEntityExtension on MetaEntity {
  MetaEntity copyWith({
    int? statusCode,
    String? message,
    String? token,
    dynamic data,
    ErrorDataEntity? error,
  }) {
    return MetaEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..message = message ?? this.message
      ..token = token ?? this.token
      ..data = data ?? this.data
      ..error = error ?? this.error;
  }
}