import 'package:avk/generated/json/error_data_entity.g.dart';
import 'package:avk/router/path_exporter.dart';

/// Represents the error response structure received from an API.
@JsonSerializable()
class ErrorDataEntity {
  /// Default constructor for [ErrorDataEntity].
  ErrorDataEntity();

  /// Creates an instance of [ErrorDataEntity] from a JSON map.
  factory ErrorDataEntity.fromJson(Map<String, dynamic> json) =>
      $ErrorDataEntityFromJson(json);

  /// Converts the [ErrorDataEntity] instance into a JSON map.
  Map<String, dynamic> toJson() => $ErrorDataEntityToJson(this);

  /// HTTP status code returned by the API.
  @JSONField(name: 'statusCode')
  int? statusCode;

  /// Name/type of the error.
  @JSONField(name: 'name')
  String? name;

  /// Detailed message describing the error.
  @JSONField(name: 'message')
  String? message;

  /// A list of additional error details if available.
  @JSONField(name: 'details')
  List<ErrorDetails>? details;
}

/// Represents a single error message detail, often found in a list.
@JsonSerializable()
class ErrorDetails {
  /// Default constructor for [ErrorDetails].
  ErrorDetails();

  /// Creates an instance of [ErrorDetails] from a JSON map.
  factory ErrorDetails.fromJson(Map<String, dynamic> json) =>
      $ErrorDetailsFromJson(json);

  /// Converts the [ErrorDetails] instance into a JSON map.
  Map<String, dynamic> toJson() => $ErrorDetailsToJson(this);

  /// Specific message providing detail about an individual error.
  @JSONField(name: 'message')
  String? message;
}
