part of 'user_management_bloc.dart';

@immutable
sealed class UserManagementEvent {}


class GetUsersEvent extends UserManagementEvent{
  GetUsersEvent({ this.skipIndex,this.query,this.skipLimits, });

  final int? skipIndex;
  final String? query;
  final  RowPerPageEnum? skipLimits;
}

class GetUserDataEvent extends UserManagementEvent{
  GetUserDataEvent({required this.userId});

  final String userId;
}

class CreateUserEvent extends UserManagementEvent{
  CreateUserEvent({required this.email, required this.selectedSiteIdss, required this.projectRoleId});

  final String email;
  final List<String> selectedSiteIdss;
  final String projectRoleId;
}
class EditUserEvent extends UserManagementEvent{
  EditUserEvent({required this.userId, required this.email, required this.selectedSiteIdss, required this.projectRoleId});


  final String userId;
  final String email;
  final List<String> selectedSiteIdss;
  final String projectRoleId;
}

class ResetPasswordEvent extends UserManagementEvent{
  ResetPasswordEvent({required this.password, required this.email,this.userId});
  final String password;
  final String email;

  final String? userId;

}


class DeleteUserEvent extends UserManagementEvent{
  DeleteUserEvent({required this.userID});

  final String userID;
}
