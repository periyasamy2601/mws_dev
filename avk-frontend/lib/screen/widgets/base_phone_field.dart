import 'package:avk/router/path_exporter.dart';

/// A customizable phone input field with country picker support.
///
/// Features:
/// - Country selector (optional flag icon)
/// - Input validation (custom or default mobile validator)
/// - Hover border animation effect
/// - Works with custom `TextInputFormatter`s
class BasePhoneField extends StatefulWidget {
  /// constructor
  const BasePhoneField({
    required this.label,
    required this.country,
    required this.editingController,
    super.key,
    this.hintText,
    this.validator,
    this.inputFormatters,
    this.onCountryChanged,
    this.initialCountryCode = 'IN',
  });

  /// Label text shown above the input field.
  final String label;

  /// Optional hint text shown inside the field.
  final String? hintText;

  /// Text editing controller for managing the input value.
  final TextEditingController editingController;

  /// Validator function for input validation.
  /// If not provided, defaults to `validationHelper.mobileNumberValidator`.
  final String? Function(String?)? validator;

  /// Optional list of text input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Callback when the country changes.
  final void Function(Country)? onCountryChanged;

  /// Currently selected country.
  final Country country;

  /// Initial country code for the phone field.
  final String initialCountryCode;
  /// inva

  @override
  State<BasePhoneField> createState() => _BasePhoneFieldState();
}

class _BasePhoneFieldState extends State<BasePhoneField> {
  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(10);
    final ColorScheme colors = context.getColor();

    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovered,
        builder: (BuildContext context, bool isHovered, _) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: MwsPhoneField(
              inputFormatters: widget.inputFormatters,
              showDropdownIcon: false,
              pickerDialogStyle: PickerDialogStyle(
                width: 500,
                showFlagIcon: false,
                countryNameStyle: context.getStyle().bodySmall,
                countryCodeStyle: context.getStyle().bodySmall,
              ),
              showMaxDialLength: false,
              validator: widget.validator ??
                      (String? val) => validationHelper.mobileNumberValidator(
                    val,
                    context,
                    widget.country,
                  ),
              controller: widget.editingController,
              onCountryChanged: widget.onCountryChanged,
              keyboardType: TextInputType.number,
              initialCountryCode: widget.initialCountryCode,
              showCountryFlag: false,
              disableLengthCheck: true,
              style: context.getStyle().bodySmall,
              decoration: InputDecoration(
                counterText: '',
                errorStyle: context.getStyle().bodySmall?.copyWith(
                  color: colors.error,
                ),
                labelText: widget.label,
                hintText: widget.hintText,
                labelStyle: context.getStyle().labelMedium,
                hintStyle: context.getStyle().labelSmall,
                floatingLabelStyle: context.getStyle().labelMedium?.copyWith(
                  color: colors.primary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    color: colors.onSurface,
                    width: isHovered ? 1.5 : 0.8,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: colors.primary, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    color: colors.error,
                    width: isHovered ? 1.5 : 0.8,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: colors.primary, width: 1.5),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
