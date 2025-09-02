import 'package:avk/core/extension/string.dart';
import 'package:avk/router/path_exporter.dart';

/// global instance for validation Helper class
ValidationHelper validationHelper = ValidationHelper();

/// A helper class containing common form field validators.
class ValidationHelper {
  /// Validates a user role and check if its empty.
  String? userRoleValidation(String? val, BuildContext context) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().please_select_a_role;
    }
    return null;
  }

  /// Validates a designation field (minimum 2 characters).
  String? zoneSiteNameValidator(String? val, BuildContext context,
      {bool isSite = false}) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return isSite ?  context.getText().please_enter_site_name: context.getText().please_enter_zone_name;
    } else if (regexHelper.checkMinLength(val, 3)) {
      return isSite ?  context.getText().site_length_error:context.getText().zone_length_error;
    }
    return null;
  }

  /// Validates a designation field (minimum 2 characters).
  String? roleNameValidator(String? val, BuildContext context) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().please_enter_role_name;
    } else if (regexHelper.checkMinLength(val, 2)) {
      return context.getText().role_name_minimum_error;
    }
    return null;
  }


  /// Validates the new password field.
  ///
  /// Returns an error message if empty, otherwise `null`.
  String? pressureMinValidator(String? val, BuildContext context,String maxValue) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().please_enter_value;
    }else if(val?.trim() == maxValue.trim()){
      return context.getText().min_max_cannot_be_same;
    }
    return null;
  }

  /// Validates the new password field.
  ///
  /// Returns an error message if empty, otherwise `null`.
  String? pressureMaxValidator(String? val, BuildContext context,String minValue) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().please_enter_value;
    }else if(val?.trim() == minValue.trim()){
      return context.getText().min_max_cannot_be_same;
    }else if((val?.trim()??'0').toInt() < minValue.trim().toInt()){
      return context.getText().max_cannot_be_less_than_min;
    }
    return null;
  }


  /// Validates the new password field.
  ///
  /// Returns an error message if empty, otherwise `null`.
  String? projectSettingsNameValidator(String? val, BuildContext context) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().please_enter_project_name;
    } else if (regexHelper.checkMinLength(val, 2)) {
      return context.getText().project_name_length_error;
    }
    return null;
  }

  /// Validates the new password field.
  ///
  /// Returns an error message if empty, otherwise `null`.
  String? checkIsEmptyValidator(String? val, BuildContext context,String errorLabel) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return errorLabel;
    }
    return null;
  }

  /// Validates the confirm password field.
  ///
  /// Returns an error message if empty or if it doesn't match [newPassword].
  String? registrationConfirmPasswordValidator(
      String? val,
      BuildContext context,
      String newPassword,
      ) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().required_field_error;
    } else if (val?.trim() != newPassword.trim()) {
      return context.getText().password_do_not_match;
    }
    return null;
  }

  /// Validates a mobile number based on [country]'s minimum length.
  String? mobileNumberValidator(
      String? val,
      BuildContext context,
      Country country,
      ) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().required_field_error;
    } else if (!regexHelper.checkLengthIsEqual(val, country.minLength)) {
      logger.debugLog('val ${country.minLength}',val);
      return context.getText().valid_mobile_number_error;
    }
    return null;
  }

  /// Validates a designation field (minimum 2 characters).
  String? designationValidator(String? val, BuildContext context) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().required_field_error;
    } else if (regexHelper.checkMinLength(val, 2)) {
      return context.getText().designation_name_min_length;
    }
    return null;
  }

  /// Validates an organization name (minimum 3 characters).
  String? organizationValidator(String? val, BuildContext context) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().required_field_error;
    } else if (regexHelper.checkMinLength(val, 3)) {
      return context.getText().organisation_name_min_length;
    }
    return null;
  }

  /// Validates a first name (minimum 3 characters).
  String? firstNameValidator(String? val, BuildContext context) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().required_field_error;
    } else if (regexHelper.checkMinLength(val, 3)) {
      return context.getText().first_name_min_length;
    }
    return null;
  }

  /// Validates that a project is selected.
  String? projectNameValidator(String? val, BuildContext context) {
    if (val == null) {
      return context.getText().please_select_project;
    }
    return null;
  }

  /// Validates an email address format.
  String? emailValidator(String? val, BuildContext context,{bool isCustomError = false}) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context.getText().empty_email_error;
    } else if (!regexHelper.emailValid(val ?? '')) {
      return context.getText().valid_email_error;
    } else if (isCustomError) {
      return context.getText().email_notLinked;
    }
    return null;
  }

  /// Validates a password.
  String? passwordValidator(String? val, BuildContext context,{bool isCustomError = false}) {
    if (regexHelper.checkFieldIsEmpty(val)) {
      return context
          .getText()
          .empty_password;
    }else if (isCustomError) {
      return context.getText().error_password;
    }
    return null;
  }
}
