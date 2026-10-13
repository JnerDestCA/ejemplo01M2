import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'screensBloc/login_screen.dart';

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
    return MaterialApp(
      //Ocultamos el banner en la esquina superior de la pantalla
      debugShowCheckedModeBanner: false,
      title: 'Login Bloc',
      //Definimos el witget que se mostrara como pantalla principal
      home: BlocProvider(
        // create: crea la instancia del login bloc
        // la cual quedara disponible para todos los witget
        create: (_) => LoginBloc(),
        //Child es una propiedad que permite acceder al loginbloc
        child: const LoginScreen(),
      ),
    );
  }
}
