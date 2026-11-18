import 'package:ejemplo01/models/users_model.dart';

abstract class UserEvent {}
//Evento para cargar y listar usuarios

class LoadUsersEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final UsersModel user;
  UpdateUserEvent(this.user);
}

class DeleteUserEvent extends UserEvent {
  final int id;
  DeleteUserEvent(this.id);
}
