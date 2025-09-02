import 'package:avk/router/path_exporter.dart';

/// A view that handles user registration.
///
/// This screen allows new users to create an account by providing
/// necessary details such as name, email, and password.
/// It is implemented as a [StatefulWidget] to manage form state,
/// validation, and dynamic UI updates during the registration process.
class RegisterView extends StatefulWidget {
  /// Creates a new [RegisterView] instance.
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Country _country = countries.firstWhere((Country e) => e.code == 'IN');

  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _organizationNameController.dispose();
    _designationController.dispose();
    _mobileNumberController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
       if(state is AuthSuccessState) {
          _handleSuccess(state);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return BaseScaffold(
          child: AuthBaseWidget(
            showPop: false,
            label: context.getText().register,
            bottomButtonName: context.getText().save_and_continue,
            isBottomButtonLoading: state is AuthSuccessState && state.authStateEnum == AuthStateEnum.registerLoading,
            bottomButtonTap: _handleLogin,
            child: _registerView(context),
          ),
        );
      },
    );
  }

  Widget _registerView(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: dimensions.spacingM,
        children: <Widget>[
          appSvg.registerIcon,
          Text(
            context.getText().register_message,
            style: context.getStyle().labelMedium,
            textAlign: TextAlign.center,
          ),
          BaseTextFormField(
            label: context.getText().first_name,
            editingController: _firstNameController,
            inputFormatters: regexHelper.inputTextFormatters,
            maxLength: appConstants.fieldLimit32,
            validator: (String? val) =>
                validationHelper.firstNameValidator(val, context),
          ),
          BaseTextFormField(
            label: context.getText().last_name_with_optional,
            editingController: _lastNameController,
            inputFormatters: regexHelper.inputTextFormatters,
            maxLength: appConstants.fieldLimit32,
          ),
          BaseTextFormField(
            label: context.getText().organisation_name,
            editingController: _organizationNameController,
            inputFormatters: regexHelper.organizationTextFormatters,
            maxLength: appConstants.fieldLimit100,
            validator: (String? val) =>
                validationHelper.organizationValidator(val, context),
          ),
          BaseTextFormField(
            label: context.getText().designation,
            editingController: _designationController,
            inputFormatters: regexHelper.inputTextFormatters,
            maxLength: appConstants.fieldLimit32,
            validator: (String? val) =>
                validationHelper.designationValidator(val, context),
          ),
          BasePhoneField(
            country: _country,
            label: context.getText().mobile_number,
            onCountryChanged: _onCountryChanged,
            editingController: _mobileNumberController,
            inputFormatters: regexHelper.inputMobileNumberFormatters,
          ),
          BaseTextFormField(
            isPasswordField: true,
            label: context.getText().new_password,
            editingController: _newPasswordController,
            inputFormatters: regexHelper.inputPasswordFormatters,
            maxLength: appConstants.fieldLimit32,
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
            maxLength: appConstants.fieldLimit32,
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

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      UserEntity userEntity = UserEntity()
        ..lastName = _lastNameController.text
        ..organisationName = _organizationNameController.text
        ..designation = _designationController.text
        ..mobileNumber = _mobileNumberController.text.toInt()
        ..password = _confirmPasswordController.text
        ..countryCode = _country.code
        ..countryNumber = _country.dialCode.toInt()
        ..firstName = _firstNameController.text;
      _authBloc.add(RegisterEvent(userEntity: userEntity));
    }
  }

  void _onCountryChanged(Country p1) {
    _country = p1;
  }

  void _onReLoginTap() {
    GetIt.I<RouteHelper>().back();
    unawaited(GetIt.I<RouteHelper>().pushReplacementAllNamed(routerKeys.login));
  }

  void _handleSuccess(AuthSuccessState state) {
    if(state.authStateEnum == AuthStateEnum.reLogin) {
      unawaited(GetIt.I<DialogHelper>().showRegisterSuccessDialog(context,_onReLoginTap));
    }
  }
}
