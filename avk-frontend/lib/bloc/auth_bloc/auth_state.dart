part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class       AuthSuccessState extends AuthState{
  AuthSuccessState({required this.authStateEnum,required this.projectList});

  final AuthStateEnum authStateEnum;
  final List<NameId> projectList;
}
