import 'package:avk/generated/json/base/json_convert_content.dart';
import 'package:avk/core/model/error_data_entity.dart';
import 'package:avk/router/path_exporter.dart';


ErrorDataEntity $ErrorDataEntityFromJson(Map<String, dynamic> json) {
  final ErrorDataEntity errorDataEntity = ErrorDataEntity();
  final int? statusCode = jsonConvert.convert<int>(json['statusCode']);
  if (statusCode != null) {
    errorDataEntity.statusCode = statusCode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    errorDataEntity.name = name;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    errorDataEntity.message = message;
  }
  final List<ErrorDetails>? details = (json['details'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ErrorDetails>(e) as ErrorDetails).toList();
  if (details != null) {
    errorDataEntity.details = details;
  }
  return errorDataEntity;
}

Map<String, dynamic> $ErrorDataEntityToJson(ErrorDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['statusCode'] = entity.statusCode;
  data['name'] = entity.name;
  data['message'] = entity.message;
  data['details'] = entity.details?.map((v) => v.toJson()).toList();
  return data;
}

extension ErrorDataEntityExtension on ErrorDataEntity {
  ErrorDataEntity copyWith({
    int? statusCode,
    String? name,
    String? message,
    List<ErrorDetails>? details,
  }) {
    return ErrorDataEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..name = name ?? this.name
      ..message = message ?? this.message
      ..details = details ?? this.details;
  }
}

ErrorDetails $ErrorDetailsFromJson(Map<String, dynamic> json) {
  final ErrorDetails errorDetails = ErrorDetails();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    errorDetails.message = message;
  }
  return errorDetails;
}

Map<String, dynamic> $ErrorDetailsToJson(ErrorDetails entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  return data;
}

extension ErrorDetailsExtension on ErrorDetails {
  ErrorDetails copyWith({
    String? message,
  }) {
    return ErrorDetails()
      ..message = message ?? this.message;
  }
}