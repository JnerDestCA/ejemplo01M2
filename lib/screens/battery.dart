import 'package:flutter/material.dart';

class Battery extends StatelessWidget {
  static const String routeName = '/bateria';
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
      body: Container(child: Text("Pantalla de Bateria")),
    );
  }
}
