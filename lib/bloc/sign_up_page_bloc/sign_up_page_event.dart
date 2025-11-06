class SignUpPageEvent {}

class CheckingFullInfoEvent extends SignUpPageEvent {
  final String enteringFullName;
  final String enteringEmail;
  final String enteringPassword;
  final String enteringConfirmPassword;

  CheckingFullInfoEvent({
    required this.enteringFullName,
    required this.enteringEmail,
    required this.enteringPassword,
    required this.enteringConfirmPassword,
  });
}

class ResetEvent extends SignUpPageEvent {}
