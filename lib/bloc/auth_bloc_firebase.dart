import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event_firebase.dart';
import 'auth_state_firebase.dart';
import '../firebase_auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //Repositorio para comunicarce con el Sqlite
  final FirebaseAuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        //Buscamos el usuario en Sqlite
        await authRepo.signIn(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        //Emite un error general
        emit(AuthFailure("Error de Login: ${e.toString()}"));
      }
    });
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        //Buscamos el usuario en Sqlite
        await authRepo.register(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        //Emite un error general
        emit(AuthFailure("Error en el register: ${e.toString()}"));
      }
    });
    on<LogoutRequested>((event, emit) async {
      await authRepo.signOut();
      emit(AuthInitial());
    });
  }
}
