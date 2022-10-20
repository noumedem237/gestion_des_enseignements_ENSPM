import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:sqflite_tutorial/main.dart';
import 'package:sqflite_tutorial/models/contact.dart';
import 'dart:convert';
import 'dart:ui';
import 'login.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  Register();
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String matriculeD;
  String emailD;
  String error = '';

  @override
  Widget build(BuildContext context) {
    ContactOperations contactoperations =
        new ContactOperations(); // c'est important que ce soit apres le builcontext et l'instantiation
    var _nomDelegue = TextEditingController();
    var _matriculeDelegue = TextEditingController();
    var _emailDelegue = TextEditingController();
    var _passwordDelegue = TextEditingController();
    var _niveauDelegue = TextEditingController();
    var _cycleDelegue = TextEditingController();
    var _filiereDelegue = TextEditingController();
    var _departement = TextEditingController();
    var _optionDelegue = TextEditingController();
    var _confirmPassText = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            }));
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: _nomDelegue,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'nom du delegue'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _matriculeDelegue,
                      decoration: InputDecoration(
                          icon: Icon(Icons.drive_file_rename_outline_sharp),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'matricule du delegue'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailDelegue,
                      decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'email du delegue'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordDelegue,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      obscureText: true,
                      controller: _confirmPassText,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'confirm password'),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _niveauDelegue,
                        decoration: InputDecoration(
                            icon: Icon(Icons.drive_file_rename_outline_sharp),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            labelText: 'niveau du delegue'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _cycleDelegue,
                      decoration: InputDecoration(
                          icon: Icon(Icons.drive_file_rename_outline_sharp),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'cycle du delegue'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _filiereDelegue,
                      decoration: InputDecoration(
                          icon: Icon(Icons.drive_file_rename_outline_sharp),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'filiere du delegue'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _departement,
                      decoration: InputDecoration(
                          icon: Icon(Icons.drive_file_rename_outline_sharp),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'departement'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _optionDelegue,
                      decoration: InputDecoration(
                          icon: Icon(Icons.drive_file_rename_outline_sharp),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'option du delegue'),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.green,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    // color: Colors.redAccent.withOpacity(.7),
                    onPressed: () async {
                      String err = "";
                      int idDelegueInternet;

                      if (_nomDelegue.text.isEmpty ||
                          _matriculeDelegue.text.isEmpty ||
                          _emailDelegue.text.isEmpty ||
                          _passwordDelegue.text.isEmpty ||
                          _cycleDelegue.text.isEmpty ||
                          _niveauDelegue.text.isEmpty ||
                          _filiereDelegue.text.isEmpty ||
                          _departement.text.isEmpty ||
                          _optionDelegue.text.isEmpty ||
                          _confirmPassText.text.isEmpty) {
                        showDialog(
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
                            });
                      } else {
                        if (_passwordDelegue.text != _confirmPassText.text) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Erreur"),
                                  content: Text(
                                      " Les mots de pass sont differents "),
                                  actions: [
                                    MaterialButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        } else {
                          var data = await contactoperations.getDelegue();
                          List<Delegue> t = await data as List<Delegue>;
                          print("Liste eeee des delegues sqflite  $t");
                          // print("taille des delegues sqflite  ${t.length}");
                          if (t == null) {
                            // verifie.........
                            print(" t vaut $t");
                            final response = await http.post(
                                Uri.parse(
                                    'http://192.168.5.1/article/register.php'),
                                body: {
                                  "nomDelegue": _nomDelegue.text,
                                  "matriculeDelegue": _matriculeDelegue.text,
                                  "emailDelegue": _emailDelegue.text,
                                  "passwordDelegue": _passwordDelegue.text,
                                  "niveauDelegue": _niveauDelegue.text,
                                  "cycleDelegue": _cycleDelegue.text,
                                  "filiereDelegue": _filiereDelegue.text,
                                  "optionDelegue": _optionDelegue.text,
                                  "departement": _departement.text
                                });
                            if (response == null) {
                              alertt(
                                  "Desolé ! Vous n'êtes pas connecte a Internet");
                            } else {
                              if (response.statusCode == 200) {
                                // voit si on peur faire un else pour dire qu'il n'y a pas internet
                                print(
                                    "valeur de la reponse sans decodage: ${response.body}");
                                String b = response.body;
                                dynamic data = await json.decode(b);
                                print(
                                    "valeur de la reponse apres decodage: ${data}");
                                dynamic result = await data['data'];
                                print(
                                    "le corps relle de la reponse apres decodage: ${result}");
                                int succes = await result[1];
                                print(
                                    "indicateur sur l'etat de l'utilisateur: ${succes}");

                                if (succes == 1) {
                                  // register  ok
                                  err = await result[0];
                                  print("erreur: ${err}");
                                  idDelegueInternet = int.parse(await result[
                                      2]); // recuperation de l'id du delegue enregistrer dans la bd en ligne
                                  print(
                                      "idDelegueInternet: ${idDelegueInternet}");
                                  // var delegue = new Delegue(
                                  //   idDelegue: idDelegueInternet, // on insere l'id du delegue qui est stocker au net dans la bd locale
                                  //   nomDelegue: _nomDelegue.text,
                                  //   matriculeDelegue: _matriculeDelegue.text,
                                  //   emailDelegue: _emailDelegue.text,
                                  //   passwordDelegue: _passwordDelegue.text,
                                  //   niveauDelegue: int.parse(_niveauDelegue.text),
                                  //   cycleDelegue: _cycleDelegue.text,
                                  //   filiereDelegue: _filiereDelegue.text,
                                  //   departement: _departement.text,
                                  //   optionDelegue: _optionDelegue.text,
                                  // );

                                  await contactoperations.createDelegue(
                                      idDelegueInternet,
                                      _nomDelegue.text,
                                      _matriculeDelegue.text,
                                      _emailDelegue.text,
                                      _passwordDelegue.text,
                                      int.parse(_niveauDelegue.text),
                                      _cycleDelegue.text,
                                      _filiereDelegue.text,
                                      _departement.text,
                                      _optionDelegue
                                          .text); // inserer un delegue dans la bd

                                  print(
                                      "la lise id de delegue ${idDelegueInternet}");
                                  print(
                                      "la lise nom de delegue ${_nomDelegue.text}");
                                  print(
                                      "la lise email de delegue ${_emailDelegue.text}");
                                  print(
                                      "la lise maricule de delegue ${_matriculeDelegue.text}");
                                  print(
                                      "la lise id de delegue ${_optionDelegue.text}");
                                  print(
                                      "la lise niveau de delegue ${_niveauDelegue.text}");
                                  print(
                                      "Infos d'\inscription enregistrée dans la bd locale et en ligne ");
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return Login();
                                  }));
                                  alertt(
                                      " Enregistrement reussi ! Log in online OK ");
                                } else {
                                  // register  not ok
                                  err = await result[
                                      0]; // err= "email arealy exist"; ou "error register" ou "error empty data"
                                  print("erreur: ${err}");

                                  print("error rhggchhghegister ");
                                  if (err == "emailarealyexist") {
                                    alertt(" email arealy exist online ");
                                    print("err original : $err");
                                    print("email arealy exist online ");
                                  }
                                  if (err == "errorregister") {
                                    alertt(" error register ");
                                    print("err original : $err");
                                    print("error register ");
                                  }
                                  if (err == "erroremptydata") {
                                    alertt(" error empty data ");
                                    print("error empty data $err");
                                    print("error empty data ");
                                  }
                                  if (err == "") {
                                    alertt(" connexion data ");
                                  }
                                }
                              }
                            }
                            //
                            //
                            //
                            //
                            // if (err == "succesregister") {
                            //   // var delegue = new Delegue(
                            //   //   idDelegue: idDelegueInternet,
                            //   //   // on insere l'id du delegue qui est stocker au net dans la bd locale
                            //   //   nomDelegue: _nomDelegue.text,
                            //   //   matriculeDelegue: _matriculeDelegue.text,
                            //   //   emailDelegue: _emailDelegue.text,
                            //   //   passwordDelegue: _passwordDelegue.text,
                            //   //   niveauDelegue: int.parse(_niveauDelegue.text),
                            //   //   cycleDelegue: _cycleDelegue.text,
                            //   //   filiereDelegue: _filiereDelegue.text,
                            //   //   departement: _departement.text,
                            //   //   optionDelegue: _optionDelegue.text,
                            //   // );
                            //   // await contactoperations.createDelegue(delegue); // inserer un delegue dans la bd
                            //   // print("Infos d'\inscription enregistrée dans la bd locale et en ligne ");
                            //   // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {return Login();}));
                            //   // alertt(" Enregistrement reussi ! Log in online OK ");
                            // } else {
                            //   // print("error rhggchhghegister ");
                            //   // if(err=="emailarealyexist"){
                            //   //   alertt(" email arealy exist online ");
                            //   //   print("err original : $err");
                            //   //   print("email arealy exist online ");
                            //   // }
                            //   // if(err=="errorregister"){
                            //   //   alertt(" error register ");
                            //   //   print("err original : $err");
                            //   //   print("error register ");
                            //   // }
                            //   // if(err=="erroremptydata"){
                            //   //   alertt(" error empty data ");
                            //   //   print("error empty data $err");
                            //   //   print("error empty data ");
                            //   // }
                            //   // if(err==""){
                            //   //   alertt(" connexion data ");
                            //   //
                            //   // }
                            // }

                          } else {
                            alertt(
                                "One user is already registed first online and second locally");
                            print('One user is already registed');
                          }
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Avez-vous un compte? ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      MaterialButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Login();
                            }));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    // child: Text('$error'),
                  ),
                ],
              )),
        ),
      ),
    );
  }

//
//   void registeronline(
//       String nomDelegue,
//       String matriculeDelegue,
//       String emailDelegue,
//       String passwordDelegue,
//       String niveauDelegue,
//       String cycleDelegue,
//       String filiereDelegue,
//       String optionDelegue,
//       String departement
//       )async{
//     setState(() {
//       // _loading = true;
//     });
//
//     final response = await http.post(Uri.parse('https://projetepharm.000webhostapp.com/article/register.php'), body: {
//       "nomDelegue":nomDelegue,
//       "matriculeDelegue":matriculeDelegue,
//       "emailDelegue":emailDelegue,
//       "passwordDelegue":passwordDelegue,
//       "niveauDelegue":niveauDelegue,
//       "cycleDelegue":cycleDelegue,
//       "filiereDelegue":filiereDelegue,
//       "optionDelegue":optionDelegue,
//       "departement":departement
//     });
//     if( response.statusCode == 200) {
//       print("valeur de la reponse sans decodage: ${response.body}");
//       String b= response.body;
//       dynamic data = await json.decode(b);
//       print("valeur de la reponse apres decodage: ${data}");
//       dynamic result = await data['data'];
//       print("le corps relle de la reponse apres decodage: ${result}");
//       int succes =  await result[1];
//       print("indicateur sur l'etat de l'utilisateur: ${succes}");
//       if(succes == 1){ // register  ok
//         err = await result[0];
//         print("erreur: ${err}");
//         idDelegueInternet = int.parse(await result[2]) ; // recuperation de l'id du delegue enregistrer dans la bd en ligne
//         print("idDelegueInternet: ${idDelegueInternet}");
//       }else{ // register  not ok
//         err = await result[0]; // err= "email arealy exist"; ou "error register" ou "error empty data"
//         print("erreur: ${err}");
//       }
//     }
//   }
//
//
//
//
// //fonction permettant d'enregistrer les infos du delegue saisi au clavier dans la bd
//    getRegister({String nomDelegue, String  niveauDelegue, String matricleDelegue, String emailDelegue, String cycleDelegue, String filiereDelegue, String departementDelegue, String optionDelegue, String configPassWord,String passwordDelegue}) async {
//      ContactOperations contactoperations = new ContactOperations();
//     if (nomDelegue.isEmpty || matricleDelegue.isEmpty || emailDelegue.isEmpty ||
//         passwordDelegue.isEmpty || cycleDelegue.isEmpty || niveauDelegue.isEmpty ||
//         filiereDelegue.isEmpty || departementDelegue.isEmpty ||
//         optionDelegue.isEmpty || configPassWord.isEmpty) {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text("Erreur"),
//                   content: Text("Entrez tous les champs svp."),
//                   actions: [
//                     MaterialButton(
//                       child: Text("Ok"),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     )
//                   ],
//                 );
//               }
//           );
//     }else{
//       if(configPassWord!=passwordDelegue) {
//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text("Erreur"),
//                 content: Text(" Les mots de pass sont differents "),
//                 actions: [
//                   MaterialButton(
//                     child: Text("Ok"),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   )
//                 ],
//               );
//             }
//         );
//       }else{
//         var data = await contactoperations.getDelegue();
//         List<Delegue> t= await data as List<Delegue>;
//         print("presence delegue $data");
//         if (t == null) {
//            registeronline(
//               nomDelegue,
//               matricleDelegue,
//               emailDelegue,
//               passwordDelegue,
//               niveauDelegue,
//               cycleDelegue,
//               filiereDelegue,
//               departementDelegue,
//               optionDelegue
//           );
//
//           if (err == "succesregister") {
//             ContactOperations contactOperations = new ContactOperations();
//             var delegue = new Delegue(
//               idDelegue: idDelegueInternet,
//               // on insere l'id du delegue qui est stocker au net dans la bd locale
//               nomDelegue: nomDelegue,
//               matriculeDelegue: matricleDelegue,
//               emailDelegue: emailDelegue,
//               passwordDelegue: passwordDelegue,
//               niveauDelegue: int.parse(niveauDelegue),
//               cycleDelegue: cycleDelegue,
//               filiereDelegue: filiereDelegue,
//               departement: departementDelegue,
//               optionDelegue: optionDelegue,
//             );
//             await contactOperations.createDelegue(delegue); // inserer un delegue dans la bd
//             print("Infos d'\inscription enregistrée dans la bd locale et en ligne ");
//             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {return Login();}));
//             alertt(" Enregistrement reussi ! Log in online OK ");
//           } else {
//                 alertt(" email arealy exist online ");
//                 print("err original : $err");
//                 print("email arealy exist online ");
//           }
//         } else {
//           alertt("One user is already registed first online and second locally");
//           print('One user is already registed');
//         }
//       }
//     }
//   }
  void alertt(String a) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Message"),
            content: Text("$a"),
            actions: [
              MaterialButton(
                child: Center(
                    child: Text("Ok",
                        textScaleFactor: 2, textAlign: TextAlign.center)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.lightBlueAccent,
              )
            ],
          );
        });
  }
}
