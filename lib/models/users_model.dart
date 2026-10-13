//Modelo que representa al usuario
class UsersModel {
  final int? id;
  final String nombres;
  final String apellidos;
  final String dni;
  final String sexo;
  final String registro;
  final String direccion;
  final String email;
  final String password;
  //creamos constructor
  UsersModel({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.sexo,
    required this.registro,
    required this.direccion,
    required this.email,
    required this.password,
  });

  //Convierte el objeto UserModel a Map para SQLite
  Map<String, dynamic> toMap() {
    //Retorna lo datos como maps
    return {
      'id': id,
      'nombre': nombres,
      'apellido': apellidos,
      'dni': dni,
      'sexo': sexo,
      'registro': registro,
      'direccion': direccion,
      'email': email,
      'password': password,
    };
  }

  //Convierte un Map a un objeto UserModel
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'],
      nombres: map['nombre'],
      apellidos: map['apellido'],
      dni: map['dni'],
      sexo: map['sexo'],
      registro: map['registro'],
      direccion: map['direccion'],
      email: map['email'],
      password: map['password'],
    );
  }
}
