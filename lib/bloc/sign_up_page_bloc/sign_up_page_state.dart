import '../../models/app_user.dart';

abstract class SignUpPageState {}

class SignUpPageInitialState extends SignUpPageState {}

class SignUpPageLoadingState extends SignUpPageState {}

class SignUpPageSuccessState extends SignUpPageState {
  final AppUser user;

  SignUpPageSuccessState(this.user);
}

class SignUpPageErrorState extends SignUpPageState {
  final String errorMessage;

  SignUpPageErrorState(this.errorMessage);
}

class SignUpPageEmptyState extends SignUpPageState {}
