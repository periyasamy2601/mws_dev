import 'dart:ui';
import 'package:avk/router/path_exporter.dart';

/// class my app
class MyApp extends StatefulWidget {
  /// constructor
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders().blocProviders,
      child: MaterialApp(
        title: F.title,
        // Hides the debug banner in the UI.
        debugShowCheckedModeBanner: false,
        navigatorKey: GetIt
            .instance<RouteHelper>()
            .navigatorKey,
        navigatorObservers: <NavigatorObserver>[routeTracker],
        theme: getLightTheme(context),
        locale: const Locale('en'),
        // List of supported languages.
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          // The localization delegate for translated strings.
          S.delegate,
          // Material design localization.
          GlobalMaterialLocalizations.delegate,
          // Widgets localization.
          GlobalWidgetsLocalizations.delegate,
          // Cupertino widgets localization.
          GlobalCupertinoLocalizations.delegate,
        ],
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          dragDevices: <PointerDeviceKind>{
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
          },
        ),
        initialRoute: BaseRouter().initialRoute(),
        onGenerateRoute: BaseRouter().generateRoute,
        builder: (BuildContext context, Widget? child) {
          /// Obtain the current media query information to manage the layout
          /// and make sure text scaling is consistent.
          final MediaQueryData mediaQueryData = MediaQuery.of(context);
          return MediaQuery(
            // Override text scale factor for the whole subtree to ensure
            // consistent scaling behavior.
            data: mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
            child: child!,
          );
        },
      ),
    );
  }
}
