import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUsersEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await UserRepository().getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserFailure(e.toString()));
      }
    });
  }
}
