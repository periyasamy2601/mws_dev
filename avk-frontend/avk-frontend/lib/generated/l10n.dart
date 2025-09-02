// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `AVK`
  String get avk {
    return Intl.message('AVK', name: 'avk', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email ID`
  String get email_id {
    return Intl.message('Email ID', name: 'email_id', desc: '', args: []);
  }

  /// `Enter Email ID`
  String get enter_email_id {
    return Intl.message(
      'Enter Email ID',
      name: 'enter_email_id',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter Password`
  String get enter_password {
    return Intl.message(
      'Enter Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login_button {
    return Intl.message('Log In', name: 'login_button', desc: '', args: []);
  }

  /// `Please enter a valid email id`
  String get valid_email_error {
    return Intl.message(
      'Please enter a valid email id',
      name: 'valid_email_error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email ID`
  String get empty_email_error {
    return Intl.message(
      'Please enter your email ID',
      name: 'empty_email_error',
      desc: '',
      args: [],
    );
  }

  /// `This Email ID is not linked to the selected project`
  String get email_link_error {
    return Intl.message(
      'This Email ID is not linked to the selected project',
      name: 'email_link_error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password`
  String get empty_password {
    return Intl.message(
      'Please enter the password',
      name: 'empty_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the correct password`
  String get error_password {
    return Intl.message(
      'Please enter the correct password',
      name: 'error_password',
      desc: '',
      args: [],
    );
  }

  /// `Smart Water Management`
  String get smart_water_management_system {
    return Intl.message(
      'Smart Water Management',
      name: 'smart_water_management_system',
      desc: '',
      args: [],
    );
  }

  /// `Project Name`
  String get project_name {
    return Intl.message(
      'Project Name',
      name: 'project_name',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message('Search...', name: 'search', desc: '', args: []);
  }

  /// `Please select a project`
  String get please_select_project {
    return Intl.message(
      'Please select a project',
      name: 'please_select_project',
      desc: '',
      args: [],
    );
  }

  /// `Save & Continue`
  String get save_and_continue {
    return Intl.message(
      'Save & Continue',
      name: 'save_and_continue',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `You're logged in with a temporary password. Please update your details & set a new password to continue.`
  String get register_message {
    return Intl.message(
      'You\'re logged in with a temporary password. Please update your details & set a new password to continue.',
      name: 'register_message',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get required_field_error {
    return Intl.message(
      'This field is required',
      name: 'required_field_error',
      desc: '',
      args: [],
    );
  }

  /// `First Name must have at least 3 characters`
  String get first_name_min_length {
    return Intl.message(
      'First Name must have at least 3 characters',
      name: 'first_name_min_length',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Last name (optional)`
  String get last_name_with_optional {
    return Intl.message(
      'Last name (optional)',
      name: 'last_name_with_optional',
      desc: '',
      args: [],
    );
  }

  /// `Organisation Name`
  String get organisation_name {
    return Intl.message(
      'Organisation Name',
      name: 'organisation_name',
      desc: '',
      args: [],
    );
  }

  /// `Organisation must have at least 3 characters`
  String get organisation_name_min_length {
    return Intl.message(
      'Organisation must have at least 3 characters',
      name: 'organisation_name_min_length',
      desc: '',
      args: [],
    );
  }

  /// `Designation`
  String get designation {
    return Intl.message('Designation', name: 'designation', desc: '', args: []);
  }

  /// `Designation must have at least 2 characters`
  String get designation_name_min_length {
    return Intl.message(
      'Designation must have at least 2 characters',
      name: 'designation_name_min_length',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobile_number {
    return Intl.message(
      'Mobile Number',
      name: 'mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid mobile number`
  String get valid_mobile_number_error {
    return Intl.message(
      'Please enter a valid mobile number',
      name: 'valid_mobile_number_error',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'password_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgot_password_header {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password_header',
      desc: '',
      args: [],
    );
  }

  /// `Tap Send OTP and we’ll send you an OTP\nto reset your password`
  String get forgot_password_content {
    return Intl.message(
      'Tap Send OTP and we’ll send you an OTP\nto reset your password',
      name: 'forgot_password_content',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get send_otp {
    return Intl.message('Send OTP', name: 'send_otp', desc: '', args: []);
  }

  /// `Verify OTP`
  String get verify_otp {
    return Intl.message('Verify OTP', name: 'verify_otp', desc: '', args: []);
  }

  /// `We just sent a 6-digit code to your email.\nEnter it below to continue resetting your password`
  String get verify_otp_content {
    return Intl.message(
      'We just sent a 6-digit code to your email.\nEnter it below to continue resetting your password',
      name: 'verify_otp_content',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `You're almost done!✨`
  String get almost_done {
    return Intl.message(
      'You\'re almost done!✨',
      name: 'almost_done',
      desc: '',
      args: [],
    );
  }

  /// `Kindly re-login with your updated password to continue with improved security. Thank you for staying with us.`
  String get kindly_re_login_content {
    return Intl.message(
      'Kindly re-login with your updated password to continue with improved security. Thank you for staying with us.',
      name: 'kindly_re_login_content',
      desc: '',
      args: [],
    );
  }

  /// `Re-login`
  String get re_login {
    return Intl.message('Re-login', name: 're_login', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Project Settings`
  String get project_settings {
    return Intl.message(
      'Project Settings',
      name: 'project_settings',
      desc: '',
      args: [],
    );
  }

  /// `User Management`
  String get user_management {
    return Intl.message(
      'User Management',
      name: 'user_management',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Select Device Type`
  String get select_device_type {
    return Intl.message(
      'Select Device Type',
      name: 'select_device_type',
      desc: '',
      args: [],
    );
  }

  /// `Device Type`
  String get device_type {
    return Intl.message('Device Type', name: 'device_type', desc: '', args: []);
  }

  /// `OHT Inlet`
  String get oht_inlet {
    return Intl.message('OHT Inlet', name: 'oht_inlet', desc: '', args: []);
  }

  /// `OHT Outlet`
  String get oht_outlet {
    return Intl.message('OHT Outlet', name: 'oht_outlet', desc: '', args: []);
  }

  /// `DMA`
  String get dma {
    return Intl.message('DMA', name: 'dma', desc: '', args: []);
  }

  /// `Choose Units`
  String get choose_units {
    return Intl.message(
      'Choose Units',
      name: 'choose_units',
      desc: '',
      args: [],
    );
  }

  /// `Add Role`
  String get add_role {
    return Intl.message('Add Role', name: 'add_role', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Admin`
  String get admin {
    return Intl.message('Admin', name: 'admin', desc: '', args: []);
  }

  /// `Device Configuration`
  String get device_configuration {
    return Intl.message(
      'Device Configuration',
      name: 'device_configuration',
      desc: '',
      args: [],
    );
  }

  /// `Control`
  String get control {
    return Intl.message('Control', name: 'control', desc: '', args: []);
  }

  /// `Monitoring Access`
  String get monitoring_access {
    return Intl.message(
      'Monitoring Access',
      name: 'monitoring_access',
      desc: '',
      args: [],
    );
  }

  /// `Role Name`
  String get role_name {
    return Intl.message('Role Name', name: 'role_name', desc: '', args: []);
  }

  /// `Access Type`
  String get access_type {
    return Intl.message('Access Type', name: 'access_type', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Add Zone`
  String get add_zone {
    return Intl.message('Add Zone', name: 'add_zone', desc: '', args: []);
  }

  /// `Add Site`
  String get add_site {
    return Intl.message('Add Site', name: 'add_site', desc: '', args: []);
  }

  /// `Zone`
  String get zone {
    return Intl.message('Zone', name: 'zone', desc: '', args: []);
  }

  /// `Site`
  String get site {
    return Intl.message('Site', name: 'site', desc: '', args: []);
  }

  /// `Please enter the project name`
  String get please_enter_project_name {
    return Intl.message(
      'Please enter the project name',
      name: 'please_enter_project_name',
      desc: '',
      args: [],
    );
  }

  /// `Project name must have at least 2 characters`
  String get project_name_length_error {
    return Intl.message(
      'Project name must have at least 2 characters',
      name: 'project_name_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Please select device type`
  String get please_select_device_type {
    return Intl.message(
      'Please select device type',
      name: 'please_select_device_type',
      desc: '',
      args: [],
    );
  }

  /// `Flow Sensor`
  String get flow_sensor {
    return Intl.message('Flow Sensor', name: 'flow_sensor', desc: '', args: []);
  }

  /// `Flow Quantity`
  String get flow_quantity {
    return Intl.message(
      'Flow Quantity',
      name: 'flow_quantity',
      desc: '',
      args: [],
    );
  }

  /// `m³`
  String get m3 {
    return Intl.message('m³', name: 'm3', desc: '', args: []);
  }

  /// `Liters`
  String get liters {
    return Intl.message('Liters', name: 'liters', desc: '', args: []);
  }

  /// `LL`
  String get ll {
    return Intl.message('LL', name: 'll', desc: '', args: []);
  }

  /// `MLD`
  String get mld {
    return Intl.message('MLD', name: 'mld', desc: '', args: []);
  }

  /// `KL`
  String get kl {
    return Intl.message('KL', name: 'kl', desc: '', args: []);
  }

  /// `Lpm`
  String get lpm {
    return Intl.message('Lpm', name: 'lpm', desc: '', args: []);
  }

  /// `m³/hr`
  String get m3_hr {
    return Intl.message('m³/hr', name: 'm3_hr', desc: '', args: []);
  }

  /// `LPS`
  String get lps {
    return Intl.message('LPS', name: 'lps', desc: '', args: []);
  }

  /// `kL/hr`
  String get kl_hr {
    return Intl.message('kL/hr', name: 'kl_hr', desc: '', args: []);
  }

  /// `Flow Rate`
  String get flow_rate {
    return Intl.message('Flow Rate', name: 'flow_rate', desc: '', args: []);
  }

  /// `Output`
  String get output {
    return Intl.message('Output', name: 'output', desc: '', args: []);
  }

  /// `4-20 mA`
  String get ma_420 {
    return Intl.message('4-20 mA', name: 'ma_420', desc: '', args: []);
  }

  /// `RS485`
  String get rs_485 {
    return Intl.message('RS485', name: 'rs_485', desc: '', args: []);
  }

  /// `Pulse`
  String get pulse {
    return Intl.message('Pulse', name: 'pulse', desc: '', args: []);
  }

  /// `Pressure Sensor`
  String get pressure_sensor {
    return Intl.message(
      'Pressure Sensor',
      name: 'pressure_sensor',
      desc: '',
      args: [],
    );
  }

  /// `Output : 4-20 mA`
  String get output_4_20_ma {
    return Intl.message(
      'Output : 4-20 mA',
      name: 'output_4_20_ma',
      desc: '',
      args: [],
    );
  }

  /// `Pressure`
  String get pressure {
    return Intl.message('Pressure', name: 'pressure', desc: '', args: []);
  }

  /// `Bar`
  String get bar {
    return Intl.message('Bar', name: 'bar', desc: '', args: []);
  }

  /// `Kg/cm²`
  String get kg_cm {
    return Intl.message('Kg/cm²', name: 'kg_cm', desc: '', args: []);
  }

  /// `Meter`
  String get meter {
    return Intl.message('Meter', name: 'meter', desc: '', args: []);
  }

  /// `Minimum Range`
  String get minimum_range {
    return Intl.message(
      'Minimum Range',
      name: 'minimum_range',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Range`
  String get maximum_range {
    return Intl.message(
      'Maximum Range',
      name: 'maximum_range',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a value`
  String get please_enter_value {
    return Intl.message(
      'Please enter a value',
      name: 'please_enter_value',
      desc: '',
      args: [],
    );
  }

  /// `Min and Max can’t be same`
  String get min_max_cannot_be_same {
    return Intl.message(
      'Min and Max can’t be same',
      name: 'min_max_cannot_be_same',
      desc: '',
      args: [],
    );
  }

  /// `Max can’t be less than Min`
  String get max_cannot_be_less_than_min {
    return Intl.message(
      'Max can’t be less than Min',
      name: 'max_cannot_be_less_than_min',
      desc: '',
      args: [],
    );
  }

  /// `Level Sensor`
  String get level_sensor {
    return Intl.message(
      'Level Sensor',
      name: 'level_sensor',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message('Level', name: 'level', desc: '', args: []);
  }

  /// `Residual Chlorine Sensor`
  String get residual_chlorine_sensor {
    return Intl.message(
      'Residual Chlorine Sensor',
      name: 'residual_chlorine_sensor',
      desc: '',
      args: [],
    );
  }

  /// `Chlorine Quantity`
  String get chlorine_quantity {
    return Intl.message(
      'Chlorine Quantity',
      name: 'chlorine_quantity',
      desc: '',
      args: [],
    );
  }

  /// `ppm`
  String get ppm {
    return Intl.message('ppm', name: 'ppm', desc: '', args: []);
  }

  /// `mg/L`
  String get mgl {
    return Intl.message('mg/L', name: 'mgl', desc: '', args: []);
  }

  /// `m`
  String get m {
    return Intl.message('m', name: 'm', desc: '', args: []);
  }

  /// `L`
  String get l {
    return Intl.message('L', name: 'l', desc: '', args: []);
  }

  /// `An admin can add, edit, and delete users and devices, as well as view reports`
  String get admin_tooltip_content {
    return Intl.message(
      'An admin can add, edit, and delete users and devices, as well as view reports',
      name: 'admin_tooltip_content',
      desc: '',
      args: [],
    );
  }

  /// `Device Configuration can add, edit, and delete devices, as well as view reports`
  String get device_config_tooltip_content {
    return Intl.message(
      'Device Configuration can add, edit, and delete devices, as well as view reports',
      name: 'device_config_tooltip_content',
      desc: '',
      args: [],
    );
  }

  /// `They can control devices and view reports`
  String get control_tooltip_content {
    return Intl.message(
      'They can control devices and view reports',
      name: 'control_tooltip_content',
      desc: '',
      args: [],
    );
  }

  /// `Monitoring Access can only view devices and reports`
  String get monitor_access_tooltip_content {
    return Intl.message(
      'Monitoring Access can only view devices and reports',
      name: 'monitor_access_tooltip_content',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Log out`
  String get log_out {
    return Intl.message('Log out', name: 'log_out', desc: '', args: []);
  }

  /// `Update Profile`
  String get update_profile {
    return Intl.message(
      'Update Profile',
      name: 'update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Please check your internet connection`
  String get no_internet_error {
    return Intl.message(
      'Please check your internet connection',
      name: 'no_internet_error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the role name`
  String get please_enter_role_name {
    return Intl.message(
      'Please enter the role name',
      name: 'please_enter_role_name',
      desc: '',
      args: [],
    );
  }

  /// `Role name must have at least 2 characters`
  String get role_name_minimum_error {
    return Intl.message(
      'Role name must have at least 2 characters',
      name: 'role_name_minimum_error',
      desc: '',
      args: [],
    );
  }

  /// `Please select access type`
  String get please_select_access_type {
    return Intl.message(
      'Please select access type',
      name: 'please_select_access_type',
      desc: '',
      args: [],
    );
  }

  /// `Delete User`
  String get delete_user {
    return Intl.message('Delete User', name: 'delete_user', desc: '', args: []);
  }

  /// `Delete Role`
  String get delete_role {
    return Intl.message('Delete Role', name: 'delete_role', desc: '', args: []);
  }

  /// `Deleting this role will also remove all users assigned to it from this project. Are you sure you want to proceed?`
  String get delete_role_message {
    return Intl.message(
      'Deleting this role will also remove all users assigned to it from this project. Are you sure you want to proceed?',
      name: 'delete_role_message',
      desc: '',
      args: [],
    );
  }

  /// `Project Details`
  String get project_details {
    return Intl.message(
      'Project Details',
      name: 'project_details',
      desc: '',
      args: [],
    );
  }

  /// `Zone Name`
  String get zone_name {
    return Intl.message('Zone Name', name: 'zone_name', desc: '', args: []);
  }

  /// `Site Name`
  String get site_name {
    return Intl.message('Site Name', name: 'site_name', desc: '', args: []);
  }

  /// `Please enter the zone name`
  String get please_enter_zone_name {
    return Intl.message(
      'Please enter the zone name',
      name: 'please_enter_zone_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the site name`
  String get please_enter_site_name {
    return Intl.message(
      'Please enter the site name',
      name: 'please_enter_site_name',
      desc: '',
      args: [],
    );
  }

  /// `Zone name must have at least 3 characters`
  String get zone_length_error {
    return Intl.message(
      'Zone name must have at least 3 characters',
      name: 'zone_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Site name must have at least 3 characters`
  String get site_length_error {
    return Intl.message(
      'Site name must have at least 3 characters',
      name: 'site_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get add_user {
    return Intl.message('Add User', name: 'add_user', desc: '', args: []);
  }

  /// `S.No`
  String get s_no {
    return Intl.message('S.No', name: 's_no', desc: '', args: []);
  }

  /// `Roles`
  String get roles {
    return Intl.message('Roles', name: 'roles', desc: '', args: []);
  }

  /// `Edit Zone`
  String get edit_zone {
    return Intl.message('Edit Zone', name: 'edit_zone', desc: '', args: []);
  }

  /// `Edit Site`
  String get edit_site {
    return Intl.message('Edit Site', name: 'edit_site', desc: '', args: []);
  }

  /// `Delete Zone`
  String get delete_zone {
    return Intl.message('Delete Zone', name: 'delete_zone', desc: '', args: []);
  }

  /// `Deleting this zone will also remove all its dependent zones and sites. Any users assigned to these zones or sites will be unmapped, and all associated devices will be deleted. Are you sure you want to proceed?`
  String get delete_zone_content {
    return Intl.message(
      'Deleting this zone will also remove all its dependent zones and sites. Any users assigned to these zones or sites will be unmapped, and all associated devices will be deleted. Are you sure you want to proceed?',
      name: 'delete_zone_content',
      desc: '',
      args: [],
    );
  }

  /// `Delete Site`
  String get delete_site {
    return Intl.message('Delete Site', name: 'delete_site', desc: '', args: []);
  }

  /// `Any users assigned to this site will be unmapped, and all associated devices will be deleted. Are you sure you want to proceed?`
  String get delete_site_content {
    return Intl.message(
      'Any users assigned to this site will be unmapped, and all associated devices will be deleted. Are you sure you want to proceed?',
      name: 'delete_site_content',
      desc: '',
      args: [],
    );
  }

  /// `Pages`
  String get pages {
    return Intl.message('Pages', name: 'pages', desc: '', args: []);
  }

  /// `Rows Per Page`
  String get rows_per_page {
    return Intl.message(
      'Rows Per Page',
      name: 'rows_per_page',
      desc: '',
      args: [],
    );
  }

  /// `User Details`
  String get user_details {
    return Intl.message(
      'User Details',
      name: 'user_details',
      desc: '',
      args: [],
    );
  }

  /// `Select Zone & Site`
  String get select_zone_and_site {
    return Intl.message(
      'Select Zone & Site',
      name: 'select_zone_and_site',
      desc: '',
      args: [],
    );
  }

  /// `Please select a role`
  String get please_select_a_role {
    return Intl.message(
      'Please select a role',
      name: 'please_select_a_role',
      desc: '',
      args: [],
    );
  }

  /// `User has been \n🎉 successfully added!`
  String get user_created_successfully {
    return Intl.message(
      'User has been \n🎉 successfully added!',
      name: 'user_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please copy the credentials below and share them with the assigned user`
  String get copy_below_credentials {
    return Intl.message(
      'Please copy the credentials below and share them with the assigned user',
      name: 'copy_below_credentials',
      desc: '',
      args: [],
    );
  }

  /// `🔐 Share these credentials via a secure method`
  String get share_the_credentials {
    return Intl.message(
      '🔐 Share these credentials via a secure method',
      name: 'share_the_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Please select Zones & Sites`
  String get please_select_site_and_zone {
    return Intl.message(
      'Please select Zones & Sites',
      name: 'please_select_site_and_zone',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this user?`
  String get delete_user_content {
    return Intl.message(
      'Are you sure you want to delete this user?',
      name: 'delete_user_content',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get copied {
    return Intl.message('Copied', name: 'copied', desc: '', args: []);
  }

  /// `This Email ID is not linked to the selected project`
  String get email_notLinked {
    return Intl.message(
      'This Email ID is not linked to the selected project',
      name: 'email_notLinked',
      desc: '',
      args: [],
    );
  }

  /// `Please log in using the temporary password provided by your admin to set new password before using Forgot Password option`
  String get forget_password_error {
    return Intl.message(
      'Please log in using the temporary password provided by your admin to set new password before using Forgot Password option',
      name: 'forget_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Please try again with valid OTP`
  String get invalid_otp {
    return Intl.message(
      'Please try again with valid OTP',
      name: 'invalid_otp',
      desc: '',
      args: [],
    );
  }

  /// `This OTP has expired. Please click Resend`
  String get otp_expire_error {
    return Intl.message(
      'This OTP has expired. Please click Resend',
      name: 'otp_expire_error',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP in`
  String get resend_otp_in {
    return Intl.message(
      'Resend OTP in',
      name: 'resend_otp_in',
      desc: '',
      args: [],
    );
  }

  /// `sec`
  String get sec {
    return Intl.message('sec', name: 'sec', desc: '', args: []);
  }

  /// `Didn’t receive OTP?`
  String get dont_receive_otp {
    return Intl.message(
      'Didn’t receive OTP?',
      name: 'dont_receive_otp',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `No Data found`
  String get no_data_found {
    return Intl.message(
      'No Data found',
      name: 'no_data_found',
      desc: '',
      args: [],
    );
  }

  /// `Please add a Role in Project Settings`
  String get please_add_a_role_on_project_settings {
    return Intl.message(
      'Please add a Role in Project Settings',
      name: 'please_add_a_role_on_project_settings',
      desc: '',
      args: [],
    );
  }

  /// `Please add a Zone in Project Settings`
  String get please_add_a_zone_on_project_settings {
    return Intl.message(
      'Please add a Zone in Project Settings',
      name: 'please_add_a_zone_on_project_settings',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
