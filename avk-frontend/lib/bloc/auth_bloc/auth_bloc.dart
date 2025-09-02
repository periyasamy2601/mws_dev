import 'package:avk/router/path_exporter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authController) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<GetProjectsEvent>(_onGetProjectsEvent);
    on<ChangeStateEvent>(_onChangeStateEvent);
    on<RegisterEvent>(_onRegisterOrResetPassword);
    on<ForgetPasswordEvent>(_onForgetPasswordEvent);
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<ResetPasswordUserEvent>(_onResetPasswordEvent);
  }

  final AuthController authController;

  final ProjectSettingsController _projectSettingsController =
      ProjectSettingsController();

  String _projectId = GetIt.I<LocalStorage>().getProjectId();

  List<NameId> _projectList = <NameId>[];

  final AppConstants _appConst = GetIt.I<AppConstants>();
  final LocalStorage _localStorge = GetIt.I<LocalStorage>();

  FutureOr<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(_emitState(AuthStateEnum.loginLoading));
    if (event.projectId.isNotEmpty) {
      _projectId = event.projectId;
    }
    logger.debugLog('_projectId$_projectId',event.projectId);
    Map<String, dynamic> body = <String, dynamic>{
      'email': event.emailId,
      'password': event.password,
    };
    await _localStorge.setProjectId(_projectId);
    final MetaEntity? response = await authController.loginController(body);
    if (response != null && response.error == null) {
      final CommonEntity commonEntity = CommonEntity.fromJson(response.data);
      await _localStorge.setToken(commonEntity.token!);
      if (commonEntity.registerStatus == RegisterEnum.pending.index) {
        await _localStorge.setIsNotRegistered(registerValue: true);
        emit(_emitState(AuthStateEnum.registerPending));
      }else if (commonEntity.status == RegisterEnum.pending.index) {
        emit(_emitState(AuthStateEnum.passwordReset));
      } else {
        emit(_emitState(AuthStateEnum.loginSuccess));
      }
    } else if (response?.error?.message?.contains(
          'This Email ID is not linked to the selected project',
        ) ??
        false) {
      emit(_emitState(AuthStateEnum.emailNotLinked));
    } else if (response?.error?.message?.contains(
          'Please enter the correct password',
        ) ??
        false) {
      emit(_emitState(AuthStateEnum.incorrectPassword));
    } else {
      emit(_emitState(AuthStateEnum.success));
    }
  }

  FutureOr<void> _onGetProjectsEvent(
    GetProjectsEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(_emitState(AuthStateEnum.projectLoading));
    final List<ProjectSettingsEntity>? response = await _projectSettingsController
        .getProjectsSettingsData();
    if(response!=null){
      if (_appConst.isAdmin) {
        _projectId = response.first.id ?? '';
      }
      _projectList = response.map((ProjectSettingsEntity e) =>
          NameId(id: e.id ?? '', name: e.name ?? '')).toList();
    }
    emit(_emitState(AuthStateEnum.success));
  }

  AuthSuccessState _emitState(AuthStateEnum authStateEnum) =>
      AuthSuccessState(authStateEnum: authStateEnum, projectList: _projectList);

  FutureOr<void> _onChangeStateEvent(
    ChangeStateEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(_emitState(AuthStateEnum.success));
  }

  FutureOr<void> _onRegisterOrResetPassword(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(_emitState(AuthStateEnum.registerLoading));
    final bool response = await authController
        .registerOrResetPasswordController(event.userEntity.toJson());
    if (response) {
      await Future.wait(<Future<void>>[
        _localStorge.setIsNotRegistered(registerValue: false),
        _localStorge.setToken(''),
      ]);
      emit(_emitState(AuthStateEnum.reLogin));
    } else {
      emit(_emitState(AuthStateEnum.success));
    }
  }

  FutureOr<void> _onForgetPasswordEvent(
    ForgetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(_emitState(AuthStateEnum.forgotPasswordLoading));
    if (event.projectId.isNotEmpty) {
      _projectId = event.projectId;
    }
    Map<String, dynamic> body = <String, dynamic>{
      'email': event.email,
      'project_id': _projectId,
    };
    await _localStorge.setProjectId(_projectId);
    final MetaEntity? response = await authController.validateUserController(
      body,
    );
    if (response != null && response.error == null) {
      emit(_emitState(AuthStateEnum.navigateToSendOtp));
    } else if (response?.error?.message?.contains(
          'This Email ID is not linked to the selected project',
        ) ??
        false) {
      emit(_emitState(AuthStateEnum.emailNotLinked));
    } else if (response?.error?.message?.contains(
          'Please reset your password at initial',
        ) ??
        false) {
      emit(_emitState(AuthStateEnum.initialSetupError));
    } else {
      emit(_emitState(AuthStateEnum.success));
    }
  }

  FutureOr<void> _onSendOtpEvent(
    SendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(_emitState(AuthStateEnum.sendOtpLoading));
    Map<String, dynamic> body = <String, dynamic>{'email': event.emailID};
    final bool response = await authController.sendOtpController(body);
    if (response) {
      emit(_emitState(AuthStateEnum.sendOtpSuccess));
    } else {
      emit(_emitState(AuthStateEnum.success));
    }
  }

  FutureOr<void> _onVerifyOtpEvent(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(_emitState(AuthStateEnum.verifyOtpLoading));
    Map<String, dynamic> body = <String, dynamic>{
      'email': event.emailID,
      'otp': event.otp.toInt(),
    };
    final MetaEntity? response = await authController.verifyOtpController(body);
    if (response != null && response.error == null) {
      emit(_emitState(AuthStateEnum.verifyOtpSuccess));
    }else if(response?.error?.message?.contains('Please try again with valid OTP')??false){
      emit(_emitState(AuthStateEnum.verifyOtpError));
    } else if(response?.error?.message?.contains('This OTP has expired.Please click Resend')??false){
      emit(_emitState(AuthStateEnum.otpExpireError));
    } else {
      emit(_emitState(AuthStateEnum.success));
    }
  }

  FutureOr<void> _onResetPasswordEvent(
    ResetPasswordUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(_emitState(AuthStateEnum.resetPasswordLoading));

    final bool response = await authController
        .registerOrResetPasswordController(event.userEntity.toJson());
    if (response) {
      emit(_emitState(AuthStateEnum.resetPasswordSuccess));
    } else {
      emit(_emitState(AuthStateEnum.success));
    }
  }
}
