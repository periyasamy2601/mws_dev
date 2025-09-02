/// user management enums
enum UserManagementStateEnum{
  ///0
  success,
  ///1
  loading,
  ///2
  error,

  /// 3
  userLoading,
  ///4
  submitLoading,
  /// 5
  successPopup,
  /// 6
  resetLoading,

  ///7
  backPop,

  ///8
  empty404
}

/// row count enum
enum RowPerPageEnum {
  ///0
  count25,
  /// 1
  count50 ,
  /// 2
  count75 ,
  /// 3
  count100 ,
}
/// row count enum
enum UserManagementPopupEnum {
  ///0
  edit,
  /// 1
  delete ,
  /// 2
  resetPassword ,
}
