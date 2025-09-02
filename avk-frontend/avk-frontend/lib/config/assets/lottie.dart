import 'package:avk/router/path_exporter.dart';

/// A utility class that contains all the SVG image assets used in the app.
/// Centralizes asset paths for easy access and maintenance.
class AppLottie with LottieBuilderClass {
  const AppLottie._(); // Private constructor to prevent external instantiation

  /// -------- App bar ------
  Widget get splashScreenLottie =>
      lottieAsset('assets/lottie/splash_screen_lottie.json');


}

/// Singleton instance for accessing SVG assets
const AppLottie appLottie = AppLottie._();


/// A class to handle loading Lottie animations from assets with optional parameters for BoxFit and repeat behavior.
mixin LottieBuilderClass {
  /// Method to load a Lottie animation from assets with optional [boxFit] and [repeat] parameters.
  ///
  /// - [path]: The path to the Lottie animation asset.
  /// - [boxFit]: The BoxFit option for how the animation should be resized. Default is null.
  /// - [repeat]: Whether the animation should repeat. Default is true.
  ///
  /// Returns a [LottieBuilder] widget configured with the specified options.
  LottieBuilder lottieAsset(String path, {
    BoxFit? boxFit,
    bool repeat = true,
  }) =>
      Lottie.asset(
        path,
        fit: boxFit,
        repeat: repeat,
      );
}