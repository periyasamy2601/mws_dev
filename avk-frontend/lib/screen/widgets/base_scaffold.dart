import 'package:avk/router/path_exporter.dart';

/// A reusable scaffold that wraps content in a safe area,
/// adds responsive padding, and optionally includes an app bar and end drawer.
class BaseScaffold extends StatelessWidget {
  /// Creates a [BaseScaffold] with customizable content, optional app bar, and drawer.
  const BaseScaffold({
    required this.child,
    this.isContainsAppbar = false,
    this.drawerWidget,
    this.scaffoldKey,
    super.key,
  });

  /// The main body content of the scaffold.
  final Widget child;

  /// Whether to display the [BaseAppBar] at the top.
  final bool isContainsAppbar;

  /// Optional widget to be shown as the end drawer.
  final Widget? drawerWidget;

  /// Global key for controlling the scaffold's state.
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: drawerWidget,
      appBar: isContainsAppbar
          ? BaseAppBar(
              showDrawerIcon: drawerWidget != null,
              scaffoldKey: scaffoldKey,
            )
          : null,
      body: SafeArea(
        child: Padding(
          // Removes padding for large screens, applies standard padding otherwise.
          padding: context.isLargeScreen()
              ? EdgeInsets.zero
              : dimensions.paddingHorizontalS,
          child: Stack(
            children: <Widget>[
              child,
              Positioned(
                top: 0,
                child: BlocBuilder<NoInternetBloc, NoInternetState>(
                  builder: (BuildContext context, NoInternetState state) {
                    if (state is InternetDisconnected) {
                      return Container(
                        alignment: Alignment.center,
                        width: context.getSize().width,
                        color: context.getColor().error,
                        child: Padding(
                          padding: dimensions.paddingVerticalS,
                          child: Text(
                            context.getText().no_internet_error,
                            style: context.getStyle().labelMedium?.copyWith(
                              color: context.getColor().surface,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A customizable application bar used across the app.
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [BaseAppBar] with optional drawer icon.
  const BaseAppBar({
    required this.showDrawerIcon,
    required this.scaffoldKey,
    super.key,
  });

  /// Whether to show the drawer icon on the right side.
  final bool showDrawerIcon;

  /// Global key to access and control the scaffold's drawer state.
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildAppBarBackground(context));
  }

  /// Builds the decorative app bar background and action section.
  Widget _buildAppBarBackground(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.indigo[900],
        // border: Border(
        //   top: BorderSide(color: context.getColor().outline, width: 10),
        //   right: BorderSide(color: context.getColor().outlineVariant),
        //   bottom: BorderSide(color: context.getColor().outlineVariant),
        // ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.paddingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: context.getSize().width * 0.05),
              child: SizedBox(
                height: 46,
                width: 97,
                child: appSvg.avkLogoWhite,
              ),
            ),
            Row(
              spacing: dimensions.spacingS,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildWelcomeSection(context), // Optional welcome text
                BaseButton(
                  onTap: () async {
                    await GetIt.I<RouteHelper>().pushNamed(routerKeys.profile);
                  },
                  child: appSvg.dashboardAppbarProfileIcon,
                ), // Profile icon SVG
                if (showDrawerIcon)
                  _buildDrawerButton(context), // Menu button if drawer exists
                SizedBox(width: context.getSize().width * 0.05), // Spacer
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the welcome text section if no drawer icon is shown.
  Widget _buildWelcomeSection(BuildContext context) {
    if (!showDrawerIcon) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            context.getText().welcome,
            style: context.getStyle().bodySmall?.copyWith(
              color: context.getColor().surface,
            ),
          ),
          Text(
            'Vibin',
            style: context.getStyle().titleMedium?.copyWith(
              color: context.getColor().surface,
            ),
          ),
        ],
      );
    }
    return const Column(
      children: <Widget>[SizedBox()],
    ); // Empty space if drawer icon exists
  }

  /// Builds the drawer toggle button.
  Widget _buildDrawerButton(BuildContext context) {
    return BaseButton(
      onTap: () {
        final bool isOpen = scaffoldKey?.currentState?.isEndDrawerOpen ?? false;
        if (isOpen) {
          scaffoldKey?.currentState?.closeEndDrawer();
        } else {
          scaffoldKey?.currentState?.openEndDrawer();
        }
      },
      child: appSvg.menuIcon,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70); // Fixed app bar height
}
