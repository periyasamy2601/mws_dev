import 'package:avk/router/path_exporter.dart';

/// A view that handles the "Forgot Password" flow.
///
/// This screen allows the user to initiate the password reset process.
/// It takes a [BaseRouteEntity] to manage routing and navigation details.
class ResetPasswordView extends StatefulWidget {
  /// Creates a [ResetPasswordView] with the given [baseRouteEntity].
  ///
  /// [baseRouteEntity] contains routing information for navigating
  /// to and from this view.
  const ResetPasswordView({required this.baseRouteEntity, super.key});

  /// The route configuration for this view.
  final BaseRouteEntity baseRouteEntity;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  AppConstants get appConst => GetIt.I<AppConstants>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthSuccessState) {
          _handleSuccess(state);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return BaseScaffold(
          child: AuthBaseWidget(
            label: context.getText().reset_password,
            bottomButtonName: context.getText().save_and_continue,
            isBottomButtonLoading: state is AuthSuccessState && state.authStateEnum == AuthStateEnum.resetPasswordLoading,
            bottomButtonTap: _handleSaveAndContinue,
            child: _resetPasswordView(context),
          ),
        );
      },
    );
  }

  Future<void> _handleSaveAndContinue() async {
    if (_formKey.currentState?.validate() ?? false) {
      UserEntity userEntity = UserEntity()..password = _confirmPasswordController.text;
      BlocProvider.of<AuthBloc>(context).add(ResetPasswordUserEvent(userEntity: userEntity));
    }
  }

  Widget _resetPasswordView(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: dimensions.spacingM,
        children: <Widget>[
          appSvg.resetPasswordIcon,
          BaseTextFormField(
            isPasswordField: true,
            label: context.getText().new_password,
            editingController: _newPasswordController,
            inputFormatters: regexHelper.inputPasswordFormatters,
            maxLength: appConst.fieldLimit32,
            validator: (String? val) => validationHelper.checkIsEmptyValidator(
              val,
              context,
              context.getText().required_field_error,
            ),
          ),
          BaseTextFormField(
            isPasswordField: true,
            label: context.getText().confirm_password,
            editingController: _confirmPasswordController,
            inputFormatters: regexHelper.inputPasswordFormatters,
            maxLength: appConst.fieldLimit32,
            validator: (String? val) =>
                validationHelper.registrationConfirmPasswordValidator(
                  val,
                  context,
                  _newPasswordController.text,
                ),
          ),
        ],
      ),
    );
  }

  void _handleSuccess(AuthSuccessState state) {
    if(state.authStateEnum == AuthStateEnum.resetPasswordSuccess){
      unawaited(GetIt.I<RouteHelper>().pushReplacementAllNamed(routerKeys.login));
    }
  }
}
