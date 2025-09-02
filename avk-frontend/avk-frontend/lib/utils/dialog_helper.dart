import 'package:avk/router/path_exporter.dart';
import 'package:avk/screen/dashboard_view/widgets/tooltip_widget.dart';

/// A global instance of [DialogHelper] for showing various dialogs.
DialogHelper dialogHelper = DialogHelper();

/// A helper class for showing reusable dialogs across the app.
class DialogHelper {

  /// reset passwordPopup
  Future<void> resetPasswordPopup(BuildContext context,String defaultEmail) async {
    String email = defaultEmail;
    String password = '';
    return _showBaseDialog(
      context,
      StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return BlocBuilder<UserManagementBloc, UserManagementState>(
            builder: (BuildContext context, UserManagementState state) {
              if (state is UserManagementSuccess) {
                if (state.stateEnum !=
                    UserManagementStateEnum.resetLoading) {
                  email = state.email ?? '';
                  password = state.password ?? '';
                }
                return Column(
                  spacing: 15,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(context.getText().reset_password, style: context.getStyle().titleSmall),
                    _resetPasswordWidget(email,password,context,state,(){
                      GetIt.I<RouteHelper>().back();
                    })
                  ],
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }


  /// create user success popup
  Future<void> createUserSuccessPopup(BuildContext context) async {
    String email = '';
    String password = '';
    return _showBaseDialog(
      context,
      StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
              return BlocBuilder<UserManagementBloc, UserManagementState>(
                builder: (BuildContext context, UserManagementState state) {
                  if (state is UserManagementSuccess) {
                    if (state.stateEnum != UserManagementStateEnum.resetLoading) {
                      email = state.email ?? '';
                      password = state.password ?? '';
                    }
                    return Column(
                      spacing: 15,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 120,
                          child: appSvg.userCreateSuccessIcon,
                        ),
                        Text(
                          context.getText().user_created_successfully,
                          style: context.getStyle().headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                       _resetPasswordWidget(email,password,context,state,(){
                         GetIt.I<RouteHelper>().doublePop(true);
                         context.read<UserManagementBloc>().add(GetUsersEvent(skipIndex: 0));
                       })
                      ],
                    );
                  }

                  return const SizedBox();
                },
              );
            },
      ),
    );
  }

  Widget _resetPasswordWidget(String email, String password,BuildContext context, UserManagementSuccess state,void Function() onSubmitEvent){
    return Column(
      spacing: 15,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          context.getText().copy_below_credentials,
          style: context.getStyle().labelSmall,
          textAlign: TextAlign.center,
        ),
        Text(
          email,
          style: context.getStyle().titleSmall?.copyWith(
            color: context.getColor().primary,
          ),
        ),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.getText().password,
              style: context.getStyle().bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 45,
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.getColor().primaryFixedDim,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: context.getColor().primary,
                      ),
                    ),
                    child: Text(
                      password,
                      style: context.getStyle().bodySmall,
                    ),
                  ),
                ),
                if (state.stateEnum ==
                    UserManagementStateEnum.resetLoading)
                  const CircularProgressIndicator()
                else
                  BaseButton(
                      onTap: (){
                        context.read<UserManagementBloc>().add(ResetPasswordEvent(email: email,password: password));
                      },
                      child: appSvg.refreshIcon),
                BaseButton(
                  onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(text: '$email\n$password'),
                    );
                    MWSnackBar().showSnackBar(
                      context.getText().copied,
                    );
                  },
                  child: appSvg.copyIcon,
                ),
              ],
            ),
          ],
        ),
        Text(
          context.getText().share_the_credentials,
          style: context.getStyle().labelMedium,
        ),
        Row(
          spacing: dimensions.spacingM,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BaseButton(
              onTap: () {
                onSubmitEvent();
              },
              child: Text(
                context.getText().submit,
                style: context.getStyle().bodyMedium?.copyWith(
                  color: context.getColor().primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// show delete popup
  Future<void> showDeletePopup(
    String header,
    BuildContext context,
    void Function() onDeleteTap, {
    String? subtitle,
    String? content,
  }) async {
    return _showBaseDialog(
      context,
      Column(
        spacing: 25,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(header, style: context.getStyle().titleSmall),
          if (subtitle?.isNotEmpty ?? false)
            Text(subtitle!, style: context.getStyle().bodyMedium),
          if (content?.isNotEmpty ?? false)
            Text(
              content!,
              style: context.getStyle().titleSmall?.copyWith(
                color: context.getColor().primary,
              ),
            ),
          Row(
            spacing: dimensions.spacingM,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BaseButton(
                onTap: () => GetIt.I<RouteHelper>().back(),
                child: Text(
                  context.getText().cancel,
                  style: context.getStyle().bodyMedium,
                ),
              ),
              BaseButton(
                onTap: () {
                  onDeleteTap();
                  GetIt.I<RouteHelper>().back();
                },
                child: Text(
                  context.getText().delete,
                  style: context.getStyle().bodyMedium?.copyWith(
                    color: context.getColor().primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Shows a registration success dialog with a "Re-login" button.
  ///
  /// This dialog is non-dismissible and prompts the user to re-login.
  /// If the dialog is closed unexpectedly, it will be shown again.
  ///
  /// [context] - The build context for showing the dialog.
  /// [onReLoginTap- Callback executed when the "Re-login" button is tapped.
  Future<void> showAddRoleZoneDialog(
    BuildContext context,
    void Function(String name) onAddTap, {
    bool isSite = false,
    String? name,
  }) async {
    TextEditingController nameController = TextEditingController(text: name);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return _showBaseDialog(
      context,
      Column(
        spacing: 25,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            !isSite
                ? name?.isNotEmpty ?? false
                      ? context.getText().edit_zone
                      : context.getText().add_zone
                : name?.isNotEmpty ?? false
                ? context.getText().edit_site
                : context.getText().add_site,
            style: context.getStyle().headlineLarge,
          ),
          Form(
            key: formKey,
            child: BaseTextFormField(
              isSmall: true,
              label: !isSite
                  ? context.getText().zone_name
                  : context.getText().site_name,
              editingController: nameController,
              validator: (String? val) => validationHelper
                  .zoneSiteNameValidator(val, context, isSite: isSite),
              maxLength: appConstants.fieldLimit50,
              inputFormatters: regexHelper.zoneSiteNameFormatters,
            ),
          ),
          Row(
            spacing: dimensions.spacingM,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BaseButton(
                onTap: () => GetIt.I<RouteHelper>().back(),
                child: Text(
                  context.getText().cancel,
                  style: context.getStyle().bodyMedium,
                ),
              ),
              BaseButton(
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    onAddTap(nameController.text);
                    GetIt.I<RouteHelper>().back();
                  }
                },
                child: Text(
                  name?.isNotEmpty ?? false
                      ? context.getText().update
                      : context.getText().add,
                  style: context.getStyle().bodyMedium?.copyWith(
                    color: context.getColor().primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showAddRoleDialog(
    BuildContext context,
    void Function(String roleName) onAddTap,
    ValueNotifier<RoleEnum> valueNotifier, {
    String? roleName,
  }) async {
    TextEditingController roleNameController = TextEditingController(
      text: roleName,
    );
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return _showBaseDialog(
      context,
      StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  context.getText().add_role,
                  style: context.getStyle().headlineLarge,
                ),
                const SizedBox(height: 25),
                Form(
                  key: formKey,
                  child: BaseTextFormField(
                    isSmall: true,
                    label: context.getText().role_name,
                    editingController: roleNameController,
                    validator: (String? val) =>
                        validationHelper.roleNameValidator(val, context),
                    maxLength: appConstants.fieldLimit32,
                    inputFormatters: regexHelper.roleNameFormatters,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  context.getText().access_type,
                  style: context.getStyle().bodyLarge,
                ),
                const SizedBox(height: 15),
                BaseCheckBoxWidget<RoleEnum>(
                  wrapAxis: Axis.vertical,
                  spacing: dimensions.spacingXS,
                  valueNotifier: valueNotifier,
                  options: const <RoleEnum>[
                    RoleEnum.admin,
                    RoleEnum.deviceConfiguration,
                    RoleEnum.control,
                    RoleEnum.monitoringAccess,
                  ],
                  noneValue: RoleEnum.none,
                  labelBuilder: (RoleEnum type) {
                    final S texts = context.getText();
                    switch (type) {
                      case RoleEnum.admin:
                        return texts.admin;
                      case RoleEnum.deviceConfiguration:
                        return texts.device_configuration;
                      case RoleEnum.control:
                        return texts.control;
                      case RoleEnum.monitoringAccess:
                        return texts.monitoring_access;
                      case RoleEnum.none:
                      case RoleEnum.error:
                        return '';
                    }
                  },
                  toolTipBuilderBuilder: (RoleEnum type) {
                    switch (type) {
                      case RoleEnum.admin:
                        return InfoTooltipIcon(
                          tooltipText: context.getText().admin_tooltip_content,
                          tooltipKey: GlobalKey<TooltipState>(),
                        );
                      case RoleEnum.deviceConfiguration:
                        return InfoTooltipIcon(
                          tooltipText: context
                              .getText()
                              .device_config_tooltip_content,
                          tooltipKey: GlobalKey<TooltipState>(),
                        );
                      case RoleEnum.control:
                        return InfoTooltipIcon(
                          tooltipText: context
                              .getText()
                              .control_tooltip_content,
                          tooltipKey: GlobalKey<TooltipState>(),
                        );
                      case RoleEnum.monitoringAccess:
                        return InfoTooltipIcon(
                          tooltipText: context
                              .getText()
                              .monitor_access_tooltip_content,
                          tooltipKey: GlobalKey<TooltipState>(),
                        );
                      case RoleEnum.none:
                      case RoleEnum.error:
                        return const SizedBox();
                    }
                  },
                ),
                ValueListenableBuilder<RoleEnum>(
                  valueListenable: valueNotifier,
                  builder:
                      (BuildContext context, RoleEnum value, Widget? child) {
                        if (value == RoleEnum.error) {
                          return Text(
                            '(${context.getText().please_select_access_type})',
                            style: context.getStyle().bodySmall?.copyWith(
                              color: context.getColor().error,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                ),
                Row(
                  spacing: dimensions.spacingM,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    BaseButton(
                      onTap: () => GetIt.I<RouteHelper>().back(),
                      child: Text(
                        context.getText().cancel,
                        style: context.getStyle().bodyMedium,
                      ),
                    ),
                    BaseButton(
                      onTap: () {
                        if (valueNotifier.value == RoleEnum.none) {
                          valueNotifier.value = RoleEnum.error;
                        }
                        if ((formKey.currentState?.validate() ?? false) &&
                            !<RoleEnum>[
                              RoleEnum.none,
                              RoleEnum.error,
                            ].contains(valueNotifier.value)) {
                          onAddTap(roleNameController.text);
                          GetIt.I<RouteHelper>().back();
                        }
                      },
                      child: Text(
                        context.getText().add,
                        style: context.getStyle().bodyMedium?.copyWith(
                          color: context.getColor().primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Shows a registration success dialog with a "Re-login" button.
  ///
  /// This dialog is non-dismissible and prompts the user to re-login.
  /// If the dialog is closed unexpectedly, it will be shown again.
  ///
  /// [context] - The build context for showing the dialog.
  /// [onReLoginTap] - Callback executed when the "Re-login" button is tapped.
  Future<bool> showRegisterSuccessDialog(
    BuildContext context,
    void Function() onReLoginTap,
  ) async {
    final dynamic isDialogOpen = await _showBaseDialog(
      context,
      Column(
        spacing: 25,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          appSvg.successIcon,
          Text(
            context.getText().almost_done,
            style: context.getStyle().titleLarge,
          ),
          Text(
            context.getText().kindly_re_login_content,
            style: context.getStyle().bodySmall,
            textAlign: TextAlign.center,
          ),
          PrimaryAppButton(
            buttonLabel: context.getText().re_login,
            onButtonTap: onReLoginTap,
          ),
        ],
      ),
    );

    // If the dialog is dismissed unexpectedly, re-open it
    if (isDialogOpen != null && isDialogOpen is bool && isDialogOpen) {
    } else if (context.mounted) {
      unawaited(showRegisterSuccessDialog(context, onReLoginTap));
    }
    return isDialogOpen;
  }

  /// Displays a base dialog with custom [child] content.
  ///
  /// This dialog:
  /// - Is non-dismissible by tapping outside.
  /// - Has rounded corners and a maximum width constraint.
  /// - Adapts to the app's surface color.
  ///
  /// Returns the value from [showDialog] when the dialog is dismissed.
  Future<dynamic> _showBaseDialog(BuildContext context, Widget child) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: context.getColor().surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(39.76),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 443),
            child: Padding(padding: const EdgeInsets.all(35), child: child),
          ),
        );
      },
    );
  }
}
