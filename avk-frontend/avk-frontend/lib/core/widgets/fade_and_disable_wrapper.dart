import 'package:avk/router/path_exporter.dart';

/// A wrapper widget that can fade its child and/or disable user interaction.
///
/// - If [isFade] is true, the child widget is rendered with `0.5` opacity.
/// - If [isDisable] is true, user interactions (taps, gestures) on the child
///   are absorbed and disabled.
///
/// Useful when you want to indicate a disabled state visually and functionally
/// (e.g., disabled form fields, inactive buttons, or pending network requests).
class FadeAndDisableWrapper extends StatelessWidget {
  /// Creates a [FadeAndDisableWrapper].
  ///
  /// Both [isFade] and [isDisable] default to `false`.
  const FadeAndDisableWrapper({
    required this.isFade,
    required this.child,
    required this.isDisable,
    super.key,
  });

  /// Whether to apply a faded opacity (`0.5`) to the child.
  final bool isFade;

  /// Whether to disable interaction with the child using [AbsorbPointer].
  final bool isDisable;

  /// The widget to render inside this wrapper.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !isFade ? 1 : 0.5,
      child: AbsorbPointer(absorbing: isDisable, child: child),
    );
  }
}
