abstract class RegistrationScreenState {}

class RegistrationScreenInitialState extends RegistrationScreenState {}

class RegistrationScreenLoadingState extends RegistrationScreenState {}

class RegistrationScreenSuccessState extends RegistrationScreenState {
  final String userId;

  RegistrationScreenSuccessState(this.userId);

}

class RegistrationScreenErrorState extends RegistrationScreenState {}

class PasswordVisibilityChangedState extends RegistrationScreenState {
  final bool isObscure;

  PasswordVisibilityChangedState(this.isObscure);
}
