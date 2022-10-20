import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/authentication/register.dart';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:sqflite_tutorial/models/contact.dart';
import '../space_work.dart';
import 'customTextField.dart';

class Login extends StatefulWidget {
  Login();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String err = "";
  String passD;
  String emailD;
  String error = '';
  var _emailDelegue = TextEditingController();
  var _passwordDelegue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ContactOperations contactoperations =
        new ContactOperations(); // important ici apres le build context et l'instantiation
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return Register();
            }));
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailDelegue,
                    keyboardType: TextInputType.emailAddress,
                    validator: (e) => e.isEmpty ? this.err : null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: "Entrer l'\email",
                      labelText: 'email',
                      labelStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordDelegue,
                    keyboardType: TextInputType.text,
                    validator: (e) => e.isEmpty ? this.err : null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Entrer le password',
                      labelText: 'password',
                      labelStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  MaterialButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.green.withOpacity(.7),
                    onPressed: () async {
                      var dataemail = await contactoperations.recupmail();
                      var datapass = await contactoperations.recuppass();
                      List<Map> t = await dataemail;
                      List<Map> tt = await datapass;
                      print(t);
                      print(tt);

                      // if (t.length == 0 && tt.length == 0) {
                      if (t.length == 0 && tt.length == 0) {
                        print('bd vide');
                        print(t);
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Erreur"),
                                content: Text(
                                    " Aucun compte enregistrer avec ces identifiants ! "),
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
                        emailD = t[0]['emailDelegue'];
                        passD = tt[0]['passwordDelegue'];
                        print('la bd est deja rempli');
                        getRegister(
                            emailDelegue: _emailDelegue.text,
                            passWord: _passwordDelegue.text);

                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {return Space_work();}));
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
                              return Register();
                            }));
                          },
                          child: Text("Register",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Text(error, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,)
                ],
              )),
        ),
      ),
    );
  }

  void getRegister({String emailDelegue, String passWord}) {
    if (emailDelegue.isEmpty || passWord.isEmpty) {
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
          });
    } else {
      if (emailDelegue == emailD && passWord == passD) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Space_work();
        }));
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Erreur"),
                content: Text(" Email ou mot de pass incorrect."),
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
      }
    }
  }
}
