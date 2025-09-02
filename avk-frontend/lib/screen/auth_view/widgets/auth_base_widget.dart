import 'package:avk/router/path_exporter.dart';

/// A base widget for authentication screens that provides
/// a consistent layout with an optional left-side panel
/// (on large screens) and a right-side form/content area
/// with a bottom button.
///
/// This widget is intended to be reused across multiple
/// authentication-related pages to maintain a unified look.
class AuthBaseWidget extends StatelessWidget {
  /// Creates an [AuthBaseWidget].
  ///
  /// - [child] is the main content to be shown in the right panel.
  /// - [bottomButtonName] is the label for the bottom action button.
  /// - [isBottomButtonLoading] indicates whether the bottom button
  ///   should show a loading indicator.
  /// - [bottomButtonTap] is the callback when the bottom button is tapped.
  /// - [label] is an optional title shown above the content.
  /// - [isPrimaryButton] determines if the bottom button should use
  ///   the primary button style.
  const AuthBaseWidget({
    required this.child,
    required this.bottomButtonName,
    required this.isBottomButtonLoading,
    super.key,
    this.bottomButtonTap,
    this.label,
    this.showPop = true,
    this.isPrimaryButton = false,
  });

  /// The main content widget displayed in the right panel.
  final Widget child;

  /// The label text for the bottom action button.
  final String bottomButtonName;

  /// Whether the bottom action button is in a loading state.
  final bool isBottomButtonLoading;

  /// Callback triggered when the bottom action button is tapped.
  final void Function()? bottomButtonTap;

  /// Optional title text displayed above the form content.
  final String? label;

  /// Whether the bottom action button should be styled as a primary button.
  final bool isPrimaryButton;

  /// boolean show pop
  final bool showPop ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (context.isLargeScreen())
          Expanded(
            // Left panel occupies extra space on large screens
            child: _buildLeftPanel(context),
          ),
        Flexible(
          // Right panel always visible
          child: _buildRightPanel(context),
        ),
      ],
    );
  }

  /// Builds the left-side panel for large screens,
  /// typically displaying branding elements such as
  /// background illustrations and the app logo.
  Widget _buildLeftPanel(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: context.getSize().height * (kIsWeb ? 1:0.95),
                child: appSvg.authBackground,
              ),
              Positioned(
                top: context.getSize().height * 0.5,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      appSvg.avkLogoWhite,
                      Text(
                        context.getText().smart_water_management_system,
                        style: context.getStyle().displaySmall?.copyWith(
                          color: context.getColor().onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the right-side panel containing the form or
  /// main interactive content, along with the bottom button.
  Widget _buildRightPanel(BuildContext context) {
    return SizedBox(
      height: context.getSize().height,
      child: Center(
        child: Container(
          margin: context.isLargeScreen() ? dimensions.paddingVerticalL : null,
          alignment: context.isLargeScreen()
              ? Alignment.center
              : Alignment.topCenter,
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            spacing: 50,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Optional label row with back button
              if (label != null)
                Row(
                  children: <Widget>[
                    if(showPop)
                    IconButton(
                      onPressed: _onBackTap,
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                label!,
                                style: context.getStyle().displaySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              // Main content area with scroll support
              if (context.isLargeScreen())
                Flexible(
                  child: SingleChildScrollView(child: Center(child: child)),
                )
              else
                Expanded(
                  child: SingleChildScrollView(child: Center(child: child)),
                ),
              // Bottom action button
              PrimaryAppButton(
                isPrimaryButton: isPrimaryButton,
                isLoading: isBottomButtonLoading,
                buttonLabel: bottomButtonName,
                onButtonTap: bottomButtonTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handles the back button tap event by navigating to
  /// the previous screen using [RouteHelper].
  void _onBackTap() {
    GetIt.I<RouteHelper>().back(returnTrue: false);
  }
}
