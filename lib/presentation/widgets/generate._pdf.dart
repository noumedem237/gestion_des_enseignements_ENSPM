import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:sqflite_tutorial/models/contact.dart';

import 'package:sqflite_tutorial/subtest.dart';

class PdfPage extends StatefulWidget {
  Contact cours;
  PdfPage({Key key, this.cours}) : super(key: key);
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  ContactOperations contactoperations = new ContactOperations();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Generation PDF"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Generate Course',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Course PDF',
                  onClicked: () async {
                    print("darara  ");
                    var data1 = await contactoperations.getDelegue();
                    var data2 = await contactoperations.getDelegue();
                    var data3 = await contactoperations
                        .getEmmargement(widget.cours.idCours);
                    //print("testttttttt");
                    var data5 = await contactoperations.getAllCours();

                    List<Delegue> t = data1;
                    //print("en delegue $t ");
                    if (await data3 == null) {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Erreur"),
                              content:
                                  Text(" Vous n'avez emmarger aucun cours ! ."),
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
                      // List<Delegue> t = data2;
                      // if (t != null) {
                      //   String _departement;
                      //   String _nomDelegue;
                      //   String _matriculeDelegue;
                      //   String _emailDelegue;
                      //   String _passwordDelegue;
                      //   int _niveauDelegue;
                      //   String _cycleDelegue;
                      //   String _filiereDelegue;
                      //   String _optionDelegue;
                      //   _departement = t[0].departement;
                      //   _matriculeDelegue = t[0].matriculeDelegue;
                      //   _niveauDelegue = t[0].niveauDelegue;
                      //   _optionDelegue = t[0].optionDelegue;
                      //   _cycleDelegue = t[0].cycleDelegue;
                      //   _filiereDelegue = t[0].filiereDelegue;
                      //   _nomDelegue = t[0].nomDelegue;
                      // }
                      // List<Emargement> tt = data3 ;
                      int realtimehour = 0;
                      int realtimehour1 = 0;
                      int realtimehour2 = 0;
                      int realtimehour3 = 0;
                      int total = 0;
                      int u = widget.cours.idCours;
                      List<Map> y = await contactoperations.hourloadcm(u);
                      List<Map> y1 = await contactoperations.hourloadtd(u);
                      List<Map> y2 = await contactoperations.hourloadtp(u);
                      // List<Map> t = y as List<Map>;
                      realtimehour = await y[0]['SUM(cm)'] as int;
                      realtimehour1 = await y1[0]['SUM(td)'] as int;
                      realtimehour2 = await y2[0]['SUM(tp)'] as int;
                      total = realtimehour + realtimehour1 + realtimehour2;
                      // data1 = await contactoperations.getDelegue();
                      final pdfFile = await PdfInvoiceApi.generate(
                          widget.cours,
                          data2,
                          data3,
                          realtimehour,
                          realtimehour1,
                          realtimehour2,
                          total); // invoice(facture d'achat) vas contenir tout les donnees du pdf

                      PdfApi.openFile(
                          pdfFile); // fonction creer pour ouvrir un fuchier
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

// import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const TitleWidget({
    Key key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(icon, size: 100, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    this.text,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onPressed: onClicked,
      );
}

class Utils {
  // defini le format du prix et de la date
  static formatPrice(double price) =>
      '\$ ${price.toStringAsFixed(2)}'; // je converti un float en .......
  static formatDate(DateTime date) =>
      DateFormat.yMd().format(date); // je converti un DateTime en ......
}
