import 'package:avk/router/path_exporter.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _organizationNameController =
  TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  Country _country = countries.firstWhere((Country e) => e.code == 'IN');
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _organizationNameController.dispose();
    _designationController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      hasAppBar: true,
        title: context.getText().update_profile,
        buttonLabel: context.getText().update,
        onButtonTap: _onUpdateTap,
        child: SingleChildScrollView(
          child: Column(
            spacing: dimensions.spacingM,
            children: <Widget>[
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
            ],
          ),
        )
    );
  }
  void _onCountryChanged(Country p1) {
    _country = p1;
  }
  void _onUpdateTap() {
  }
}
