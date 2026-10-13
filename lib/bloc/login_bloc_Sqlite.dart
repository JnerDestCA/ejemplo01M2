import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/user_repository.dart';
import 'login_state_Sqlite.dart';
import 'login_event_Sqlite.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //Repositorio para comunicarce con el Sqlite
  final UserRepository userRepository;

  LoginBloc(this.userRepository) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        //Buscamos el usuario en Sqlite
        final user = await userRepository.login(event.email, event.password);
        //Si el usuario existe
        if (user != null) {
          //Emitimos el login correcto
          emit(LoginSuccess(user));
        } else {
          emit(LoginFailure('Usuario o contraseña incorrectos'));
        }
      } catch (e) {
        //Emite un error general
        emit(LoginFailure('Error al iniciar sesión: $e'));
      }
    });
    //Evento para registrar usuario
    on<RegisterSubmitted>((event, emit) async {
      //Emitimos el estado cargando
      emit(LoginLoading());
      try {
        //Registra el usuario en Sqlite
        await userRepository.register(event.user);
        //Emite registro correcto
        emit(RegisterSuccess());
      } catch (e) {
        emit(LoginFailure('Error al registra usuario: $e'));
      }
    });
  }
}
