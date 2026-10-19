import '../models/users_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

//Estado de carga
class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UsersModel> users;
  UserLoaded(this.users);
}

class UserFailure extends UserState {
  final String message;
  UserFailure(this.message);
}
