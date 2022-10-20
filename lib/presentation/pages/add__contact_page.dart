
  // page permettant de modifier les infos relatif a un cours


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:sqflite_tutorial/models/contact.dart';
import 'package:sqflite_tutorial/presentation/pages/edit_contact_page.dart';


class AddContactPage extends StatefulWidget {
  AddContactPage({Key key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
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
  String error='';
  int r;
  List<Map> nomscours;
  int uniquecours=0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _coursController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'Nom du cours'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'code'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _heuresToDoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'heures'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _semestreController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'Semestre'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: _nomEnseignantController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'nom de Enseignant'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _cm,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'cours magistrat'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _td,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: ' Entrer TD'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _tp,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'Emtrer TP'),
                ),
              ),
              SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: () async {

                  if (_coursController.text.isEmpty || _codeController.text.isEmpty || _nomEnseignantController.text.isEmpty || _semestreController.text.isEmpty || _heuresToDoController.text.isEmpty || _tp.text.isEmpty || _cm.text.isEmpty || _td.text.isEmpty ) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Erreur"),
                            content: Text("Entrez tous les champs svp."),
                            actions: [
                              MaterialButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        }
                    );
                  }else {

                    var nomsCours = await contactOperations.recupnomCours(); // recuperation de la liste totale des cours enregistrer dans la bd locale
                    nomscours = nomsCours ;
                    print("liste de cours ${nomscours}");
                    print("taille des cours enregistrer recuperer de la bd ${nomscours.length}");

                    if( nomscours.length==0){ // // s'il n'existe pas de cours dans la table cours actuelement
                      checkValueKeyboard ( // on enregistre ce cours dans la table cours
                        nomCours: _coursController.text,
                        codeCours: _codeController.text,
                        heuresToDo: _heuresToDoController.text,
                        semestre: _semestreController.text,
                        nomEnseignant: _nomEnseignantController.text,
                        cm: _cm.text,
                        td: _td.text,
                        tp: _tp.text,
                      );
                      print("insertion du cours effectuer");
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(' Cours Inserer !'),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.greenAccent,
                            )
                        );
                      // await contactOperations.insertRepetition(1); // insertion de 20 idcours cours dans la table emargement
                      // print("insertion de 5 (1) effectuer premier");
                    }else{ // s'il existe deja des cours dans la table cours
                      uniquecours=0;
                      for(int i=0;i< nomscours.length;i++) { // verifions si le cours que veut entrer l'utilisateur correspond a un cours dans la  table cours
                          print("le textfield renvoi: ${_coursController.text}");
                          print(await nomscours[i]['nomCours']);
                          if(_coursController.text== await nomscours[i]['nomCours']){
                            uniquecours = uniquecours+1;
                          }
                          print("ca a trouver une redondance ");
                          print("valeur de l'index : $uniquecours");
                      }
                      if(uniquecours==1){ // le cours qu'a entrer l'utilisateur correnspond a un cours dans la table de cours
                        print('ce cours existe deja dans la bd. entrer un autre cours svp');
                        alert();
                      }else{ //  le cours qu'a entrer l'utilisateur ne correnspond pas a un cours dans la table de cours
                        checkValueKeyboard ( // on enregistre ce cours dans la table cours
                          nomCours: _coursController.text,
                          codeCours: _codeController.text,
                          heuresToDo: _heuresToDoController.text,
                          semestre: _semestreController.text,
                          nomEnseignant: _nomEnseignantController.text,
                          cm: _cm.text,
                          td: _td.text,
                          tp: _tp.text,
                        );
                        snack();
                        print("insertion du cours effectuer");
                      }
                    }
                  }
                } ,
                  child: Icon(Icons.add)
              ),
              SizedBox(height: 50,),
              // Text('$error',textScaleFactor: 2,)
            ],
          ),
        ),
      );
  }


  checkValueKeyboard({String nomCours, String codeCours, String semestre, String nomEnseignant,String heuresToDo, String cm, String td, String tp}){
      final contact = Contact(
          nomCours: _coursController.text,
          codeCours: _codeController.text,
          heuresToDo: int.parse(_heuresToDoController.text),
          semestre: int.parse(_semestreController.text),
          nomEnseignant: _nomEnseignantController.text,
          cm : int.parse(_cm.text),
          td: int.parse(_td.text),
          tp: int.parse(_tp.text)
      );
      contactOperations.createCours(contact); // envoie des infos du cours dans la table cours
    }

  alert(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Message"),
            content: Text("Ce cours existe deja dans votre base de cours. Entrez en un autre"),
            actions: [
              MaterialButton(
                child: Center(child: Text("Ok",textScaleFactor: 2,textAlign: TextAlign.center)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.lightBlueAccent,
              )
            ],
          );
        }
    );
  }

  snack(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' Cours enregistrer !'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.greenAccent,
        )
    );
  }



}