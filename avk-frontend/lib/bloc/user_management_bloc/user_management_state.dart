part of 'user_management_bloc.dart';

@immutable
sealed class UserManagementState {}

final class UserManagementInitial extends UserManagementState {}

final class UserManagementSuccess extends UserManagementState {
  UserManagementSuccess({
    required this.stateEnum,
    required this.totalUserCount,
    required this.skipLimits,
    required this.selectedIndex,
    required this.roleList,
    required this.selectedUserRole,
    required this.zoneList,
    required this.user,
    required this.userList,
    required this.skipValue,
    this.password,
    this.email,
  });

  final UserManagementStateEnum stateEnum;
  final int totalUserCount;
  final RowPerPageEnum skipLimits;

  final int selectedIndex;

  /// List of roles available in the project settings.
  final List<NameId> roleList;

  /// List of zones represented as a tree structure.
  final List<TreeNode<UserName>> zoneList;

  /// user Entity contains all the user related content
  final UserEntity user;

  /// selected Role
  final NameId? selectedUserRole;

  /// email
  final String? email;

  /// password
  final String? password;

  final List<UserEntity> userList;
  final int skipValue;
}
