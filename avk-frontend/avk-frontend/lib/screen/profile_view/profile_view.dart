import 'package:avk/router/path_exporter.dart';

/// A view that displays the user's **Profile** information.
///
/// This screen shows user details such as name, role, email,
/// phone number, and organization. It also provides a logout
/// button and an edit profile action.
class ProfileView extends StatefulWidget {
  /// Creates a [ProfileView].
  ///
  /// The optional [key] can be used to preserve state
  /// when the widget tree rebuilds.
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

/// The state for [ProfileView].
///
/// Handles building the UI and managing user interactions
/// like logout and profile editing.
class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      isTransparentButton: true,
      buttonLabel: context.getText().log_out,
      onButtonTap: _onLogoutTap,
      hasAppBar: true,
      title: context.getText().profile,
      actions: <Widget>[
        IconButton(
          onPressed: () async {
            await GetIt.I<RouteHelper>().pushNamed(
              routerKeys.updateProfile,
            );
          },
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: appSvg.editIcon,
          ),
        ),
      ],
      child: Center(
        child: SizedBox(
          height: 420,
          width: 500,
          child: Stack(
            children: <Widget>[
              /// Main profile container with user details
              Positioned(
                bottom: 0,
                right: 20,
                left: 20,
                child: Container(
                  height: 360,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    top: 70,
                    left: dimensions.paddingL,
                    right: dimensions.paddingL,
                    bottom: dimensions.paddingL,
                  ),
                  decoration: BoxDecoration(
                    color: context.getColor().primaryFixedDim,
                    borderRadius: BorderRadius.circular(dimensions.radiusS),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Vibin', style: context.getStyle().headlineLarge),
                      Text(
                        '( Divisional Officer )',
                        style: context.getStyle().bodySmall,
                      ),
                      buildLabelCard(
                        'Karnataka Water Management Dept.',
                        appSvg.workIcon,
                      ),
                      buildLabelCard('Manager', appSvg.roleIcon),
                      buildLabelCard('abc@gmail.com', appSvg.mailIcon),
                      buildLabelCard('9345591167', appSvg.mobileIcon),
                      const SizedBox(height: 30),
                      Align(
                        child: Text(
                          'App : V1.0 (10)',
                          style: context.getStyle().labelLarge?.copyWith(
                            color: context.getColor().primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Profile icon overlay
              Positioned(
                left: -8,
                top: -5,
                child: appSvg.profileIconBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a **label row** with an icon and text.
  Widget buildLabelCard(String label, Widget icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        spacing: 10,
        children: <Widget>[
          icon,
          Text(label, style: context.getStyle().bodySmall),
        ],
      ),
    );
  }

  /// Handles the logout button tap.
  void _onLogoutTap() {
  }
}
