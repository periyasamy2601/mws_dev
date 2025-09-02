import 'package:avk/router/path_exporter.dart';

/// A simple centered loading spinner used across the app.
///
/// This widget shows a [CircularProgressIndicator] aligned based on [alignment].
/// It can be customized with [isSmall], [height], and [width].
/// Useful for indicating async operations such as API calls or data loading.
class AppLoader extends StatelessWidget {
  /// Creates an [AppLoader] widget.
  ///
  /// - [isSmall] reduces the spinner size to 10x10.
  /// - [height] and [width] allow custom sizing.
  /// - [alignment] defines where the spinner should appear.
  const AppLoader({
    super.key,
    this.isSmall = false,
    this.height,
    this.width,
    this.alignment,
  });

  /// Whether to show a smaller loader (10x10).
  final bool isSmall;

  /// Custom height of the loader (overrides [isSmall] if provided).
  final double? height;

  /// Custom width of the loader (overrides [isSmall] if provided).
  final double? width;

  /// Alignment of the loader inside its parent (defaults to [Alignment.center]).
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: SizedBox(
        height: height ?? (isSmall ? 10 : null),
        width: width ?? (isSmall ? 10 : null),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
