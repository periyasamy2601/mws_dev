import 'package:avk/router/path_exporter.dart';

/// A reusable **scaffold layout** for dashboard screens.
///
/// Provides:
/// - Optional [DashboardAppBar].
/// - Consistent padding.
/// - Support for an optional **primary button** at the bottom.
class DashboardScaffold extends StatelessWidget {
  /// constructor
  const DashboardScaffold({
    required this.child,
    super.key,
    this.hasAppBar = false,
    this.title,
    this.actions,
    this.buttonLabel,
    this.onButtonTap,
    this.isTransparentButton = false,
    this.isButtonLoading = false,
    this.scrollController,
    this.isLoading = false,
    this.isEmpty = false,
    this.headerWidget,
  });

  /// Main widget content of the screen.
  final Widget child;

  /// Whether to show an [DashboardAppBar].
  final bool hasAppBar;

  /// App bar title (if [hasAppBar] is true).
  final String? title;

  /// Optional label for the bottom button.
  final String? buttonLabel;

  /// Callback when bottom button is tapped.
  final void Function()? onButtonTap;

  /// List of widgets displayed in the app bar’s action area.
  final List<Widget>? actions;

  /// If true, renders the bottom button as a **transparent button**.
  final bool isTransparentButton;

  /// is loading
  final bool isButtonLoading;

  /// scroll controller
  final ScrollController? scrollController;

  /// final bool isPageLoading
  final bool isLoading;

  /// header widget
  final List<Widget>? headerWidget;

  /// check  is empty
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: <Widget>[
                  if (hasAppBar) _appBarWidget(context),
                  Padding(
                    padding: dimensions.paddingAllL,
                    child: Column(
                      spacing: 25,
                      children: <Widget>[
                        if (headerWidget != null) ...headerWidget!,
                        if (isEmpty) Center(child: SizedBox(
                            height: context.getSize().height * 0.6,child: appSvg.emptyIcon)) else child,

                        /// Optional bottom button
                        if (buttonLabel != null) ...<Widget>[
                          Center(
                            child: PrimaryAppButton(
                              isLoading: isButtonLoading,
                              isTransparentButton: isTransparentButton,
                              buttonLabel: buttonLabel!,
                              onButtonTap: onButtonTap,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  SizedBox _appBarWidget(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => GetIt.I<RouteHelper>().back(),
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: context.getColor().primary,
              size: 30,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: context.isMobile()
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: <Widget>[
                if (!context.isMobile()) ...<Widget>[const SizedBox(width: 30)],
                Text(title ?? '', style: context.getStyle().headlineLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom **AppBar** used in [DashboardScaffold].
class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// constructor
  const DashboardAppBar({super.key, this.title, this.actions});

  /// The app bar title.
  final String? title;

  /// Action widgets displayed at the end of the app bar.
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => GetIt.I<RouteHelper>().back(),
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: context.getColor().primary,
          size: 30,
        ),
      ),
      centerTitle: context.isMobile(),
      title: Text(title ?? '', style: context.getStyle().headlineLarge),
      backgroundColor: context.getColor().surface,
      actions: <Widget>[
        ...actions ?? <Widget>[],
        SizedBox(width: dimensions.spacingS),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
