import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  var header = DrawerHeader(child: Text("Ajustes"));
  Drawer getDrawer(BuildContext context) {
    ListTile getItem(Icon icon, String description, String route) {
      return ListTile(
        leading: icon,
        title: Text(description),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, route);
        },
      );
    }

    ListView getList() {
      return ListView(
        children: <Widget>[
          header,
          getItem(Icon(Icons.settings), 'Configuracion', '/configuracion'),
          getItem(Icon(Icons.home), 'Pagina Principal', ''),
          getItem(Icon(Icons.battery_charging_full), "Bateria", '/bateria'),
          getItem(Icon(Icons.tab_sharp), "tabs", '/tabs'),
        ],
      );
    }

    return Drawer(child: getList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pagina Principal",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: getDrawer(context),
    );
  }
}
