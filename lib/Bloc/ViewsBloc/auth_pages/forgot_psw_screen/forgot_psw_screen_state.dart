abstract class ForgotPswScreenState {}

class ForgotPswScreenInitialState extends ForgotPswScreenState {}

class ForgotPswScreenLoadingState extends ForgotPswScreenState {}

class ForgotPswScreenSuccessState extends ForgotPswScreenState {
  final String userId;

  ForgotPswScreenSuccessState(this.userId);

}
class ForgotPswScreenErrorState extends ForgotPswScreenState {}
