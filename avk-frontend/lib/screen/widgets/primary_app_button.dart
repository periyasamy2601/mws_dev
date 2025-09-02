import 'package:avk/router/path_exporter.dart';

/// A customizable primary application button with:
/// - Loading state animation (shrinks to a circular loader)
/// - Optional icon for primary button styling
/// - Smooth content expansion animation
///
/// Useful for actions that may take time to complete (e.g., submitting forms).
class PrimaryAppButton extends StatefulWidget {
  /// Creates a [PrimaryAppButton].
  ///
  /// [buttonLabel] is required.
  /// [isLoading] controls the loading animation (defaults to `false`).
  /// [isPrimaryButton] toggles whether to show the primary icon (defaults to `false`).
  const PrimaryAppButton({
    required this.buttonLabel, // Text label for the button
    this.customIcon, // Text label for the button
    super.key,
    this.isLoading = false, // Whether the button shows a loading state
    this.isPrimaryButton = false, // Whether to show the primary icon
    this.isSmall = false, // Whether to show the primary icon
    this.isTransparentButton = false, // Whether to show the primary icon
    this.onButtonTap, // Callback for button tap
    this.showAccessError = false,
  });

  /// Whether to show a loading indicator instead of text content.
  final bool isLoading;

  /// Callback function triggered when the button is tapped.
  final void Function()? onButtonTap;

  /// The text label displayed on the button.
  final String buttonLabel;

  /// Whether this button should display the primary icon.
  final bool isPrimaryButton;

  /// Whether this button is small or not.
  final bool isSmall;

  /// final custom icon
  final Widget? customIcon;

  /// isTransparentButton
  final bool isTransparentButton;

  /// show access error
  final bool showAccessError;

  @override
  State<PrimaryAppButton> createState() => _PrimaryAppButtonState();
}

class _PrimaryAppButtonState extends State<PrimaryAppButton> {

  ConfigEntity? _configEntity;

  @override
  void initState() {
    _configEntity = BlocProvider.of<ConfigBloc>(context).configEntity;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = context.getColor().primary;
    final Color secondaryColor = context.getColor().secondary;

    return BaseButton(
      onTap: () {
        if(widget.showAccessError){
          if(!(_configEntity?.isProjectRoleExist??true)){
            MWSnackBar().showSnackBar(context.getText().please_add_a_role_on_project_settings,width: 500);
            return ;
          }
          if(!(_configEntity?.isZoneExist??true)){
            MWSnackBar().showSnackBar(context.getText().please_add_a_zone_on_project_settings,width: 500);
            return ;
          }
        }
        if (!widget.isLoading) {
          widget.onButtonTap?.call();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: widget.isLoading
            ? 50
            : widget.isSmall
            ? 148
            : 236,
        height: widget.isSmall ? 40 : 50,
        decoration: BoxDecoration(
          color: widget.isTransparentButton ? Colors.transparent : primaryColor,
          borderRadius: BorderRadius.circular(widget.isLoading ? 25 : 10),
          border: Border.all(
            color: widget.isTransparentButton
                ? primaryColor
                : Colors.transparent,
          ),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: widget.isLoading
                ? SizedBox(
                    key: const ValueKey<String>('loader'),
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                      strokeWidth: 2.5,
                    ),
                  )
                : _ExpandedButtonContent(
                    key: const ValueKey<String>('content'),
                    buttonLabel: widget.buttonLabel,
                    isPrimaryButton: widget.isPrimaryButton,
                    isSmall: widget.isSmall,
                    customIcon: widget.customIcon,
                    isTransparentButton: widget.isTransparentButton,
                  ),
          ),
        ),
      ),
    );
  }
}

/// The inner content of the expanded button state, optionally showing an icon.
class _ExpandedButtonContent extends StatelessWidget {
  const _ExpandedButtonContent({
    required this.buttonLabel,
    required this.isPrimaryButton,
    required this.isSmall,
    required this.customIcon,
    required this.isTransparentButton,
    super.key,
  });

  /// The label text displayed inside the button.
  final String buttonLabel;

  /// Whether to show the primary icon at the start of the button.
  final bool isPrimaryButton;

  /// Whether to show the primary icon at the start of the button.
  final bool isSmall;

  /// custom icon
  final Widget? customIcon;

  /// isTransparentButton
  final bool isTransparentButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (isPrimaryButton) ...<Widget>[
          if (isSmall) ...<Widget>[
            Container(
              width: 15,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(80, 80),
                  bottomLeft: Radius.elliptical(80, 80),
                  topRight: Radius.elliptical(80, 200),
                  bottomRight: Radius.elliptical(80, 200),
                ),
                color: context.getColor().secondary,
              ),
            ),
          ] else
            Container(
              width: 15,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(100, 100),
                  bottomLeft: Radius.elliptical(100, 100),
                  topRight: Radius.elliptical(120, 350),
                  bottomRight: Radius.elliptical(120, 350),
                ),
                color: context.getColor().secondary,
              ),
            ),
        ] else if (customIcon != null) ...<Widget>[
          Padding(
            padding: EdgeInsets.only(left: dimensions.paddingM),
            child: customIcon ?? const SizedBox.shrink(),
          ),
        ],
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  buttonLabel,
                  style: isSmall
                      ? context.getStyle().bodySmall?.copyWith(
                          color: isTransparentButton
                              ? context.getColor().primary
                              : context.getColor().onSecondary,
                        )
                      : context.getStyle().headlineSmall?.copyWith(
                          color: isTransparentButton
                              ? context.getColor().primary
                              : context.getColor().onSecondary,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
