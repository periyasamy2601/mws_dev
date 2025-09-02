import 'dart:async';

import 'package:avk/router/path_exporter.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key, required this.baseRouteEntity});

  final BaseRouteEntity baseRouteEntity;

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _roleNameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Set<String> _selectedSiteIds = <String>{};
  late UserManagementBloc _userManagementBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<dynamic>> _roleFieldKey =
      GlobalKey<FormFieldState<dynamic>>();
  NameId? _selectedRole;
  CommonLogics commonLogics = GetIt.I<CommonLogics>();

  final ValueNotifier<bool> _zoneSiteErrorNotifier = ValueNotifier(false);

  @override
  void initState() {
    _userManagementBloc = BlocProvider.of(context);
    _userManagementBloc.add(
      GetUserDataEvent(userId: widget.baseRouteEntity.id ?? ''),
    );
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailIdController.dispose();
    _zoneSiteErrorNotifier.dispose();
    _roleNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserManagementBloc, UserManagementState>(
      listener: (BuildContext context, UserManagementState state) {
        if (state is UserManagementSuccess) {
          _selectedRole = state.selectedUserRole;
          logger.debugLog('_selectedRole', _selectedRole);
          _selectedSiteIds = commonLogics
              .getSelectedSiteIds(state.zoneList)
              .toSet();
          _emailIdController.text = state.user.email ?? '';
          if (state.stateEnum == UserManagementStateEnum.successPopup) {
            unawaited(GetIt.I<DialogHelper>().createUserSuccessPopup(context));
          }
          if (state.stateEnum == UserManagementStateEnum.backPop) {
            GetIt.I<RouteHelper>().back();
            _userManagementBloc.add(GetUsersEvent(skipIndex: 0));
          }
        }
      },
      builder: (BuildContext context, UserManagementState state) {
        if (state is UserManagementSuccess) {
          return DashboardScaffold(
            isLoading: state.stateEnum == UserManagementStateEnum.userLoading,
            scrollController: _scrollController,
            hasAppBar: true,
            title: context.getText().add_user,
            child: Column(
              spacing: 25,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeader(context, state),
                Wrap(
                  spacing: dimensions.spacingS,
                  runSpacing: dimensions.spacingS,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: BaseTextFormField(
                        isExtraSmall: true,
                        label: context.getText().email_id,
                        editingController: _emailIdController,
                        validator: (String? val) =>
                            validationHelper.emailValidator(val, context),
                      ),
                    ),

                    GenericDropdown<NameId>(
                      formKey: _roleFieldKey,
                      items: state.roleList,
                      selectedItem: _selectedRole,
                      onChanged: (NameId? item) {
                        _selectedRole = item;
                      },
                      itemLabelBuilder: (NameId item) => item.name,
                      headerLabelBuilder: (NameId item) => item.name,
                      hintText: context.getText().role_name,
                      searchHintText: context.getText().search,
                      validator: (NameId? val) => validationHelper
                          .userRoleValidation(_selectedRole?.name, context),
                    ),
                  ],
                ),
                Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      context.getText().select_zone_and_site,
                      style: context.getStyle().bodyLarge,
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _zoneSiteErrorNotifier,
                      builder: (BuildContext context, bool value, Widget? child) {
                        if (value) {
                          return Text(
                            context.getText().please_select_site_and_zone,
                            style: context.getStyle().bodySmall?.copyWith(
                              color: context.getColor().error,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
                FilterSelectionView(
                  node: state.zoneList,
                  scrollController: _scrollController,
                  onToggleMapped: _toggleClicked,
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Row _buildHeader(BuildContext context, UserManagementSuccess state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          context.getText().user_details,
          style: context.getStyle().bodyLarge,
        ),
        PrimaryAppButton(
          isLoading: state.stateEnum == UserManagementStateEnum.submitLoading,
          onButtonTap: _onSubmitTap,
          buttonLabel: context.getText().submit,
          isSmall: true,
        ),
      ],
    );
  }

  void _onSubmitTap() {
    final bool roleValidate = _roleFieldKey.currentState?.validate() ?? false;
    final bool emailValidate = _formKey.currentState?.validate() ?? false;
    _zoneSiteErrorNotifier.value = _selectedSiteIds.isEmpty;
    if (roleValidate && emailValidate && _selectedSiteIds.isNotEmpty) {
      widget.baseRouteEntity.id != null
          ? _userManagementBloc.add(
              EditUserEvent(
                userId: widget.baseRouteEntity.id ?? '',
                email: _emailIdController.text,
                selectedSiteIdss: _selectedSiteIds.toList(),
                projectRoleId: _selectedRole?.id ?? '',
              ),
            )
          : _userManagementBloc.add(
              CreateUserEvent(
                email: _emailIdController.text,
                selectedSiteIdss: _selectedSiteIds.toList(),
                projectRoleId: _selectedRole?.id ?? '',
              ),
            );
    }
  }

  void _toggleClicked(List<String> siteIds) {
    _selectedSiteIds = siteIds.toSet();
  }
}
