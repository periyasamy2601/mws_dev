import 'package:avk/router/path_exporter.dart';

/// light theme configurations
ThemeData getLightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    primaryColor: Colors.indigo[500],
    scaffoldBackgroundColor: Colors.white,
    cardColor: const Color(0xffffffff),
    dividerColor: Colors.blueGrey[600],
    dividerTheme: DividerThemeData(
      color: Colors.blueGrey[600],
      thickness: 0.5
    ),

    radioTheme: const RadioThemeData(

    ),
    expansionTileTheme: const ExpansionTileThemeData(

    ),
    // highlightColor: Colors.indigo[500],
    // splashColor: Colors.indigo[50],
    fontFamily: 'HelveticaNeue',
    iconTheme: IconThemeData(
      color: Colors.indigo[500],
      size: 30,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.indigo[500],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo[50],
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo[500]!,
      primary: Colors.indigo[500],
      primaryFixed: Colors.indigo[100],
      primaryFixedDim: Colors.indigo[50],
      primaryContainer: Colors.indigo[200],
      secondary: Colors.orange[700],
      surface: Colors.white,
      onSurface: Colors.blueGrey[500],
      surfaceContainer: Colors.blueGrey[900],
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: Colors.orange[900],
      outline:Colors.indigo[800],
      outlineVariant:Colors.indigo[300],
      tertiary: Colors.indigo[700],
    ),
    textTheme: getResponsiveTextTheme(context),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white, // Set background color to white
    ),
  );
}

/// get responsive text theme
TextTheme getResponsiveTextTheme(BuildContext context) {
  final DeviceScreenType deviceType = dimensions.getDeviceType(context);

  double getFontSize(double mobile, double tablet, double desktop) {
    switch (deviceType) {
      case DeviceScreenType.desktop:
        return desktop;
      case DeviceScreenType.tablet:
        return tablet;
      case DeviceScreenType.mobile:
        return mobile;
    }
  }

  final Color? color = Colors.blueGrey[900];

  return TextTheme(
    displayLarge: TextStyle(
      fontSize: getFontSize(24, 28, 32),
      fontWeight: FontWeight.w700,
      color: color,
    ),
    displayMedium: TextStyle(
      fontSize: getFontSize(24, 28, 32),
      fontWeight: FontWeight.w500,
      color: color,
    ),
    displaySmall: TextStyle(
      fontSize: getFontSize(24, 28, 32),
      fontWeight: FontWeight.w400,
      color: color,
    ),
    headlineLarge: TextStyle(
      fontSize: getFontSize(20, 22, 24),
      fontWeight: FontWeight.w700,

      color: color,
    ),
    headlineMedium: TextStyle(
      fontSize: getFontSize(20, 22, 24),
      fontWeight: FontWeight.w500,

      color: color,
    ),
    headlineSmall: TextStyle(
      fontSize: getFontSize(20, 22, 24),
      fontWeight: FontWeight.w400,

      color: color,
    ),
    titleLarge: TextStyle(
      fontSize: getFontSize(16, 18, 20),
      fontWeight: FontWeight.w700,

      color: color,
    ),
    titleMedium: TextStyle(
      fontSize: getFontSize(16, 18, 20),
      fontWeight: FontWeight.w500,

      color: color,
    ),
    titleSmall: TextStyle(
      fontSize: getFontSize(16, 18, 20),
      fontWeight: FontWeight.w400,

      color: color,
    ),
    bodyLarge: TextStyle(
      fontSize: getFontSize(14, 15, 16),
      fontWeight: FontWeight.w700,
      color: color,
    ),
    bodyMedium: TextStyle(
      fontSize: getFontSize(14, 15, 16),
      fontWeight: FontWeight.w500,
      color: color,
    ),
    bodySmall: TextStyle(
      fontSize: getFontSize(14, 15, 16),
      fontWeight: FontWeight.w400,

      color: color,
    ),
    labelLarge: TextStyle(
      fontSize: getFontSize(12, 13, 14),
      fontWeight: FontWeight.w700,
      color: color,
    ),
    labelMedium: TextStyle(
      fontSize: getFontSize(12, 13, 14),
      fontWeight: FontWeight.w500,
      color: color,
    ),
    labelSmall: TextStyle(
      fontSize: getFontSize(10, 11, 12),
      fontWeight: FontWeight.w400,
      color: color,
    ),
  );
}
