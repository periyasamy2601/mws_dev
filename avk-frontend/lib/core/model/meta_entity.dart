import 'package:avk/generated/json/meta_entity.g.dart';
import 'package:avk/router/path_exporter.dart';

/// Represents the metadata structure typically included in API responses.
@JsonSerializable()
class MetaEntity {
  /// Default constructor for [MetaEntity].
  MetaEntity();

  /// Factory constructor to create a [MetaEntity] instance from a JSON map.
  factory MetaEntity.fromJson(Map<String, dynamic> json) => $MetaEntityFromJson(json);

  /// Converts the [MetaEntity] instance to a JSON map.
  Map<String, dynamic> toJson() => $MetaEntityToJson(this);

  /// HTTP status code returned by the API (e.g., 200, 400).
  @JSONField(name: 'status_code')
  int? statusCode;

  /// Optional message from the API, typically for success or error description.
  @JSONField(name: 'message')
  String? message;

  /// Optional authentication token or session token, if applicable.
  @JSONField(name: 'token')
  String? token;

  /// Optional data field that may contain additional response data.
  @JSONField(name: 'data')
  dynamic data;

  /// Optional error object containing detailed error information.
  @JSONField(name: 'error')
  ErrorDataEntity? error;
}
