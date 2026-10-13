import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pagina Principal",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight(20)),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
      ),
      //Es como una barra lateral creo
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                "Menu de Opciones",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Inicio')),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuracion'),
            ),
          ],
        ),
      ),
      body: const Center(child: Text("Bienvenido a la pagina Principal")),
    );
  }
}
