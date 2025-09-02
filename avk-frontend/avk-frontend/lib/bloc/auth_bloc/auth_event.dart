part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginEvent({
    required this.projectId,
    required this.emailId,
    required this.password,
  });

  final String projectId;
  final String emailId;
  final String password;
}

class ForgetPasswordEvent extends AuthEvent {
  ForgetPasswordEvent({required this.email,required this.projectId, });

  final String email;
  final String projectId;
}

class GetProjectsEvent extends AuthEvent{}
class ChangeStateEvent extends AuthEvent{}

class RegisterEvent extends AuthEvent{
  RegisterEvent({required this.userEntity});

  final UserEntity userEntity;
}

class SendOtpEvent extends AuthEvent{
  SendOtpEvent({required this.emailID});

  final String emailID;
}

class VerifyOtpEvent extends AuthEvent{
  VerifyOtpEvent({required this.emailID, required this.otp});


  final String emailID;
  final String otp;
}

class ResetPasswordUserEvent extends AuthEvent{
  ResetPasswordUserEvent({required this.userEntity});

  final UserEntity userEntity;
}
