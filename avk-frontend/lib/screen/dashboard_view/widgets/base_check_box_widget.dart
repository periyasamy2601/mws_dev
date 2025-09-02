import 'package:avk/router/path_exporter.dart';

/// A reusable checkbox widget that supports both single and multi-selection.
///
/// [T] is the type of the selectable item.
class BaseCheckBoxWidget<T> extends StatelessWidget {
  /// Creates a [BaseCheckBoxWidget].
  ///
  /// [valueNotifier] should be:
  /// - ValueNotifierT> when [isMultiSelect] is false.
  /// - ValueNotifierListT>> when [isMultiSelect] is true.
  const BaseCheckBoxWidget({
    required this.valueNotifier,
    required this.options,
    required this.labelBuilder,
    required this.noneValue,
    this.isMultiSelect = false,
    this.wrapAxis,
    this.runSpacing,
    this.spacing,
    this.toolTipBuilderBuilder,
    super.key,
  });

  /// The selection value notifier:
  /// - T for single-select
  /// - ListT> for multi-select
  final ValueNotifier<Object> valueNotifier;

  /// The available options
  final List<T> options;

  /// Builds the label for each option
  final String Function(T) labelBuilder;
  /// Builds the label for each option
  final Widget Function(T)? toolTipBuilderBuilder;

  /// Used in single-select mode to reset the selection
  final T noneValue;

  /// Whether the widget allows multiple selection
  final bool isMultiSelect;

  /// Layout customization
  final Axis? wrapAxis;

  /// run Spacing
  final double? runSpacing;
 ///  Spacing
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Object>(
      valueListenable: valueNotifier,
      builder: (BuildContext context, Object selectedValue, Widget? child) {
        return Wrap(
          direction: wrapAxis ?? Axis.horizontal,
          spacing: spacing ?? dimensions.spacingM,
          runSpacing: runSpacing ?? dimensions.spacingM,
          children: options.map((T option) {
            final bool isSelected = isMultiSelect
                ? (selectedValue as List<T>).contains(option)
                : selectedValue == option;

            return _buildOption(
              context: context,
              label: labelBuilder(option),
              tooltipWidget: toolTipBuilderBuilder?.call(option),
              isSelected: isSelected,
              onChanged: (_) {
                if (isMultiSelect) {
                  final List<T> updated = List<T>.from(selectedValue as List<T>);
                  if (isSelected) {
                    updated.remove(option);
                  } else {
                    updated.add(option);
                  }
                  (valueNotifier as ValueNotifier<List<T>>).value = updated;
                } else {
                  (valueNotifier as ValueNotifier<T>).value =
                  isSelected ? noneValue : option;
                }
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required ValueChanged<bool?> onChanged,
    required Widget? tooltipWidget,
  }) {
    return BaseButton(
      onTap: () => onChanged(true),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
            side: BorderSide(color: context.getColor().primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            value: isSelected,
            onChanged: onChanged,
          ),
          Text(label, style: context.getStyle().bodySmall),
          if(tooltipWidget!=null)...<Widget>[
           const SizedBox(width: 5,),
            tooltipWidget,
          ]
        ],
      ),
    );
  }
}
