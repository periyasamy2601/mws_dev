import 'package:flutter/material.dart';

/// A base divider widget that visually separates content horizontally.
///
/// It displays two small rounded icons on each side of a dashed horizontal line.
/// Typically used to add a subtle decorative separation between UI elements.
class BaseDivider extends StatelessWidget {
  /// Creates a [BaseDivider].
  ///
  /// This widget is stateless and relies on the current theme for the divider color.
  const BaseDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Left decorative small circle icon.
        Icon(
          Icons.circle_rounded,
          color: Theme.of(context).dividerColor,
          size: 5,
        ),

        // The dashed horizontal line expands to fill the space between the circles.
        const Expanded(
          child: DashedLine(),
        ),

        // Right decorative small circle icon.
        Icon(
          Icons.circle_rounded,
          color: Theme.of(context).dividerColor,
          size: 5,
        ),
      ],
    );
  }
}

/// A widget that draws a horizontal dashed line using a custom painter.
///
/// The line's color is derived from the current theme's divider color.
class DashedLine extends StatelessWidget {
  /// Creates a [DashedLine].
  ///
  /// This widget paints a horizontal dashed line with fixed height.
  const DashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: CustomPaint(
        // Uses [DashedLinePainter] to draw the dashed line.
        painter: DashedLinePainter(
          color: Theme.of(context).dividerColor,
        ),
      ),
    );
  }
}

/// Custom painter that draws a horizontal dashed line.
///
/// The dashed line consists of alternating solid dash segments and gaps.
class DashedLinePainter extends CustomPainter {

  /// Creates a [DashedLinePainter].
  ///
  /// The [color] parameter must not be null.
  /// Optional parameters [dashWidth] and [dashSpacing] control dash length and gap size.
  DashedLinePainter({
    required this.color,
    this.dashWidth = 4,
    this.dashSpacing = 5,
  });
  /// The color of the dashed line.
  final Color color;

  /// The width of each dash segment.
  final double dashWidth;

  /// The spacing between consecutive dash segments.
  final double dashSpacing;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    double startX = 0;
    final double y = size.height / 2;

    // Draw dashes horizontally until the width of the widget is filled.
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
