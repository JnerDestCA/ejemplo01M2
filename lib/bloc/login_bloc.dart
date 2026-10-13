import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copywith(email: event.email));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copywith(password: event.password));
    });
    on<LoginSubmitted>((event, emit) async {
      emit(
        state.copywith(isSubmitting: true, isFailure: false, isSuccess: false),
      );
      await Future.delayed(const Duration(seconds: 2));
      if (state.email == "jennercabelloalvarado@gmail.com" &&
          state.password == "123456") {
        emit(state.copywith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copywith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
