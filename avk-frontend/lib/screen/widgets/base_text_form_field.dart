import 'package:avk/router/path_exporter.dart';

/// A customizable text form field widget with optional features such as:
/// - Password visibility toggle
/// - Input validation
/// - Input format restrictions
/// - Character length limit
///
/// Typically used in forms where consistent styling and behavior is needed.
class BaseTextFormField extends StatefulWidget {
  /// Creates a [BaseTextFormField].
  ///
  /// [label] and [editingController] are required.
  /// Set [isPasswordField] to `true` to enable password visibility toggle.
  const BaseTextFormField({
    required this.label, // Text label shown above the input
    this.editingController, // Controller to read/write the field value
    super.key,
    this.hintText, // Optional placeholder text
    this.validator, // Optional validation function for form logic
    this.inputFormatters, // Optional list of formatters to restrict/modify input
    this.maxLength, // Optional maximum allowed character count
    this.formKey, // Optional key for form field usage
    this.isPasswordField = false, // Whether to obscure text input
    this.isSmall = false, // Whether to obscure text input
    this.isExtraSmall = false, // Whether to obscure text input
    this.isSearchField = false, // Whether to search input field
    this.suffixText,
    this.onChanged,
  });

  /// The text label displayed above the field.
  final String label;

  /// Optional hint text shown when the field is empty.
  final String? hintText;

  /// Controller that holds and manages the entered text.
  final TextEditingController? editingController;

  /// Function that validates the field's text.
  /// Should return an error string if invalid, or null if valid.
  final String? Function(String?)? validator;

  /// Whether this is a password field that should obscure text.
  final bool isPasswordField;

  /// List of formatters to control or transform input (e.g., numeric only).
  final List<TextInputFormatter>? inputFormatters;

  /// Maximum number of characters allowed in the field.
  final int? maxLength;

  /// Optional key to integrate this widget into a [Form].
  final GlobalKey? formKey;

  /// Optional key to integrate this widget into a [Form].
  final bool isSmall;

  /// Optional key to integrate this widget into a [Form].
  final bool isExtraSmall;

  /// suffix text
  final String? suffixText;

  /// is search field
  final bool isSearchField;

  /// on changed function
  final Function(String? value)? onChanged;

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);
  ValueNotifier<bool> _isObscure = ValueNotifier<bool>(false);

  @override
  void initState() {
    _isObscure = ValueNotifier<bool>(widget.isPasswordField);
    super.initState();
  }

  @override
  void dispose() {
    _isHovered.dispose();
    _isObscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(10);
    final Color primaryColor = context.getColor().primary;
    final Color normalColor = context.getColor().onSurface;
    final Color errorColor = context.getColor().error;

    return ValueListenableBuilder<bool>(
      valueListenable: _isObscure,
      builder: (BuildContext context, bool isObscure, Widget? child) {
        return ValueListenableBuilder<bool>(
          valueListenable: _isHovered,
          builder: (BuildContext context, bool value, Widget? child) {
            return MouseRegion(
              onEnter: (_) => _isHovered.value = true,
              onExit: (_) => _isHovered.value = false,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: widget.isExtraSmall
                      ? 287
                      : widget.isSmall
                      ? 384
                      : 500,
                ),
                child: TextFormField(
                  onChanged: widget.onChanged,
                  key: widget.formKey,
                  maxLength: widget.maxLength,
                  inputFormatters: widget.inputFormatters,
                  obscureText: isObscure,
                  validator: widget.validator,
                  controller: widget.editingController,
                  style: context.getStyle().bodySmall,
                  decoration: InputDecoration(
                    counterText: '',
                    errorStyle: context.getStyle().bodySmall?.copyWith(
                      color: errorColor,
                    ),
                    labelText: widget.label,
                    hintText: widget.hintText,
                    labelStyle: context.getStyle().labelMedium,
                    hintStyle: context.getStyle().labelSmall,
                    floatingLabelStyle: context
                        .getStyle()
                        .labelMedium
                        ?.copyWith(color: primaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: normalColor,
                        width: value ? 1.5 : 0.8,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: errorColor,
                        width: value ? 1.5 : 0.8,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                    ),
                    prefixIcon: widget.isSearchField?  Icon(
                      Icons.search,
                      color: context.getColor().primary,
                      size: 20,
                    ):null,
                    suffixIcon: widget.suffixText != null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(widget.suffixText!,style: context.getStyle().labelSmall,),
                            ),
                          ],
                        )
                        : Visibility(
                            visible: widget.isPasswordField,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                _isObscure.value = !_isObscure.value;
                              },
                              child: Icon(
                                isObscure
                                    ? Icons.visibility_off_rounded
                                    : Icons.remove_red_eye,
                                color: context.getColor().primary,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
