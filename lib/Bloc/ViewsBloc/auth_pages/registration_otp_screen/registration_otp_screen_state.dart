abstract class RegistrationOtpScreenState {}

class RegistrationOtpScreenInitialState extends RegistrationOtpScreenState {}

class RegistrationOtpScreenLoadingState extends RegistrationOtpScreenState {}

class RegistrationOtpScreenSuccessState extends RegistrationOtpScreenState {
  final String userId;
  final String otp;

  RegistrationOtpScreenSuccessState(this.userId, this.otp);
}

class RegistrationOtpScreenErrorState extends RegistrationOtpScreenState {}
