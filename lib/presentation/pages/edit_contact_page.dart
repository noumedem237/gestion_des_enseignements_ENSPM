import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:sqflite_tutorial/models/contact.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  EditContactPage({Key key, this.contact})
      : super(
          key: key,
        );

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  var _coursController = TextEditingController();
  var _codeController = TextEditingController();
  var _heuresToDoController = TextEditingController();
  var _semestreController = TextEditingController();
  var _nomEnseignantController = TextEditingController();
  var _td = TextEditingController();
  var _tp = TextEditingController();

  var _cm = TextEditingController();
  ContactOperations contactOperations = ContactOperations();

  int i;
  String nc;
  String error = '';
  int r;
  List<Map> nomscours;
  int uniquecours = 0;

  Contact _newContact;

  @override
  void initState() {
    print("kldkd");
    _newContact = widget.contact;
    print(_newContact.nomCours);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _coursController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Nom du cours'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _codeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'code'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _heuresToDoController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'heures'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _semestreController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Semestre'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: _nomEnseignantController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'nom de Enseignant'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _cm,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'cours magistrat'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _td,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: ' Entrer TD'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _tp,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Emtrer TP'),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () async {
                _newContact = Contact(
                    nomCours: _coursController.text.isNotEmpty
                        ? _coursController.text
                        : _newContact.nomCours,
                    codeCours: _codeController.text.isNotEmpty
                        ? _codeController.text
                        : _newContact.codeCours,
                    heuresToDo: _heuresToDoController.text.isNotEmpty
                        ? int.parse(_heuresToDoController.text)
                        : _newContact.heuresToDo,
                    tp: _tp.text.isNotEmpty
                        ? int.parse(_tp.text)
                        : _newContact.tp,
                    cm: _cm.text.isNotEmpty
                        ? int.parse(_cm.text)
                        : _newContact.cm,
                    idCours: _newContact.idCours,
                    nomEnseignant: _nomEnseignantController.text.isNotEmpty
                        ? _nomEnseignantController.text
                        : _newContact.nomEnseignant,
                    semestre: _semestreController.text.isNotEmpty
                        ? int.parse(_semestreController.text)
                        : _newContact.semestre,
                    td: _td.text.isNotEmpty
                        ? int.parse(_td.text)
                        : _newContact.td);

                contactOperations.updateContact(_newContact);

                // if (_coursController.text.isEmpty) {
                // } else {
                //   _newContact = Contact(
                //     nomCours: _coursController.text,
                //   );
                //   contactOperations.updateContact(_newContact);
                //   print("nom cours ${_newContact.nomCours}");
                // }
                //
                // if (_codeController.text.isEmpty) {
                // } else {
                //   Contact contact = Contact(
                //     codeCours: _codeController.text,
                //   );
                //   contactOperations.updateContact(contact);
                // }
                //
                // if (_heuresToDoController.text.isEmpty) {
                // } else {
                //   Contact contact = Contact(
                //     heuresToDo: int.parse(_heuresToDoController.text),
                //   );
                //   contactOperations.updateContact(contact);
                //   print("nom cours ${contact.heuresToDo}");
                // }
                //
                // if (_semestreController.text.isEmpty) {
                // } else {
                //   Contact contact = Contact();
                //   contactOperations.updateContact(contact);
                // }
                //
                // if (_nomEnseignantController.text.isEmpty) {
                // } else {
                //   Contact contact = Contact();
                //   contactOperations.updateContact(contact);
                // }
                //
                // if (_cm.text.isEmpty) {
                // } else {
                //   Contact contact = Contact();
                //   contactOperations.updateContact(contact);
                // }
                //
                // if (_td.text.isEmpty) {
                // } else {
                //   Contact contact = Contact();
                //   contactOperations.updateContact(contact);
                // }
                //
                // if (_tp.text.isEmpty) {
                // } else {
                //   Contact contact = Contact(tp: int.parse(_tp.text));
                //   contactOperations.updateContact(contact);
                // }
                //snack();
              },
              child: Icon(Icons.add_task)),
        ],
      ),
    );
  }

  //
  // checkValueKeyboard({String nomCours, String codeCours, String semestre, String nomEnseignant,String heuresToDo, String cm, String td, String tp, String tpe}){
  //   final contact = Contact(
  //       nomCours: _coursController.text,
  //       codeCours: _codeController.text,
  //       heuresToDo: int.parse(_heuresToDoController.text),
  //       semestre: int.parse(_semestreController.text),
  //       nomEnseignant: _nomEnseignantController.text,
  //       cm : int.parse(_cm.text),
  //       td: int.parse(_td.text),
  //       tpe: int.parse(_tpe.text),
  //       tp: int.parse(_tp.text)
  //   );
  //   contactOperations.updateContact(contact); // envoie des infos du cours dans la table cours
  // }
  //
  // alert(){
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text("Message"),
  //           content: Text("Ce cours existe deja dans votre base de cours. Entrez en un autre"),
  //           actions: [
  //             MaterialButton(
  //               child: Center(child: Text("Ok",textScaleFactor: 2,textAlign: TextAlign.center)),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               color: Colors.lightBlueAccent,
  //             )
  //           ],
  //         );
  //       }
  //   );
  // }

  // updatetask ({String nomCours, String codeCours, String semestre, String nomEnseignant,String heuresToDo, String cm, String td, String tp}) async{
  //   final contact = Contact(
  //       nomCours: _coursController.text,
  //       codeCours: _codeController.text,
  //       heuresToDo: await int.parse(_heuresToDoController.text),
  //       semestre: int.parse(_semestreController.text),
  //       nomEnseignant: _nomEnseignantController.text,
  //       cm : int.parse(_cm.text),
  //       td: int.parse(_td.text),
  //       tp: int.parse(_tp.text)
  //   );
  //    contactOperations.updateContact(contact); // envoie des infos du cours dans la table cours
  // }

  snack() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(' Cours Modifier !'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.greenAccent,
    ));
  }
}
