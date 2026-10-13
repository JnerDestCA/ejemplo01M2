import 'package:ejemplo01/screenTabs/contact.dart';
import 'package:ejemplo01/screenTabs/home.dart';
import 'package:ejemplo01/screenTabs/video.dart';
import 'package:flutter/material.dart';

class MyTabs extends StatefulWidget {
  static const String routeName = '/tabs';
  @override
  _MyTabsState createState() => new _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "VIDEO TABS",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.lightBlueAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          elevation: 4,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.ondemand_video)),
              Tab(icon: Icon(Icons.contacts)),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[Home(),Video(), Contact(), ]),
      ),
    );
  }
}
