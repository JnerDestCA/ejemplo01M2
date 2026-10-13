import 'package:ejemplo01/screens/battery.dart';
import 'package:ejemplo01/screens/settings.dart';
import 'package:ejemplo01/srcTabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo01/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      //Mapeamos
      routes: <String, WidgetBuilder>{
        //Pasamos los parametros
        Settings.routeName: (BuildContext context) => Settings(),
        Battery.routeName: (BuildContext context) => Battery(),
        MyTabs.routeName: (BuildContext context) => MyTabs(),
      },
    ),
  );
}
