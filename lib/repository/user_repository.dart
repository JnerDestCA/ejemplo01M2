import '../database/database_helper.dart';
import '../models/users_model.dart';

//repositoy conecta el bloc con el SQLite
class UserRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  //Login
  Future<UsersModel?> login(String email, String password) {
    //Buscamos usuario en SQLite
    return _databaseHelper.login(email, password);
  }

  //Registro de varios usuarios
  Future<int> register(UsersModel user) async {
    //Guardamos el usuario en SQLite
    return _databaseHelper.register(user);
  }

  Future<List<UsersModel>> getUsers() {
    return _databaseHelper.getAllUsers();
  }
}
