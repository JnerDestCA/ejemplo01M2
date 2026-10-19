import 'package:flutter/material.dart';

import '../../models/users_model.dart';
import 'login_page.dart';
import 'register_page.dart';

class HomePage extends StatelessWidget {
  //Usuario logueado
  final UsersModel user;
  const HomePage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pagina Principal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 86, 122),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('${user.nombres}'),
              accountEmail: Text('${user.email}'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 45, color: Colors.blueAccent),
              ),
              decoration: const BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Registrar Usuario'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Cerrar Sesion'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Bienvenido, ${user.nombres}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text("Dashboard"),
                subtitle: const Text("Panel del sistema"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text("Usuario"),
                subtitle: const Text("Registrar Usuario desde el Drawer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
