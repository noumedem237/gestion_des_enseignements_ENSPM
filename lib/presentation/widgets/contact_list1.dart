import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:sqflite_tutorial/models/contact.dart';
import 'package:sqflite_tutorial/presentation/pages/edit_contact_page.dart';
import 'package:sqflite_tutorial/presentation/pages/emargement.dart';
import 'package:sqflite_tutorial/space_work.dart';

class ContactsList1 extends StatefulWidget {
  final List<Contact> cours;

  ContactsList1(this.cours, {Key key}):super(key: key);

  @override
  _ContactsList1State createState() => _ContactsList1State();
}

class _ContactsList1State extends State<ContactsList1> {
  ContactOperations operations = ContactOperations();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.cours.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5)
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        ' ${widget.cours[index].idCours} ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' ${widget.cours[index].nomCours}  ${widget.cours[index].codeCours}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {

                            setState(() {
                            });

                          Navigator.push(context, MaterialPageRoute(builder: (context) => PageEmargement(cours: widget.cours[index],)));
                          },
                          color: Colors.orange,
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
