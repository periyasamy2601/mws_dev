import 'package:avk/router/path_exporter.dart';

/// multi bloc providers contains all the bloc init's
class BlocProviders {
  /// providers list
  List<SingleChildWidget> blocProviders = <SingleChildWidget>[
    BlocProvider<ProjectSettingsBloc>(
      create: (BuildContext context) => ProjectSettingsBloc(ProjectSettingsController()),
    ),
    BlocProvider<UserManagementBloc>(
      create: (BuildContext context) => UserManagementBloc(UserManagementController()),
    ),
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(AuthController()),
    ),
    BlocProvider<ReportsBloc>(create: (BuildContext context) => ReportsBloc()),
    BlocProvider<NoInternetBloc>(create: (BuildContext context) => NoInternetBloc()),
    BlocProvider<TreeViewCubit>(create: (BuildContext context) => TreeViewCubit()),
    BlocProvider<FilterCubit>(create: (BuildContext context) => FilterCubit()),
    BlocProvider<ConfigBloc>(create: (BuildContext context) => ConfigBloc()),
  ];
}
