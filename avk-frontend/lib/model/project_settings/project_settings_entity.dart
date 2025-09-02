import 'package:avk/generated/json/project_settings_entity.g.dart';
import 'package:avk/router/path_exporter.dart';

/// Represents the settings for a project, including flow,
/// pressure, level, and chlorine sensor configurations.
@JsonSerializable()
class ProjectSettingsEntity {

	/// Default constructor for [ProjectSettingsEntity].
	ProjectSettingsEntity();

	/// Creates an instance from a JSON object.
	factory ProjectSettingsEntity.fromJson(Map<String, dynamic> json) =>
			$ProjectSettingsEntityFromJson(json);
	/// The id of the project.
	String? id;
	/// The name of the project.
	String? name;

	/// List of device type IDs associated with the project.
	@JSONField(name: 'device_types')
	List<int>? deviceTypes;

	/// Flow value configuration.
	int? flow;

	/// Flow rate value.
	@JSONField(name: 'flow_rate')
	int? flowRate;

	/// Flow sensor output type.
	@JSONField(name: 'flow_sensor_output')
	int? flowSensorOutput;

	/// Pressure value.
	int? pressure;

	/// Minimum pressure allowed.
	@JSONField(name: 'minimum_pressure')
	int? minimumPressure;

	/// Maximum pressure allowed.
	@JSONField(name: 'maximum_pressure')
	int? maximumPressure;

	/// Level value.
	int? level;

	/// Minimum level allowed.
	@JSONField(name: 'minimum_level')
	int? minimumLevel;

	/// Maximum level allowed.
	@JSONField(name: 'maximum_level')
	int? maximumLevel;

	/// Chlorine sensor type.
	@JSONField(name: 'chlorine_sensor')
	int? chlorineSensor;

	/// Chlorine sensor output type.
	@JSONField(name: 'chlorine_sensor_output')
	int? chlorineSensorOutput;

	/// Minimum allowed chlorine range.
	@JSONField(name: 'chlorine_range_min')
	int? chlorineRangeMin;

	/// Maximum allowed chlorine range.
	@JSONField(name: 'chlorine_range_max')
	int? chlorineRangeMax;

	/// Status of the project settings.
	int? status;

	/// Converts the object to a JSON map.
	Map<String, dynamic> toJson() => $ProjectSettingsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
