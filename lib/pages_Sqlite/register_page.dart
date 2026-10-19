import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc_Sqlite.dart';
import '../bloc/login_event_Sqlite.dart';
import '../bloc/login_state_Sqlite.dart';
import '../models/users_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  final dnaiController = TextEditingController();
  final registroController = TextEditingController();
  final direccionController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String sexoSeleccionado = 'Masculino';
  //Liberamos memoria cuando se cierra la pantalla
  @override
  void dispose() {
    nombresController.dispose();
    apellidosController.dispose();
    dnaiController.dispose();
    registroController.dispose();
    direccionController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //Funsion para registrar un usuario
  void _registrarUsuario() {
    final nombres = nombresController.text.trim();
    final apellidos = apellidosController.text.trim();
    final dni = dnaiController.text.trim();
    final registro = registroController.text.trim();
    final direccion = direccionController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    //valida que ningun campo este vacio
    if (nombres.isEmpty ||
        apellidos.isEmpty ||
        dni.isEmpty ||
        registro.isEmpty ||
        direccion.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      mostrarMensaje('Complete todos los campos');
      return;
    }
    //Creamos el objeto usuario
    final user = UsersModel(
      nombres: nombres,
      apellidos: apellidos,
      dni: dni,
      sexo: sexoSeleccionado,
      registro: registro,
      direccion: direccion,
      email: email,
      password: password,
    );
    //Enviamos el evento de registro al bloc
    context.read<LoginBloc>().add(RegisterSubmitted(user: user));
  }

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  //Permite seleccionar fecha
  Future<void> seleccionarFecha() async {
    //Abre el calendario
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    //Si selecciono una fecha
    if (fecha != null) {
      //Guarda la fecha en el controlador
      registroController.text = '${fecha.day}/${fecha.month}/${fecha.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    //Estructura base
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registrar Usuario",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            mostrarMensaje('Usuario registrado correctamente');
            //regresa al login
            Navigator.pop(context);
          }
          //Si ocurre un error
          if (state is LoginFailure) {
            mostrarMensaje(state.message);
          }
        },
        //Creamos un builder para dibujar la pantalla
        builder: (context, state) {
          //Agregamos 1 espacio alrededor
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Icono de registro
                  const Icon(
                    Icons.person_add,
                    size: 80,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nombresController,
                    decoration: const InputDecoration(
                      labelText: 'Nombres',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: apellidosController,
                    decoration: const InputDecoration(
                      labelText: 'Apellidos',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: dnaiController,
                    decoration: const InputDecoration(
                      labelText: 'Dni',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.badge),
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: sexoSeleccionado,
                    decoration: const InputDecoration(
                      labelText: 'Apellidos',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Masculino',
                        child: Text('Masculino'),
                      ),
                      DropdownMenuItem(
                        value: 'Femenino',
                        child: Text('Femenino'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        sexoSeleccionado = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: registroController,
                    readOnly: true,
                    onTap: seleccionarFecha,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Registro',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: direccionController,
                    decoration: const InputDecoration(
                      labelText: 'Direccion',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (state is LoginLoading)
                    const CircularProgressIndicator()
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _registrarUsuario,
                        child: const Text('Registrar Usuario'),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
