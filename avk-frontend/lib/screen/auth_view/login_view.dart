import 'package:avk/router/path_exporter.dart';

/// A view that handles the user login process.
///
/// This screen allows users to enter their credentials and sign in.
/// It is implemented as a [StatefulWidget] to manage form state,
/// validation, and any interactive UI changes during login.
class LoginView extends StatefulWidget {
  /// Creates a new [LoginView] instance.
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthBloc _authBloc;
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<dynamic>> _emailFieldKey =
      GlobalKey<FormFieldState<dynamic>>();
  final GlobalKey<FormFieldState<dynamic>> _projectNameFieldKey =
      GlobalKey<FormFieldState<dynamic>>();
  final GlobalKey<FormFieldState<dynamic>> _passwordFieldKey =
      GlobalKey<FormFieldState<dynamic>>();

  AppConstants get appConst => GetIt.I<AppConstants>();

  NameId? _selectedRole;

  @override
  void dispose() {
    _emailIdController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _authBloc = BlocProvider.of(context);
    _authBloc.add(GetProjectsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is AuthSuccessState && state.projectList.isNotEmpty) {
          return BaseScaffold(
            child: AuthBaseWidget(
              isPrimaryButton: true,
              bottomButtonName: context.getText().login_button,
              isBottomButtonLoading:
                  state.authStateEnum == AuthStateEnum.loginLoading,
              bottomButtonTap: _handleLogin,
              child: _loginView(context, state),
            ),
          );
        }
        return const AppLoader();
      },
      listener: (BuildContext context, AuthState state) {
        if (state is AuthSuccessState) {
          _handleSuccess(state);
        }
      },
    );
  }

  Widget _loginView(BuildContext context, AuthSuccessState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: dimensions.spacingM,
        children: <Widget>[
          Column(
            // spacing: dimensions.spacingXL,
            children: <Widget>[
              appSvg.authAppBar,
              SizedBox(height: dimensions.spacingXL),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.getText().login,
                  style: context.getStyle().displaySmall?.copyWith(
                    color: context.getColor().primary,
                  ),
                ),
              ),
              SizedBox(height: dimensions.spacingS),
            ],
          ),
          if (!appConst.isAdmin)
            GenericDropdown<NameId>(
              maxWidth: double.infinity,
              formKey: _projectNameFieldKey,
              items: state.projectList,
              selectedItem: _selectedRole,
              onChanged: _onChanged,
              itemLabelBuilder: (NameId item) => item.name,
              headerLabelBuilder: (NameId item) => item.name,
              hintText: context.getText().project_name,
              searchHintText: context.getText().search,
              validator: (NameId? val) => validationHelper.projectNameValidator(
                _selectedRole?.name,
                context,
              ),
            ),
          BaseTextFormField(
            formKey: _emailFieldKey,
            label: context.getText().email_id,
            hintText: context.getText().enter_email_id,
            editingController: _emailIdController,
            inputFormatters: regexHelper.inputEmailFormatters,
            maxLength: appConst.fieldLimit100,
            validator: (String? val) => validationHelper.emailValidator(
              val,
              context,
              isCustomError:
                  state.authStateEnum == AuthStateEnum.emailNotLinked,
            ),
          ),
          BaseTextFormField(
            formKey: _passwordFieldKey,
            isPasswordField: true,
            label: context.getText().password,
            hintText: context.getText().enter_password,
            editingController: _passwordController,
            inputFormatters: regexHelper.inputPasswordFormatters,
            maxLength: appConst.fieldLimit32,
            validator: (String? val) => validationHelper.passwordValidator(
              val,
              context,
              isCustomError:
                  state.authStateEnum == AuthStateEnum.incorrectPassword,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: BaseButton(
              onTap: _handleForgotPassword,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    context.getText().forgot_password,
                    style: context.getStyle().labelMedium?.copyWith(
                      color: context.getColor().primary,
                      decoration: TextDecoration.underline,
                      decorationColor: context.getColor().primary,
                    ),
                  ),
                  if (state.authStateEnum ==
                      AuthStateEnum.forgotPasswordLoading)
                    const AppLoader(
                      isSmall: true,
                      alignment: Alignment.centerRight,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleForgotPassword() async {
    final bool isEmailValidated =
        _emailFieldKey.currentState?.validate() ?? false;
    bool isProjectNameValidated = true;

    if (!appConst.isAdmin) {
      isProjectNameValidated =
          _projectNameFieldKey.currentState?.validate() ?? false;
    }

    if (isEmailValidated && isProjectNameValidated) {
      _authBloc.add(
        ForgetPasswordEvent(
          projectId: _selectedRole?.id ?? '',
          email: _emailIdController.text,
        ),
      );
    }
  }

  Future<void> _handleLogin() async {
    final bool isEmailValidated =
        _emailFieldKey.currentState?.validate() ?? false;
    final bool isPasswordValidated =
        _passwordFieldKey.currentState?.validate() ?? false;
    bool isProjectNameValidated = true;

    if (!appConstants.isAdmin) {
      isProjectNameValidated =
          _projectNameFieldKey.currentState?.validate() ?? false;
    }

    if (isEmailValidated && isPasswordValidated && isProjectNameValidated) {
      _authBloc.add(
        LoginEvent(
          projectId: _selectedRole?.id ?? '',
          emailId: _emailIdController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _onChanged(NameId? item) {
    _selectedRole = item;
  }

  void _handleSuccess(AuthSuccessState state) {
    if (<AuthStateEnum>[
      AuthStateEnum.emailNotLinked,
    ].contains(state.authStateEnum)) {
      Future<dynamic>.delayed(const Duration(milliseconds: 200), () {
        _emailFieldKey.currentState?.validate();
        _authBloc.add(ChangeStateEvent());
      });
    } else if (<AuthStateEnum>[
      AuthStateEnum.incorrectPassword,
    ].contains(state.authStateEnum)) {
      Future<dynamic>.delayed(const Duration(milliseconds: 200), () {
        _passwordFieldKey.currentState?.validate();
        _authBloc.add(ChangeStateEvent());
      });
    } else if (state.authStateEnum == AuthStateEnum.registerPending) {
      unawaited(
        GetIt.I<RouteHelper>().pushReplacementNamed(routerKeys.register),
      );
    }  else if (state.authStateEnum == AuthStateEnum.passwordReset) {
      unawaited(
        GetIt.I<RouteHelper>().pushNamed(
          routerKeys.resetPassword,
        ),
      );
    } else if (state.authStateEnum == AuthStateEnum.loginSuccess) {
      unawaited(
        GetIt.I<RouteHelper>().pushReplacementNamed(
          BaseRouter().initialRoute(),
        ),
      );
    } else if (state.authStateEnum == AuthStateEnum.initialSetupError) {
      MWSnackBar().showSnackBar(
        context.getText().forget_password_error,
        width: 500,
      );
    } else if (state.authStateEnum == AuthStateEnum.navigateToSendOtp) {
      unawaited(
        GetIt.I<RouteHelper>().pushNamed(
          routerKeys.forgetPassword,
          params: BaseRouteEntity(email: _emailIdController.text),
        ),
      );
    }
  }
}
