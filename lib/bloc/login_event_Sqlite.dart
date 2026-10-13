import '../models/users_model.dart';

abstract class LoginEvent {}

//Evento para iniciar sesión
class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  LoginSubmitted({required this.email, required this.password});
}

//Evento para registrar un nuevo usuario
class RegisterSubmitted extends LoginEvent {
  final UsersModel user;
  RegisterSubmitted({required this.user});
}
