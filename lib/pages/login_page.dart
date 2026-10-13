import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc_Sqlite.dart';
import '../bloc/login_event_Sqlite.dart';
import '../bloc/login_state_Sqlite.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();
  //Liberamos memoria
  @override
  void dispose() {
    emailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  //Funcion de Login
  void login() {
    final email = emailController.text.trim();
    final password = PasswordController.text.trim();
    //validamos el campo
    if (email.isEmpty || password.isEmpty) {
      showMessage('Complete todos los campos');
      return;
    }
    context.read<LoginBloc>().add(
      LoginSubmitted(email: email, password: password),
    );
  }

  //Muestra mensaje
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  //Construimos la pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          //login Correcto
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage(user: state.user)),
            );
          }
          //Error
          if (state is LoginFailure) {
            showMessage(state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Icon(Icons.lock, size: 90, color: Colors.blueAccent),
                    const SizedBox(height: 20),
                    const Text(
                      'Login del Sistema',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                      controller: PasswordController,
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
                          onPressed: login,
                          child: const Text('Iniciar Sesion'),
                        ),
                      ),
                    const SizedBox(height: 20),
                    const Text(
                      'Usuario interno:\nadmin@gmail.com / 123456',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
