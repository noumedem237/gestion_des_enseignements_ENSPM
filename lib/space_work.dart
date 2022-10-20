import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite_tutorial/presentation/pages/add__contact_page.dart';
import 'package:sqflite_tutorial/presentation/pages/contacts_page.dart';
import 'package:sqflite_tutorial/presentation/pages/search_contacts.dart';

import 'authentication/login.dart';

class Space_work extends StatefulWidget {
  const Space_work({Key key}) : super(key: key);

  @override
  _Space_workState createState() => _Space_workState();
}

class _Space_workState extends State<Space_work> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delegue',
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                //iconSize: 12.1,
                icon: Icon(Icons.logout),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Login();
                  }));
                },
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.add_task),
                  child: Text('Ajouter un cours', textAlign: TextAlign.center),
                ),
                Tab(
                    icon: Icon(Icons.dashboard),
                    child:
                        Text('Liste des cours', textAlign: TextAlign.center)),
                Tab(
                    icon: Icon(Icons.search),
                    child: Text('Rechercher un cours',
                        textAlign: TextAlign.center)),
              ],
            ),
            title: const Text('                   Espace de travail'),
          ),
          body: TabBarView(
            children: <Widget>[AddContactPage(), ContactPage(), SearchPage()],
          ),
        ),
      ),
    );
  }
}
