import '../../models/sign_up_model.dart';

abstract class SignUpPageState {}

class SignUpPageInitialState extends SignUpPageState {}

class SignUpPageLoadingState extends SignUpPageState {}

class SignUpPageSuccessState extends SignUpPageState {
  final SignUpModel fullInfo;

  SignUpPageSuccessState(this.fullInfo);
}

class SignUpPageErrorState extends SignUpPageState {
  final String errorMessage;

  SignUpPageErrorState(this.errorMessage);
}

class SignUpPageEmptyState extends SignUpPageState {}
