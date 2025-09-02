import 'package:avk/router/path_exporter.dart';

extension UserMangementIntExtension on int {
  /// Returns the localized role name based on the integer's
  /// corresponding [RoleEnum] value.
  ///
  /// Example:
  /// ```dart
  /// 0.getRoleName(context); // Returns localized 'Admin'
  /// ```
  int getRowCount() {
    RowPerPageEnum chlorineQuantityUnit = RowPerPageEnum.values[this];
    switch (chlorineQuantityUnit) {
      case RowPerPageEnum.count25:
        return 25;
      case RowPerPageEnum.count50:
        return 50;
      case RowPerPageEnum.count75:
        return 75;
      case RowPerPageEnum.count100:
        return 100;
    }
  }
}
