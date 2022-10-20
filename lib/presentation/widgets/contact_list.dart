import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:sqflite_tutorial/models/contact.dart';
import 'package:sqflite_tutorial/presentation/pages/edit_contact_page.dart';
import 'package:sqflite_tutorial/presentation/widgets/pdf.dart';

import 'generate._pdf.dart';

class ContactsList extends StatelessWidget {
  List<Contact> cours;
  ContactOperations operations = ContactOperations();
  // ContactOperations contactOperations = ContactOperations();

  ContactsList(List<Contact> this.cours, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cours.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key('${cours[index].idCours}'),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ' ${cours[index].idCours} ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ${cours[index].nomCours}  ${cours[index].codeCours}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PdfPage(
                                            cours: cours[index],
                                          )));
                            },
                            color: Colors.orange,
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            onDismissed: (direction) {
              operations.deleteCours(cours[index]);
            },
          );
        },
      ),
    );
  }
}
