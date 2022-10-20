import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:sqflite_tutorial/authentication/login.dart';
import 'package:sqflite_tutorial/models/contact.dart';
import 'dart:typed_data';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'edit_contact_page.dart';

class PageEmargement extends StatefulWidget {
  final Contact cours;

  PageEmargement({Key key, this.cours}) : super(key: key);

  @override
  _PageEmargementState createState() => _PageEmargementState();
}

class _PageEmargementState extends State<PageEmargement> {
  Emargement emargement;
  ContactOperations contactoperations;

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    // onDrawStart: () => print('onDrawStart called!'),
    // onDrawEnd: () => print('onDrawEnd called!'),
  );

  final SignatureController _controller1 = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    // onDrawStart: () => print('onDrawStart called!'),
    // onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
    _controller1.addListener(() => print('Value changed'));

    //emargement = new Emargement();
    contactoperations = new ContactOperations();
  }

  bool couleur1 = false;
  bool couleur11 = false;
  bool couleur2 = false;
  bool couleur21 = false;
  bool couleur22 = false;
  bool couleur23 = false;
  bool couleur3 = false;
  bool couleur4 = false;
  bool couleur5 = false;
  bool couleur6 = false;
  String a = '';
  String b = '';
  int cm = 0;
  int td = 0;
  int tp = 0;
  String datetime;
  int realtimehour = 0;
  int realtimehour1 = 0;
  int realtimehour2 = 0;
  int realtimehour3 = 0;
  int total = 0;

  Uint8List data;
  Uint8List data1;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    // var data = await contactoperations.getDelegue();
    // List<Delegue> t= await data as List<Delegue>;
    // print(data);

    return Scaffold(
      appBar: AppBar(
        title: Text('Follow-up Lessons Sheet'),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return Container(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),

            // Text("Follow-up"),
            // Text("Volume horaire en cours"),

            Card(
              elevation: 19,
              child: ExpansionPanelList(
                //animationDuration: Duration(milliseconds: 2000),
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //Text('  ', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                          Icon(
                            Icons.book,
                            size: 50,
                          ),
                          SizedBox(
                            width: 5.2,
                          ),
                          Text(
                            "${widget.cours.nomCours}",
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      );
                    },
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            "${widget.cours.nomEnseignant}",
                            style: TextStyle(fontSize: 25),
                          ),
                          // trailing: Padding(
                          //   padding: const EdgeInsets.all(5.0),
                          //   child: MaterialButton(
                          //     onPressed: () {
                          //       //Navigator.push(context, MaterialPageRoute(builder: (context) => Pdf(cours: cours[index],)));
                          //     },
                          //     color: Colors.orange,
                          //     child: Icon(Icons.edit, color: Colors.white),
                          //   ),
                          // ),
                        ),
                        Text(
                          "   Cours Magistral : $realtimehour /${widget.cours.cm}",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                            "   Travaux Diriges : $realtimehour1 /${widget.cours.td}",
                            style: TextStyle(fontSize: 25)),
                        Text(
                            "   Travaux pratique : $realtimehour2 /${widget.cours.tp}",
                            style: TextStyle(fontSize: 25)),
                        Text("   Total : $total /${widget.cours.heuresToDo}",
                            style: TextStyle(fontSize: 25))
                      ],
                    ),
                    isExpanded: _expanded,
                    canTapOnHeader: true,
                  ),
                ],
                dividerColor: Colors.grey,
                expansionCallback: (panelIndex, isExpanded) async {
                  int u = widget.cours.idCours;

                  if ((realtimehour == null) &&
                      (realtimehour1 == null) &&
                      (realtimehour2 == null)) {
                    realtimehour = 0;
                    realtimehour1 = 0;
                    realtimehour2 = 0;
                  } else {
                    total = realtimehour + realtimehour1 + realtimehour2;
                    print("total : $total");
                  }

                  List<Map> y = await contactoperations.hourloadcm(u);
                  List<Map> y1 = await contactoperations.hourloadtd(u);
                  List<Map> y2 = await contactoperations.hourloadtp(u);
                  // List<Map> t = y as List<Map>;
                  realtimehour = await y[0]['SUM(cm)'] as int;
                  realtimehour1 = await y1[0]['SUM(td)'] as int;
                  realtimehour2 = await y2[0]['SUM(tp)'] as int;
                  print("y : $realtimehour");
                  setState(() {
                    realtimehour = realtimehour;
                    realtimehour1 = realtimehour1;
                    realtimehour2 = realtimehour2;
                    total = total;
                  });
                  _expanded = !_expanded;
                  setState(() {});
                },
              ),
            ),

            SizedBox(height: 20),
            Card(
              elevation: 20,
              child: DateTimePicker(
                style: TextStyle(
                    fontSize: 25, color: couleur1 ? Colors.green : Colors.red),
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Jour',
                timeLabelText: "Heure",
                initialDatePickerMode: DatePickerMode.day,
                //
                // selectableDayPredicate: (date) {
                //   // Disable weekend days to select from the calendar
                //   if (date.weekday == 6 || date.weekday == 7) {
                //     return false;
                //   }
                //   return true;
                // },
                onChanged: (val) {
                  datetime = val;
                  if (datetime == null) {
                    setState(() {
                      couleur1 = false;
                    });
                  } else {
                    setState(() {
                      couleur1 = true;
                    });
                  }
                },
                validator: (val) {
                  datetime = val;
                  return null;
                },
                onSaved: (val) {
                  datetime = val;
                },
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                elevation: 20,
                child: Container(
                    height: 75,
                    //color: Colors.lightBlueAccent,
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Text(
                            " Cours Magistrat ",
                            textScaleFactor: 2,
                            style: TextStyle(
                                color: couleur2 ? Colors.green : Colors.red),
                          ),
                          SizedBox(width: 30),
                          Container(
                            alignment: Alignment.center,
                            child: DropdownButton<int>(
                              value: cm,
                              //icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: couleur2 ? Colors.green : Colors.red),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.deepPurpleAccent,
                              // ),
                              onChanged: (int newValue) {
                                setState(() {
                                  cm = newValue;
                                });
                                if (cm == 0) {
                                  setState(() {
                                    couleur2 = false;
                                  });
                                } else {
                                  setState(() {
                                    couleur2 = true;
                                  });
                                }
                              },
                              items: <int>[0, 1, 2, 3, 4, 5, 6]
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text("$value",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: couleur2
                                              ? Colors.green
                                              : Colors.red)),
                                );
                              }).toList(),
                            ),
                            height: 50,
                            width: 90,
                            color: Colors.lightBlueAccent,
                          )
                        ],
                      )
                    ])),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                elevation: 20,
                child: Container(
                    height: 70,
                    //color: Colors.lightBlueAccent,
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Text(
                            " TD ",
                            textScaleFactor: 2,
                            style: TextStyle(
                                color: couleur3 ? Colors.green : Colors.red),
                          ),
                          SizedBox(width: 195),
                          Container(
                            alignment: Alignment.center,
                            child: DropdownButton<int>(
                              value: td,
                              //icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: couleur3 ? Colors.green : Colors.red),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.deepPurpleAccent,
                              // ),
                              onChanged: (int newValue) {
                                setState(() {
                                  td = newValue;
                                });
                                if (td == 0) {
                                  setState(() {
                                    couleur3 = false;
                                  });
                                } else {
                                  setState(() {
                                    couleur3 = true;
                                  });
                                }
                              },
                              items: <int>[0, 1, 2, 3, 4, 5, 6]
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text("$value",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: couleur3
                                              ? Colors.green
                                              : Colors.red)),
                                );
                              }).toList(),
                            ),
                            height: 50,
                            width: 90,
                            color: Colors.lightBlueAccent,
                          )
                        ],
                      )
                    ])),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                elevation: 20,
                child: Container(
                    height: 70,
                    //color: Colors.lightBlueAccent,
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Text(
                            " TP ",
                            textScaleFactor: 2,
                            style: TextStyle(
                                color: couleur4 ? Colors.green : Colors.red),
                          ),
                          SizedBox(width: 195),
                          Container(
                            alignment: Alignment.center,
                            child: DropdownButton<int>(
                              value: tp,
                              //icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: couleur4 ? Colors.green : Colors.red),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.deepPurpleAccent,
                              // ),
                              onChanged: (int newValue) {
                                setState(() {
                                  tp = newValue;
                                });
                                if (tp == 0) {
                                  setState(() {
                                    couleur4 = false;
                                  });
                                } else {
                                  setState(() {
                                    couleur4 = true;
                                  });
                                }
                              },
                              items: <int>[0, 1, 2, 3, 4, 5, 6]
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text("$value",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: couleur4
                                              ? Colors.green
                                              : Colors.red)),
                                );
                              }).toList(),
                            ),
                            height: 50,
                            width: 90,
                            color: Colors.lightBlueAccent,
                          )
                        ],
                      )
                    ])),
              ),
            ),

            SizedBox(height: 20),
            /////////////////////////////////////////// Enseigant ////////////////////////////////////////////////////////////////
            Container(
              height: 80,
              child: Card(
                elevation: 20,
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              "Signature Enseignant",
                              textAlign: TextAlign.center,
                            ),
                            content: Text(" Signe Ici.",
                                textAlign: TextAlign.center),
                            actions: [
                              Signature(
                                controller: _controller,
                                height: 200,
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                              //OK AND CLEAR BUTTONS
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    //SHOW EXPORTED IMAGE IN NEW ROUTE
                                    IconButton(
                                      icon: const Icon(Icons.check),
                                      color: Colors.blue,
                                      onPressed: () async {
                                        if (_controller.isNotEmpty) {
                                          data = await _controller.toPngBytes();
                                          print(" le bon data a $data");
                                          // print(" la taille a ${data.length}");
                                          if (data != null) {
                                            setState(() {
                                              couleur5 = true;
                                            });
                                          } else {
                                            setState(() {
                                              couleur5 = false;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            couleur5 = false;
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                    ),
                                    //CLEAR CANVAS
                                    IconButton(
                                      icon: const Icon(Icons.clear),
                                      color: Colors.blue,
                                      onPressed: () {
                                        setState(() {
                                          _controller.clear();
                                          data = null;
                                        });
                                        print(" egale22 a $data");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text("Signature Enseignant",
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: couleur5 ? Colors.green : Colors.red)),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            //////////////////////////////////////////// Delegue //////////////////////////////////////////////////////////////
            Container(
              height: 80,
              child: Card(
                elevation: 20,
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          scrollable: false,
                          title: Text("Signature Delegue",
                              textAlign: TextAlign.center),
                          content:
                              Text(" Signe Ici.", textAlign: TextAlign.center),
                          actions: [
                            Signature(
                              controller: _controller1,
                              height: 200,
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                            //OK AND CLEAR BUTTONS
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.black),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  //SHOW EXPORTED IMAGE IN NEW ROUTE
                                  IconButton(
                                    icon: const Icon(Icons.check),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      if (_controller1.isNotEmpty) {
                                        data1 = await _controller1.toPngBytes();
                                        // print(" le bon data a $data1");
                                        // print(" la taille a ${data1.length}");
                                        if (data1 != null) {
                                          setState(() {
                                            couleur6 = true;
                                          });
                                        } else {
                                          setState(() {
                                            couleur6 = false;
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          couleur6 = false;
                                        });
                                      }
                                      print(" egale2 a $data1");
                                      Navigator.pop(context);
                                    },
                                  ),
                                  //CLEAR CANVAS
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    color: Colors.blue,
                                    onPressed: () {
                                      setState(() {
                                        _controller1.clear();
                                        data1 = null;
                                      });
                                      print(" egale22 a $data1");
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Signature delegue",
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: couleur6 ? Colors.green : Colors.red)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 80,
              child: Card(
                elevation: 20,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 55),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Annuler',
                          textScaleFactor: 2,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Valider',
                        textScaleFactor: 2,
                      ),
                      onPressed: () {
                        if (data != null) {
                          a = 'effectuer';
                        } else {
                          a = 'vide';
                        }
                        if (data1 != null) {
                          b = 'effectuer';
                        } else {
                          b = 'vide';
                        }

                        //=============================== Gestion erreur 'Signature total' =============================
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content:
                                    Text(" Voulez vous vraiment valider ?."),
                                actions: [
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20,
                                      ),
                                      MaterialButton(
                                        color: Colors.red,
                                        child: Text("Annuler"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      MaterialButton(
                                        color: Colors.green,
                                        child: Text("Oui"),
                                        onPressed: () {
                                          print("datetime: $datetime");
                                          print("nbre heure: $cm");
                                          print("nbre heure: $td");
                                          print("nbre heure: $tp");
                                          print("signature_delegue: $a");
                                          print("signature_enseignant: $b");

                                          if ((datetime == null) ||
                                              (cm == 0) ||
                                              (td == 0) ||
                                              (tp == 0) ||
                                              (data == null) ||
                                              (data1 == null)) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Row(
                                                children: [
                                                  Icon(Icons.thumb_down),
                                                  SizedBox(
                                                    width: 40,
                                                    height: 100,
                                                  ),
                                                  Text(
                                                    'Validez toutes les zones rouges',
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                              duration: Duration(seconds: 3),
                                              backgroundColor: Colors.redAccent,
                                            ));
                                          } else {
                                            print("datetime: $datetime");
                                            print("nbre heure: $cm");
                                            print("signature_delegue: $a");
                                            print("signature_enseignant: $b");

                                            contactoperations.insertion(
                                                widget.cours.idCours,
                                                datetime,
                                                a,
                                                b,
                                                cm,
                                                td,
                                                tp);
                                            print(
                                                "valeur de idcours: ${widget.cours.idCours}");
                                            // print(
                                            //     "valeur de idEmarg: ${emargement.idEmarg}");

                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Row(
                                                children: [
                                                  Icon(Icons.thumb_up),
                                                  SizedBox(
                                                    width: 40,
                                                    height: 100,
                                                  ),
                                                  Text(
                                                    'Emargement reussi',
                                                    style:
                                                        TextStyle(fontSize: 7),
                                                  ),
                                                ],
                                              ),
                                              duration: Duration(seconds: 3),
                                              backgroundColor:
                                                  Colors.greenAccent,
                                            ));
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              );
                            });
                        //Navigator.pop(context);
                      },
                    ),
                    //SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
            Divider(height: 90, color: Colors.red),
            Text(
              'Modifier ce cours',
              textScaleFactor: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            EditContactPage(
              contact: widget.cours,
            ),
          ],
        ));
      }),
    );
  }
}
