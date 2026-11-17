import 'package:ejemplo01/user_Sqlite/user_bloc.dart';
import 'package:ejemplo01/user_Sqlite/user_event.dart';
import 'package:ejemplo01/user_Sqlite/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc_Sqlite.dart';
import '../bloc/login_event_Sqlite.dart';
import '../bloc/login_state_Sqlite.dart';
import '../models/users_model.dart';

class UserEditPage extends StatefulWidget {
  final UsersModel user;
  const UserEditPage({super.key, required this.user});
  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  late TextEditingController nombresController;
  late TextEditingController apellidosController;
  late TextEditingController dniController;
  late TextEditingController registroController;
  late TextEditingController direccionController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late String sexoSeleccionado;
  @override
  void initState() {
    super.initState();
    nombresController = TextEditingController(text: widget.user.nombres);
    apellidosController = TextEditingController(text: widget.user.apellidos);
    direccionController = TextEditingController(text: widget.user.direccion);
    dniController = TextEditingController(text: widget.user.dni);
    registroController = TextEditingController(text: widget.user.registro);
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: widget.user.password);
    sexoSeleccionado = widget.user.sexo;
  }

  @override
  void dispose() {
    nombresController.dispose();
    apellidosController.dispose();
    direccionController.dispose();
    dniController.dispose();
    registroController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void guardarCambios() {
    final UserEdited = UsersModel(
      id: widget.user.id,
      nombres: nombresController.text.trim(),
      apellidos: apellidosController.text.trim(),
      dni: dniController.text.trim(),
      sexo: sexoSeleccionado,
      registro: registroController.text.trim(),
      direccion: direccionController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    context.read<UserBloc>().add(UpdateUserEvent(UserEdited));
  }

  Future<void> seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (fecha != null) {
      registroController.text = '${fecha.day}/${fecha.month}/${fecha.year}';
    }
  }

  Widget campoText({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Listado de Usuarios",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Usuario Actualizado correctamente'),
              ),
            );
            Navigator.pop(context, true);
          }
          if (state is UserFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              campoText(
                controller: nombresController,
                label: 'Nombre',
                icon: Icons.person,
              ),
              campoText(
                controller: apellidosController,
                label: 'Apellidos',
                icon: Icons.person_outline,
              ),
              campoText(
                controller: dniController,
                label: 'DNI',
                icon: Icons.badge,
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: sexoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Sexo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.wc),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Masculino',
                    child: Text('Masculino'),
                  ),
                  DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
                ],
                onChanged: (value) {
                  setState(() {
                    sexoSeleccionado = value!;
                  });
                },
              ),
              const SizedBox(height: 15),
              campoText(
                controller: registroController,
                label: 'Fecha de registro',
                icon: Icons.calendar_month,
                readOnly: true,
                onTap: seleccionarFecha,
              ),
              campoText(
                controller: direccionController,
                label: 'Direccion',
                icon: Icons.location_on,
              ),
              campoText(
                controller: emailController,
                label: 'Correo',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              campoText(
                controller: passwordController,
                label: 'Contraseña',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              if (state is UserLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: guardarCambios,
                  child: const Text('Guardar Cambios'),
                ),
            ],
          );
        },
      ),
    );
  }
}
