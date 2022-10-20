
import 'package:flutter/material.dart';
import 'customTextField.dart';

class seConnecter extends StatefulWidget {
  seConnecter();
  @override
  _seConnecterState createState() => _seConnecterState();
}

class _seConnecterState extends State<seConnecter> {
  String err = "";

  CustomTextField emailText = new CustomTextField(title: "Email", placeholder: "Enter email",);
  CustomTextField passText = new CustomTextField(title: "Password", placeholder: "***********", ispass: true);
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    emailText.err = "enter email";
    passText.err = "enter password";
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    emailText.textfrofield(),
                    SizedBox(
                      height: 10,
                    ),
                    passText.textfrofield(),
                    SizedBox(
                      height: 10,
                    ),

                    RaisedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.redAccent.withOpacity(.7),
                      onPressed: () async {
                        if (_key.currentState.validate()) {

                          //login(emailText.value, passText.value);
                        }
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Avez-vous un compte? '),
                        FlatButton(
                            onPressed: (){
                              ////////////////////
                            },
                            child: Text("Register", style: TextStyle(color: Colors.redAccent),)
                        )
                      ],
                    ),

                    SizedBox(height: 30,),
                    Text(err, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,)
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
