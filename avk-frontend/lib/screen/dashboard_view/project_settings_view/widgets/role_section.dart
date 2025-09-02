import 'package:avk/router/path_exporter.dart';

/// A widget that displays a section for managing roles.
///
/// This section includes:
/// - A header with an **Add Role** button.
/// - An expandable/collapsible list of existing roles.
/// - Role cards with options to edit or delete.
class RoleSection extends StatelessWidget {
  /// Creates a [RoleSection] widget.
  ///
  /// - [roleExpansionNotifier] controls whether the role list is expanded.
  /// - [roleListNotifier] holds the list of available roles.
  /// - [onAddRoleTap] is called when the **Add Role** button is tapped.
  /// - [headerWidget] is the widget shown as the section header.
  /// - [loader] indicates if the add role button should show a loading state.
  /// - [onEditTap] is called when a role is edited.
  /// - [onDeleteTap] is called when a role is deleted.
  const RoleSection({
    required this.roleExpansionNotifier,
    required this.roleListNotifier,
    required this.onAddRoleTap,
    required this.headerWidget,
    required this.loader,
    required this.onEditTap,
    required this.onDeleteTap,
    super.key,
  });

  /// Controls whether the role list is expanded or collapsed.
  final ValueNotifier<bool> roleExpansionNotifier;

  /// Holds the current list of roles.
  final ValueNotifier<List<RoleEntity>> roleListNotifier;

  /// Callback triggered when the **Add Role** button is tapped.
  final void Function() onAddRoleTap;

  /// Widget displayed as the header of this section.
  final Widget headerWidget;

  /// Indicates if the add role button should show a loading spinner.
  final bool loader;

  /// Callback triggered when a role is edited.
  final Function(RoleEntity role) onEditTap;

  /// Callback triggered when a role is deleted.
  final Function(RoleEntity role) onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: roleExpansionNotifier,
      builder: (BuildContext context, bool isExpanded, _) {
        return ValueListenableBuilder<List<RoleEntity>>(
          valueListenable: roleListNotifier,
          builder: (BuildContext context, List<RoleEntity> roles, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: dimensions.spacingM,
              children: <Widget>[
                BaseButton(
                  onTap: () {
                    if (roles.isNotEmpty) {
                      roleExpansionNotifier.value = !isExpanded;
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      headerWidget,
                      Row(
                        spacing: dimensions.spacingM,
                        children: <Widget>[
                          PrimaryAppButton(
                            isLoading: loader,
                            buttonLabel: context.getText().add_role,
                            isSmall: true,
                            customIcon: Icon(
                              Icons.add,
                              color: context.getColor().surface,
                              size: 20,
                            ),
                            onButtonTap: onAddRoleTap,
                          ),
                          if (roles.isNotEmpty)
                            RotatedBox(
                              quarterTurns: isExpanded ? 0 : 2,
                              child: appSvg.expansionIconLarge,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isExpanded)
                  Wrap(
                    spacing: dimensions.spacingM,
                    runSpacing: dimensions.spacingM,
                    children: roles
                        .map((RoleEntity e) => _roleCard(e, context))
                        .toList(),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  /// Builds a card widget for a single [RoleEntity].
  ///
  /// Displays the role icon, role name, and an edit/delete menu.
  Widget _roleCard(RoleEntity role, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: dimensions.paddingHorizontalM,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.getColor().surfaceContainer,
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(dimensions.radiusXS),
          ),
          child: Row(
            spacing: dimensions.paddingM,
            children: <Widget>[
              role.role?.getRoleIcon() ?? const SizedBox(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    role.name ?? 'No Data',
                    style: context.getStyle().bodySmall,
                  ),
                  Text(
                    role.role?.getRoleName(context) ?? 'NO Data',
                    style: context.getStyle().labelSmall,
                  ),
                ],
              ),
              CustomPopupMenu<EditDeleteEnum>(
                menuItems: EditDeleteEnum.values,
                onSelected: (EditDeleteEnum value) {
                  switch (value) {
                    case EditDeleteEnum.edit:
                      onEditTap(role);
                    case EditDeleteEnum.delete:
                      onDeleteTap(role);
                  }
                },
                iconBuilder: (EditDeleteEnum value) {
                  switch (value) {
                    case EditDeleteEnum.edit:
                      return appSvg.editIcon;
                    case EditDeleteEnum.delete:
                      return appSvg.deleteIcon;
                  }
                },
                labelBuilder: (EditDeleteEnum value) {
                  switch (value) {
                    case EditDeleteEnum.edit:
                      return context.getText().edit;
                    case EditDeleteEnum.delete:
                      return context.getText().delete;
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
