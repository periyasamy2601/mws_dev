import 'package:avk/router/path_exporter.dart';

class InfoTooltipIcon extends StatelessWidget {
  final String? tooltipText;
  final Widget? customContent;
  final GlobalKey<TooltipState>? tooltipKey;
  final double iconSize;

  const InfoTooltipIcon({
    this.tooltipText,
    this.customContent,
    this.tooltipKey,
    this.iconSize = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final  TooltipState? tooltip = tooltipKey?.currentState;
        if (tooltip != null) {
          tooltip.ensureTooltipVisible();
        }
      },
      child: Tooltip(
        key: tooltipKey,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: context.getColor().surface,
          borderRadius: BorderRadius.circular(8), // Slightly larger radius like a card
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2), // Soft shadow
              blurRadius: 8,
              offset: const Offset(0, 4), // Vertical offset like elevation
            ),
          ],
        ),
        message: tooltipText,
        textStyle: context.getStyle().labelSmall,
        richMessage: customContent != null
            ? WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: customContent!,
        )
            : null,
        child: Icon(Icons.info_outline, size: iconSize),
      ),
    );
  }
}
