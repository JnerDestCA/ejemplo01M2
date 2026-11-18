abstract class AuthEvent {}

//Evento para iniciar sesión
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}

//Evento para registrar un nuevo usuario
class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  RegisterRequested({required this.email, required this.password});
}

class LogoutRequested extends AuthEvent {}
