//Importamos herramientas para manejar rutas
import 'package:path/path.dart';
//importamos SQlite
import 'package:sqflite/sqflite.dart';

import '../models/users_model.dart';

//Clase que maneja SQLite

class DatabaseHelper {
  //Instancia unica
  static final DatabaseHelper instance = DatabaseHelper._internal();
  //Constructor privado
  DatabaseHelper._internal();
  //Creamos una variable para la base de datos
  static Database? _database;
  //Obtenemos la base de datos
  Future<Database> get database async {
    //Si ya existe, la retorn
    if (_database != null) return _database!;
    //Si no existe la va a crear
    _database = await _iniDatabase();
    return _database!;
  }

  Future<Database> _iniDatabase() async {
    //Ruta de SQLite
    final dbPath = await getDatabasesPath();
    //Nombre de la base de datos
    final path = join(dbPath, 'login_bloc.db');
    //Abrimos o crea la base de datos
    return await openDatabase(
      path,
      //Renombramos la version para recrear la tabla
      version: 4,
      //Creamos la base de datos
      onCreate: _onCreate,
      //Actualizamos la base de datos
      onUpgrade: _onUpgrade,
    );
  }

  //Creamos las tablas de la base de datos en SQLite
  Future<void> _onCreate(Database db, int version) async {
    //Creamos la tabla usuario
    await db.execute('''
      CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT NOT NULL,
      apellido TEXT NOT NULL,
      dni TEXT NOT NULL UNIQUE,
      sexo TEXT NOT NULL,
      registro TEXT NOT NULL,
      direccion TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL
      )
''');

    //Creamos un usuario interno para poder ingresar al app
    await db.insert('users', {
      'nombre': 'Jenner',
      'apellido': 'Cabello',
      'dni': '71530870',
      'sexo': 'Masculino',
      'registro': '22334455',
      'direccion': 'Huacho',
      'email': 'jennerc@gmail.com',
      'password': '123456789',
    });
  }

  //Actualizamos la base de datos cuando cambiamos de version
  Future<void> _onUpgrade(Database db, int oldVersion, int newversion) async {
    //Borramos la tabla anterior
    await db.execute('DROP TABLE IF EXISTS users');
    //Volvemos a crear la tabla con el usuario administrador
    await _onCreate(db, newversion);
  }

  Future<int> register(UsersModel user) async {
    final db = await database;
    //Insertamos el usuario
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  //Login con email y constraseña
  Future<UsersModel?> login(String email, String password) async {
    //Obtiene la base de datos
    final db = await database;
    //Buscamos el usuario por email y password
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    //Si encontramos el usuario, lo retornamos
    if (result.isNotEmpty) {
      return UsersModel.fromMap(result.first);
    }
    //Si no encontramos el usuario, retornamos null
    return null;
  }

  Future<List<UsersModel>> getAllUsers() async {
    final db = await database;
    final result = await db.query('users');
    return result.map((map) => UsersModel.fromMap(map)).toList();
  }
}
