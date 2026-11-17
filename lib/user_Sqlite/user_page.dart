import 'package:ejemplo01/user_Sqlite/user_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../user_Sqlite/user_bloc.dart';
import '../user_Sqlite/user_event.dart';
import '../user_Sqlite/user_state.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUsersEvent());
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
      body: BlocBuilder<UserBloc, UserState>(
        builder: ((context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserLoaded) {
            if (state.users.isEmpty) {
              return const Center(child: Text("No hay usuarios registrados"));
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('${user.nombres} ${user.apellidos}'),
                    subtitle: Text('DNI:${user.dni}\nCorreo:${user.email}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserEditPage(user: user),
                          ),
                        );
                        if (result == true) {
                          context.read<UserBloc>().add(LoadUsersEvent());
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }
          if (state is UserFailure) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Presiona para cargar usuario"));
        }),
      ),
    );
  }
}
