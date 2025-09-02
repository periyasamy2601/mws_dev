import 'package:avk/router/path_exporter.dart';

/// bool extension
extension ContextExtension on BuildContext {

  /// Set if this value is `true as 1` & `false as 0`.
  Size getSize(){
    return MediaQuery.of(this).size;
  }

  /// get text using context
  S getText(){
    return S.of(this);
  }
  /// get style using context
   TextTheme getStyle(){
    return Theme.of(this).textTheme;
  }

  /// get color using context
  ColorScheme getColor(){
    return Theme.of(this).colorScheme;
  }

  /// get screen size using context
  bool isLargeScreen(){
    return dimensions.getDeviceType(this) == DeviceScreenType.desktop;
  }
  /// get screen size using context
  bool isMobile(){
    return dimensions.getDeviceType(this) == DeviceScreenType.mobile;
  }
}
