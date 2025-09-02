import 'package:avk/router/path_exporter.dart';

/// A utility class that contains all the SVG image assets used in the app.
/// Centralizes asset paths for easy access and maintenance.
class AppSvg with SvgBuilderClass, WebPBuilderClass {
  const AppSvg._(); // Private constructor to prevent external instantiation

  /// -------- App bar ------
  Widget get authAppBar =>
      svgAsset('assets/images/auth_svgs/auth_appbar.svg');

  /// -------- App Logo white ------
  Widget get avkLogoWhite =>
      svgAsset('assets/images/auth_svgs/logo_white.svg');

  /// -------- Auth background ------
  Widget get authBackground => webPAsset(
    'assets/images/auth_svgs/login_background.webp',
    boxFit: BoxFit.contain,
  );

  /// -------- Register screen icon ------
  Widget get registerIcon =>
      svgAsset('assets/images/auth_svgs/register_svg.svg');

  /// -------- OTP & Forgot password screen icon ------
  Widget get otpIcon => svgAsset('assets/images/auth_svgs/forgot_password.svg');

  /// -------- reset password screen icon ------
  Widget get resetPasswordIcon =>
      svgAsset('assets/images/auth_svgs/reset_password.svg');

  /// --------Success icon ------
  Widget get successIcon => svgAsset('assets/images/auth_svgs/success_svg.svg');

  /// --------dashboard app bar log icon ------
  Widget get dashboardAppBarLogoIcon =>
      svgAsset('assets/images/dashboard/app_bar_svgs/app_bar_app_logo.svg');

  /// --------dashboard Settings icon ------
  Widget get dashboardSettingsOpenIcon =>
      svgAsset('assets/images/dashboard/settings_icon.svg');
  /// --------dashboard Settings icon ------
  Widget get dashboardSettingsCloseIcon =>
      svgAsset('assets/images/dashboard/settings_icon.svg',quarterTurns: 2);

  /// --------dashboard home icon ------
  Widget get dashboardHomeIcon =>
      svgAsset('assets/images/dashboard/home_icon.svg');

  /// --------dashboard ProjectsSettings icon ------
  Widget get dashboardProjectsSettingsIcon =>
      svgAsset('assets/images/dashboard/project_settings_icon.svg');

  /// --------dashboard UserManagement icon ------
  Widget get dashboardUserManagementIcon =>
      svgAsset('assets/images/dashboard/user_management_icon.svg');

  /// --------dashboard Reports icon ------
  Widget get dashboardHomeReportsIcon =>
      svgAsset('assets/images/dashboard/reports_icon.svg');

  /// --------dashboard app bar profile icon ------
  Widget get dashboardAppbarProfileIcon =>
      svgAsset('assets/images/dashboard/app_bar_svgs/profile_icon.svg');

  /// --------project settings admin icon ------
  Widget get projectSettingsAdminIcon =>
      svgAsset('assets/images/dashboard/project_settings/admin_icon.svg');

  /// --------project settings control icon ------
  Widget get projectSettingsControlIcon =>
      svgAsset('assets/images/dashboard/project_settings/control_icon.svg');

  /// --------project settings Device-Configuration icon ------
  Widget get projectSettingsDeviceConfigurationIcon => svgAsset(
    'assets/images/dashboard/project_settings/device_configuration_icon.svg',
  );

  /// --------project settings Monitoring-Access icon ------
  Widget get projectSettingsMonitoringAccessIcon => svgAsset(
    'assets/images/dashboard/project_settings/mointer_access_icon.svg',
  );

  /// --------edit icon ------
  Widget get editIcon => svgAsset('assets/images/common/edit_icon.svg');

  /// --------delete icon ------
  Widget get deleteIcon => svgAsset('assets/images/common/delete_icon.svg');
  /// --------expansion large icon ------
  Widget get expansionIconLarge => svgAsset('assets/images/common/expansion_icon_large.svg');
  /// --------expansion small icon ------
  Widget get expansionIconSmall => svgAsset('assets/images/common/expansion_icon_small.svg');
  /// --------skip left icon ------
  Widget get skipLeftIcon => svgAsset('assets/images/common/expansion_icon_small.svg',quarterTurns: 3,);
  /// --------skip right icon ------
  Widget get skipRightIcon => svgAsset('assets/images/common/expansion_icon_small.svg' ,quarterTurns: 1,);
 /// --------delete small icon ------
  Widget get profileIconBlue => svgAsset('assets/images/profile_svgs/profile_icon_blue.svg');
 /// --------delete small icon ------
  Widget get workIcon => svgAsset('assets/images/profile_svgs/work.svg');
 /// --------delete small icon ------
  Widget get roleIcon => svgAsset('assets/images/profile_svgs/role.svg');
 /// --------delete small icon ------
  Widget get mailIcon => svgAsset('assets/images/profile_svgs/mail.svg');
 /// --------delete small icon ------
  Widget get mobileIcon => svgAsset('assets/images/profile_svgs/mobile.svg');
  /// --------add icon ------
  Widget get addIcon => svgAsset('assets/images/common/add_svg.svg');

  /// --------overall skip left icon ------
  Widget get overAllSkipLeftIcon => svgAsset('assets/images/common/overall_skip.svg');

  /// --------overall skip right icon ------
  Widget get overAllSkipRightIcon => svgAsset('assets/images/common/overall_skip.svg',quarterTurns: 2);

  /// --------menu icon ------
  Widget get menuIcon => svgAsset('assets/images/dashboard/app_bar_svgs/menu_icon.svg');

  /// --------menu icon ------
  Widget get userCreateSuccessIcon => svgAsset('assets/images/common/success_icon.svg');

  /// --------menu icon ------
  Widget get copyIcon => svgAsset('assets/images/common/copu_icon.svg');

  /// --------menu icon ------
  Widget get refreshIcon => svgAsset('assets/images/common/reload_icon.svg');

  /// --------menu icon ------
  Widget get emptyIcon => svgAsset('assets/images/common/empty_icon.svg');

  /// --------menu icon ------
  Widget get noDataIcon => svgAsset('assets/images/common/no_data_icon.svg');

}

/// Singleton instance for accessing SVG assets
const AppSvg appSvg = AppSvg._();

/// A utility class for creating WebP asset images.
mixin WebPBuilderClass {
  /// Creates an [Image] widget from a WebP asset.
  ///
  /// - [path]: The asset path of the WebP image.
  /// - [boxFit]: (Optional) The fit mode of the image.
  Image webPAsset(String path, {BoxFit? boxFit}) =>
      Image.asset(path, fit: boxFit ?? BoxFit.contain);
}

/// A utility mixin for creating [SvgPicture] widgets from asset paths.
mixin SvgBuilderClass {
  /// Creates an [SvgPicture] widget from the provided asset path.
  ///
  /// - [path]: The asset path of the SVG image.
  /// - [boxFit]: Optional fit mode for the image.
  /// - [height]: Optional height for the image.
  /// - [width]: Optional width for the image.
  Widget svgAsset(
    String path, {
    BoxFit? boxFit,
    double? height,
    double? width,
    int quarterTurns = 0
  }) => RotatedBox(
    quarterTurns: quarterTurns,
    child: SvgPicture.asset(
      path,
      fit: boxFit ?? BoxFit.contain,
      height: height,
      width: width,
    ),
  );
}
