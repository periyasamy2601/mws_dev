import 'package:avk/router/path_exporter.dart';

/// A central Dependency Injection (DI) configuration class.
///
/// This class is responsible for initializing and registering
/// global dependencies like services, helpers, and storage classes.
class DI with Endpoints {
  /// Creates a new instance of [DI].
  ///
  /// Use this to initialize and register all application-wide dependencies.
  DI();

  /// The global GetIt instance for dependency management.
  final GetIt getIt = GetIt.instance;

  /// Registers singleton instances of common classes and initializes them.
  ///
  /// This method:
  /// - Calls [init] to set up API endpoints.
  /// - Registers [LocalStorage] and [RouteHelper] as singletons.
  /// - Initializes [LocalStorage].
  ///
  /// Wraps the setup in a try-catch block to log any initialization errors.
  Future<void> setupDependencies() async {
    final GetIt getIt = GetIt.instance;

    try {
      init(); // API endpoint setup
      if (!getIt.isRegistered<LocalStorage>()) {
        getIt.registerSingleton<LocalStorage>(LocalStorage());
      }

      if (!getIt.isRegistered<RouteHelper>()) {
        getIt.registerSingleton<RouteHelper>(RouteHelper());
      }

      if (!getIt.isRegistered<AppConstants>()) {
        getIt.registerSingleton<AppConstants>(const AppConstants());
      }

      if (!getIt.isRegistered<DialogHelper>()) {
        getIt.registerSingleton<DialogHelper>( DialogHelper());
      }

      if (!getIt.isRegistered<CommonLogics>()) {
        getIt.registerSingleton<CommonLogics>( CommonLogics());
      }

      await getIt<LocalStorage>().init();
    } on Object catch (e) {
      logger.errorLog('----Initialize Error ---->  $e');
    }
  }
}
