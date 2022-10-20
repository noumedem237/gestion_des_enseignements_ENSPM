import 'package:flutter/material.dart';

class CustomTextField {

  //delegue
  String nomDelegue;
  String matriculeDelegue;
  String emailDelegue;
  String passwordDelegue;
  int    niveauDelegue;
  String cycleDelegue;
  String filiereDelegue;
  String optionDelegue;
  String departement;

  // cours
  int idCours;
  String nomCours;
  String codeCours;
  int heuresToDo;
  int Semestre;

  // emargement
  String date_du_cours;
  int nbre_heures;

  final String title;
  final String placeholder;
  final bool ispass;
  final int line;
  String initialValue;
  String err;
  String _value="";

  CustomTextField({
    this.title="",
    this.placeholder="",
    this.ispass=false,
    this.err="please complete",
    this.line=1,
    this.initialValue,

    this.passwordDelegue,
    this.optionDelegue,
    this.nomDelegue,
    this.niveauDelegue,
    this.matriculeDelegue,
    this.filiereDelegue,
    this.emailDelegue,
    this.cycleDelegue,
    this.departement,

    this.heuresToDo,
    this.Semestre,
    this.nomCours,
    this.nbre_heures,
    this.date_du_cours,
    this.codeCours
  });

  TextEditingController controller = new TextEditingController();
  int i = 0;

  TextFormField textfrofield(){
    i++;
    if(i==1){
      controller.text = initialValue;
      _value = initialValue;
    };
    return TextFormField(

      controller: controller,
      maxLines: this.line,
      onChanged: (e){
        _value = e;
      },
      validator: (e)=>e.isEmpty?this.err:null,
      obscureText: this.ispass,
      decoration: InputDecoration(
          hintText: this.placeholder,
          labelText: this.title,
          labelStyle: TextStyle(color: Colors.redAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.redAccent
              )
          )
      ),
    );
  }

  String get value{ // c'est 'value' la methode qui permet de recuperer la valeur entrer dans la boxfield
    return _value;
  }
}