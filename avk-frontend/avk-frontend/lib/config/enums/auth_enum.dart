/// auth related enums
enum AuthStateEnum{
  ///0
  loginLoading,
  ///1
  projectLoading,
  ///3
  forgotPasswordLoading,
  ///4
  success,
  ///5
  loginSuccess,
  ///6
  emailNotLinked,
  ///7
  incorrectPassword,
  ///8
  registerPending,
  ///9
  registerLoading,
  /// 10
  reLogin,
  ///11
  navigateToSendOtp,
  ///12
  initialSetupError,
  ///13
  sendOtpLoading,
  ///14
  verifyOtpLoading,
  ///15
  resetPasswordLoading,
  ///16
  sendOtpSuccess,
  ///17
  verifyOtpSuccess,
  ///18
  resetPasswordSuccess,
  ///19
  verifyOtpError,
  ///20
  otpExpireError,
  /// 30
  passwordReset,
  /// 31
  invalidMobileNumber,
}

/// register status
enum RegisterEnum{
  ///0
  pending,
  ///1
  completed,
}
