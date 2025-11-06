abstract class SignInPageState {}

class SignInPageInitialState extends SignInPageState {}

class SignInPageLoadingState extends SignInPageState {}

class SignInPageSuccessState extends SignInPageState {}

class SignInPageErrorState extends SignInPageState {
  final String errorMessage;

  SignInPageErrorState(this.errorMessage);
}

class SignInPageEmptyState extends SignInPageState {}
