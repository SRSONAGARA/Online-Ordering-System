abstract class ForgotPswOtpScreenState {}

class ForgotPswOtpScreenInitialState extends ForgotPswOtpScreenState {}

class ForgotPswOtpScreenLoadingState extends ForgotPswOtpScreenState {}

class ForgotPswOtpScreenSuccessState extends ForgotPswOtpScreenState {
  final String userId;
  final String otp;

  ForgotPswOtpScreenSuccessState(this.userId, this.otp);

}

class ForgotPswOtpScreenErrorState extends ForgotPswOtpScreenState {}
