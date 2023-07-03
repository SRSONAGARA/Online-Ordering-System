abstract class LoginScreenState {}

class LoginScreenInitialState extends LoginScreenState {}

class LoginScreenLoadingState extends LoginScreenState {}

class LoginScreenSuccessState extends LoginScreenState {}

class LoginScreenErrorState extends LoginScreenState {}

class PasswordVisibilityChangedState extends LoginScreenState {
  final bool isObscure;

  PasswordVisibilityChangedState(this.isObscure);
}
