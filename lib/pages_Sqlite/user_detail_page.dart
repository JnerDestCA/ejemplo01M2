import 'package:flutter/material.dart';

import '../models/users_model.dart';

class UserDetailPage extends StatelessWidget {
  final UsersModel user;
  const UserDetailPage({super.key, required this.user});

  Widget item({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detalle del Usuario",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          item(icon: Icons.person, title: 'Nombre', value: user.nombres),
          item(
            icon: Icons.person_outline,
            title: 'Apellidos',
            value: user.apellidos,
          ),
          item(icon: Icons.badge, title: 'DNI', value: user.dni),
          item(icon: Icons.wc, title: 'Sexo', value: user.sexo),
          item(
            icon: Icons.calendar_month,
            title: 'Fecha de Registro',
            value: user.registro,
          ),
          item(
            icon: Icons.location_on,
            title: 'Direccion',
            value: user.direccion,
          ),
          item(icon: Icons.email, title: 'Correo', value: user.email),
        ],
      ),
    );
  }
}
