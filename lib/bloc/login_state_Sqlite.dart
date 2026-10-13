import '../models/users_model.dart';

abstract class LoginState {}

//Estado inicial
class LoginInitial extends LoginState {}

//Estado de carga
class LoginLoading extends LoginState {}

//Estadp cuando el login es correcto
class LoginSuccess extends LoginState {
  //Usuario logeado

  final UsersModel user;
  LoginSuccess(this.user);
}

//Estado cuando el registro es correcto
class RegisterSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
