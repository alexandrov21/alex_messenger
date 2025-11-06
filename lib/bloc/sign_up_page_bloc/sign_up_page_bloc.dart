import 'package:alex_messenger/bloc/sign_up_page_bloc/sign_up_page_event.dart';
import 'package:alex_messenger/bloc/sign_up_page_bloc/sign_up_page_state.dart';
import 'package:alex_messenger/services/auth_services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/sign_up_model.dart';

class SignUpPageBloc extends Bloc<SignUpPageEvent, SignUpPageState> {
  SignUpPageBloc() : super(SignUpPageInitialState()) {
    on<CheckingFullInfoEvent>(_onSignUpRequested);
  }

  Future<void> _onSignUpRequested(
    CheckingFullInfoEvent event,
    Emitter<SignUpPageState> emit,
  ) async {
    final fullName = event.enteringFullName.trim();
    final email = event.enteringEmail.trim();
    final password = event.enteringPassword.trim();
    final confirmPassword = event.enteringConfirmPassword.trim();
    print(
      'DEBUG signUp event -> fullName: "$fullName", email: "$email", password: "${password.isNotEmpty}", confirm: "${confirmPassword.isNotEmpty}"',
    );

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      emit(SignUpPageErrorState('Будь ласка, заповніть усі поля.'));
      return;
    }

    if (password != confirmPassword) {
      emit(SignUpPageErrorState('Паролі не співпадають.'));
      return;
    }

    emit(SignUpPageLoadingState());

    try {
      final user = await AuthService.signUp(email, password);

      if (user != null) {
        final fullInfo = SignUpModel(
          fullName: event.enteringFullName,
          email: email,
          uid: user.uid,
        );
        emit(SignUpPageSuccessState(fullInfo));
      } else {
        emit(SignUpPageErrorState('Помилка входу.'));
      }
    } catch (e) {
      emit(SignUpPageErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
