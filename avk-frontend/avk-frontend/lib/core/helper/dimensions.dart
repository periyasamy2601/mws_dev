import 'package:avk/router/path_exporter.dart';

/// instance
Dimensions dimensions = Dimensions();
///
class Dimensions {
  /// constructor
  factory Dimensions() => _instance;
  Dimensions._internal() {
    _initEdgeInsets(); // Initialize EdgeInsets here
  }
  static final Dimensions _instance = Dimensions._internal();

  /// get device type
  DeviceScreenType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return DeviceScreenType.desktop;
    }
    if (width >= 600) {
      return DeviceScreenType.tablet;
    }
    return DeviceScreenType.mobile;
  }

// ----------------------------
// Radius constants
// ----------------------------

  /// Extra small corner radius used for subtle rounded edges.
  final double radiusXS = 10;
  /// Small corner radius used for subtle rounded edges.
  final double radiusS = 20;

// ----------------------------
// Spacing constants (gaps between widgets)
// ----------------------------

  /// Extra small spacing (e.g., between very close elements).
  final double spacingXS = 10;

  /// Small spacing between elements.
  final double spacingS = 20;

  /// Medium spacing between elements.
  final double spacingM = 35;

  /// Large spacing for separating major sections.
  final double spacingL = 40;

  /// Extra large spacing for maximum separation.
  final double spacingXL = 50;

// ----------------------------
// Padding size constants (raw values)
// ----------------------------

  /// Extra small padding (minimal internal spacing inside widgets).
  final double paddingXS = 4;

  /// Small padding for compact UI components.
  final double paddingS = 8;

  /// Medium padding for standard layouts.
  final double paddingM = 16;

  /// Large padding for more breathing space inside containers.
  final double paddingL = 24;

  /// Extra large padding for very spacious designs.
  final double paddingXL = 32;

// ----------------------------
// EdgeInsets constants
// (initialized later to keep definitions organized)
// ----------------------------

  /// Extra small padding applied on all sides.
  late final EdgeInsets paddingAllXS;

  /// Small padding applied on all sides.
  late final EdgeInsets paddingAllS;

  /// Medium padding applied on all sides.
  late final EdgeInsets paddingAllM;

  /// Large padding applied on all sides.
  late final EdgeInsets paddingAllL;

  /// Extra large padding applied on all sides.
  late final EdgeInsets paddingAllXL;

  /// Small horizontal padding (left & right only).
  late final EdgeInsets paddingHorizontalS;

  /// Medium horizontal padding (left & right only).
  late final EdgeInsets paddingHorizontalM;

  /// Large horizontal padding (left & right only).
  late final EdgeInsets paddingHorizontalL;

  /// Small vertical padding (top & bottom only).
  late final EdgeInsets paddingVerticalS;

  /// Medium vertical padding (top & bottom only).
  late final EdgeInsets paddingVerticalM;

  /// Large vertical padding (top & bottom only).
  late final EdgeInsets paddingVerticalL;

  /// Symmetric padding: small vertical + medium horizontal.
  late final EdgeInsets paddingSymmetricSM;

  void _initEdgeInsets() {
    paddingAllXS = EdgeInsets.all(paddingXS);
    paddingAllS = EdgeInsets.all(paddingS);
    paddingAllM = EdgeInsets.all(paddingM);
    paddingAllL = EdgeInsets.all(paddingL);
    paddingAllXL = EdgeInsets.all(paddingXL);

    paddingHorizontalS = EdgeInsets.symmetric(horizontal: paddingS);
    paddingHorizontalM = EdgeInsets.symmetric(horizontal: paddingM);
    paddingHorizontalL = EdgeInsets.symmetric(horizontal: paddingL);

    paddingVerticalS = EdgeInsets.symmetric(vertical: paddingS);
    paddingVerticalM = EdgeInsets.symmetric(vertical: paddingM);
    paddingVerticalL = EdgeInsets.symmetric(vertical: paddingL);

    paddingSymmetricSM = EdgeInsets.symmetric(horizontal: paddingS, vertical: paddingM);
  }
}
