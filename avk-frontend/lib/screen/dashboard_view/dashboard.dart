import 'package:avk/router/path_exporter.dart';

/// Tracks whether the desktop drawer is currently shrunk.
final ValueNotifier<bool> drawerShrinkNotifier = ValueNotifier<bool>(true);

/// A responsive dashboard layout widget that adapts between
/// desktop and mobile view, with a configurable navigation drawer.
///
/// - **Desktop:** Uses a collapsible drawer that can shrink or expand
///   based on hover or user preference.
/// - **Mobile:** Uses a standard [Drawer] inside a [Scaffold].
///
/// The `Dashboard` also holds a route identifier to track
/// the currently active page.
class Dashboard extends StatefulWidget {
  /// Creates a [Dashboard] widget.
  ///
  /// [routeName] is used to highlight the active drawer item.
  /// [child] is the main content of the dashboard.
  const Dashboard({required this.routeName, required this.child, super.key});

  /// The name of the current route, used to highlight the selected drawer item.
  final String routeName;

  /// The main content widget to be displayed in the dashboard body.
  final Widget child;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  /// Tracks the currently hovered drawer route (for hover styling).
  final ValueNotifier<String> _hoverNotifier = ValueNotifier<String>('');

  /// A global key to control the [Scaffold] if needed.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConfigBloc>(context).add(GetConfigEvent());
    unawaited(_setDrawerShrinkValue());
  }

  /// Retrieves the stored drawer shrink preference and updates [drawerShrinkNotifier].
  Future<void> _setDrawerShrinkValue() async {
    drawerShrinkNotifier.value = GetIt.I<LocalStorage>().getDrawerShrink();
  }

  @override
  void dispose() {
    _hoverNotifier.dispose();
    // drawerShrinkNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop =
        dimensions.getDeviceType(context) == DeviceScreenType.desktop;

    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (BuildContext context, ConfigState state) {
        ConfigEntity? configEntity = context.watch<ConfigBloc>().configEntity;
        if (configEntity == null) {
          return const SizedBox();
        }
        return BaseScaffold(
          scaffoldKey: _scaffoldKey,
          isContainsAppbar: true,
          drawerWidget: isDesktop ? null : _buildMobileDrawer(context),
          child: ValueListenableBuilder<bool>(
            valueListenable: drawerShrinkNotifier,
            builder: (BuildContext context, bool isShrinked, _) {
              return Row(
                children: <Widget>[
                  if (isDesktop) _buildDesktopDrawer(context, isShrinked),
                  Expanded(child: widget.child),
                ],
              );
            },
          ),
        );
      },
    );
  }

  /// Builds the [Drawer] widget for mobile view.
  Widget _buildMobileDrawer(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;

    return SizedBox(
      height: width > 512 ? height * 0.9 : null,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Drawer(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(dimensions.radiusS),
            ),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: dimensions.paddingXL,
                horizontal: dimensions.paddingL,
              ),
              child: Column(
                spacing: dimensions.spacingS,
                children: _buildDrawerItems(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the collapsible navigation drawer for desktop view.
  Widget _buildDesktopDrawer(BuildContext context, bool isShrinked) {
    return MouseRegion(
      onEnter: (_) => _handleHoverChange(false),
      onExit: (_) => _handleHoverChange(true),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: isShrinked
              ? appConstants.minDrawerWidgetWidth
              : appConstants.maxDrawerWidgetWidth,
          minWidth: appConstants.minDrawerWidgetWidth,
        ),
        padding: EdgeInsets.symmetric(
          vertical: dimensions.paddingXL,
          horizontal: dimensions.paddingL,
        ),
        child: Column(
          spacing: dimensions.spacingS,
          children: <Widget>[
            _buildDrawerHeader(context, isShrinked),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: dimensions.spacingS,
                  children: _buildDrawerItems(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Handles mouse enter/exit events to auto-shrink or expand the drawer.
  void _handleHoverChange(bool shrink) {
    if (GetIt.I<LocalStorage>().getHoverShrink()) {
      drawerShrinkNotifier.value = shrink;
      unawaited(GetIt.I<LocalStorage>().setDrawerShrink(value: shrink));
    }
  }

  /// Builds the drawer header with an optional title and settings button.
  Widget _buildDrawerHeader(BuildContext context, bool isShrinked) {
    return Row(
      mainAxisAlignment: isShrinked
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (!isShrinked)
          Text(
            context.getText().settings,
            style: context.getStyle().headlineMedium,
          ),
        BaseButton(
          onTap: _toggleDrawerShrink,
          child: isShrinked
              ? appSvg.dashboardSettingsCloseIcon
              : appSvg.dashboardSettingsOpenIcon,
        ),
      ],
    );
  }

  /// Toggles between shrunk and expanded drawer states and saves preferences.
  void _toggleDrawerShrink() {
    final bool current = GetIt.I<LocalStorage>().getHoverShrink();
    final bool newValue = !current;

    drawerShrinkNotifier.value = newValue;

    unawaited(GetIt.I<LocalStorage>().setDrawerShrink(value: newValue));
    unawaited(GetIt.I<LocalStorage>().setHoverShrink(value: newValue));
  }

  /// Builds the list of drawer navigation items.
  List<Widget> _buildDrawerItems() {
    return <Widget>[
      // _drawerCard(
      //   context.getText().home,
      //   appSvg.dashboardHomeIcon,
      //   widget.routeName == routerKeys.home,
      //   routerKeys.home,
      // ),
      _drawerCard(
        context.getText().project_settings,
        appSvg.dashboardProjectsSettingsIcon,
        widget.routeName.contains(routerKeys.projectSettings),
        routerKeys.projectSettings,
      ),
      _drawerCard(
        context.getText().user_management,
        appSvg.dashboardUserManagementIcon,
        widget.routeName.startsWith(routerKeys.userManagement),
        routerKeys.userManagement,
      ),
    ];
  }

  /// Builds an individual drawer item card with hover and selection states.
  Widget _drawerCard(
    String label,
    Widget icon,
    bool isSelected,
    String routeName,
  ) {
    final bool isDesktop =
        dimensions.getDeviceType(context) == DeviceScreenType.desktop;

    return ValueListenableBuilder<String>(
      valueListenable: _hoverNotifier,
      builder: (BuildContext context, String hoveredRoute, _) {
        DrawerCardEnum state = DrawerCardEnum.none;

        if (isSelected) {
          state = DrawerCardEnum.selected;
        } else if (hoveredRoute == routeName) {
          state = DrawerCardEnum.hover;
        }

        return BaseButton(
          onTap: () {
            if (!isSelected) {
              unawaited(GetIt.I<RouteHelper>().pushReplacementNamed(routeName));
            }
          },
          child: MouseRegion(
            onEnter: (_) => _hoverNotifier.value = routeName,
            onExit: (_) => _hoverNotifier.value = '',
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: state == DrawerCardEnum.none
                    ? null
                    : Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(dimensions.radiusXS),
                border: state == DrawerCardEnum.selected
                    ? Border(
                        top: BorderSide(color: context.getColor().tertiary),
                        right: BorderSide(color: context.getColor().tertiary),
                        left: BorderSide(color: context.getColor().tertiary),
                        bottom: BorderSide(
                          color: context.getColor().tertiary,
                          width: 4,
                        ),
                      )
                    : null,
              ),
              child: Row(
                mainAxisAlignment: !drawerShrinkNotifier.value || !isDesktop
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                spacing: dimensions.spacingXS,
                children: <Widget>[
                  icon,
                  if (!drawerShrinkNotifier.value || !isDesktop)
                    Text(label, style: context.getStyle().bodySmall),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
