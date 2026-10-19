import 'package:ejemplo01/pages_Sqlite/login_page.dart';
import 'package:ejemplo01/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc_Sqlite.dart';

//Punto de entrada de la aplicacion
//Toda app en dart empieza ejecutando la funcion main()
void main() {
  //monta un widget raiz de la app en la pantalla
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    return BlocProvider(
      create: (_) => LoginBloc(userRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login Bloc Sqlite",
        home: const LoginPage(),
      ),
    );
  }
}
