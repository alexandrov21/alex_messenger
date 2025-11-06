class SignInPageEvent {}

class CheckingUserInfoEvent extends SignInPageEvent {
  final String enteringEmail;
  final String enteringPassword;

  CheckingUserInfoEvent({
    required this.enteringEmail,
    required this.enteringPassword,
  });
}

class ResetEvent extends SignInPageEvent {}
