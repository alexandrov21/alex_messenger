import 'package:alex_messenger/bloc/sign_in_page_bloc/sign_in_page_event.dart';
import 'package:alex_messenger/bloc/sign_in_page_bloc/sign_in_page_state.dart';
import 'package:alex_messenger/services/auth_services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_services/firebase_service.dart';

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  SignInPageBloc() : super(SignInPageInitialState()) {
    on<CheckingUserInfoEvent>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    CheckingUserInfoEvent event,
    Emitter<SignInPageState> emit,
  ) async {
    final email = event.enteringEmail.trim();
    final password = event.enteringPassword.trim();

    if (email.isEmpty || password.isEmpty) {
      emit(SignInPageErrorState('Будь ласка, заповніть усі поля.'));
      return;
    }

    emit(SignInPageLoadingState());

    try {
      final user = await AuthService.signIn(email, password);

      if (user != null) {
        final userFromFirestore = await FirebaseService.getUserByUid(user.uid);
        if (userFromFirestore == null) {
          emit(SignInPageErrorState("Профіль не знайдено"));
          return;
        }
        emit(SignInPageSuccessState(userFromFirestore));
      } else {
        emit(SignInPageErrorState('Помилка входу.'));
      }
    } catch (e) {
      emit(SignInPageErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
