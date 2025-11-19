import 'package:alex_messenger/models/app_user.dart';

abstract class SignInPageState {}

class SignInPageInitialState extends SignInPageState {}

class SignInPageLoadingState extends SignInPageState {}

class SignInPageSuccessState extends SignInPageState {
  final AppUser user;

  SignInPageSuccessState(this.user);
}

class SignInPageErrorState extends SignInPageState {
  final String errorMessage;

  SignInPageErrorState(this.errorMessage);
}

class SignInPageEmptyState extends SignInPageState {}
