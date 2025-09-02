import 'package:avk/controller/config_controller.dart';
import 'package:avk/router/path_exporter.dart';

part 'config_event.dart';
part 'config_state.dart';

/// BLoC that handles fetching and managing [ConfigEntity] data.
///
/// Listens for [ConfigEvent]s and updates the [ConfigState]
/// accordingly to manage loading, success, and error states.
class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  /// Creates a [ConfigBloc] with an initial [ConfigInitial] state.
  ConfigBloc() : super(ConfigInitial()) {
    on<GetConfigEvent>(_onGetConfigEvent);
  }

  /// Stores the most recent [ConfigEntity] after a successful fetch.
  ConfigEntity? configEntity;

  final ConfigController _configController = ConfigController();

  /// Handles [GetConfigEvent] by calling the [ConfigController],
  /// emitting loading, success, or error states depending on result.
  FutureOr<void> _onGetConfigEvent(
    GetConfigEvent event,
    Emitter<ConfigState> emit,
  ) async {
    configEntity = await _configController.getConfigController();
    emit(ConfigInitial());
  }
}
