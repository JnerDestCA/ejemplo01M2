import 'package:ejemplo01/screensBloc/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Login Exitoso")));
            Future.microtask(() {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => Home()),
                (route) => false,
              );
            });
          } else if (state.isFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Login INExitoso")));
          }
        },
        //trae un contexto y un estado
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff6a11cb), Color(0xff2575fc)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Bienvenidos",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: "Correo",
                            prefixIcon: Icon(Icons.email),
                          ),
                          //Capturamos el correo
                          onChanged: (value) => context.read<LoginBloc>().add(
                            EmailChanged(value),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Constraseña",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          onChanged: (value) => context.read<LoginBloc>().add(
                            PasswordChanged(value),
                          ),
                        ),
                        const SizedBox(height: 20),
                        state.isSubmitting
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: const Color(0xff6a11cb),
                                ),
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                    LoginSubmitted(),
                                  );
                                },
                                child: const Text(
                                  "Iniciar Sesion",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
