import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:sqflite_tutorial/authentication/register.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:sqflite_tutorial/presentation/pages/emargement.dart';
import 'package:sqflite_tutorial/presentation/widgets/pdf.dart';
import 'dart:async';
import 'data/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.green,
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This widget is the root of your application.
  Widget image_carousel = new Container(
    height: 200.0,
    child: new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('lib/images/i2.JPG'),
        AssetImage('lib/images/i3.JPG'),
        AssetImage('lib/images/i4.JPG'),
        AssetImage('lib/images/i5.JPG'),
      ],
      autoplay: false,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
      dotSize: 4.0,
      indicatorBgPadding: 2.0,
    ),
  );

  var _niveauDelegue = TextEditingController();
  bool _expanded = false;
  var _test = "Full Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Welcome ',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: Text('Dongmo Noumedem'),
              accountEmail: Text('gorandongmp@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: new Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.red.shade900),
            ),

            new InkWell(
              onTap: () {},
              child: new ListTile(
                title: new Text('Sous delegue'),
                leading: new Icon(Icons.person, color: Colors.red),
              ),
            ),

            new InkWell(
              onTap: () {},
              child: new ListTile(
                title: new Text('Restoration'),
                leading: new Icon(Icons.shopping_basket, color: Colors.red),
              ),
            ),

            new InkWell(
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Cart()));
              },
              child: new ListTile(
                title: new Text('EXIT'),
                leading: new Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
                ),
              ),
            ),
            new Divider(),
          ],
        ),
      ),
      //Container(height: 300,child: image_carousel,),
      body: Container(
          //color: Colors.green,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/images/true.JPG"), fit: BoxFit.fill)),
          child: ListView(
            children: <Widget>[
              Container(
                height: 300,
                child: image_carousel,
              ),
              SizedBox(
                height: 100,
              ),

              // Card(
              //     child: IntrinsicHeight(
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.stretch,
              //         children: <Widget>[
              //           Container(
              //             width: 20.0,
              //             color: Colors.amber,
              //           ),
              //           // Expanded(...)
              //         ],
              //       ),
              //     )
              // ),

              Center(
                child: ElevatedButton(
                    // style: ButtonStyle(),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Register();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Commencer'),
                    )),
              ),

              SizedBox(
                height: 50,
              ),
            ],
          )),
    );
  }
}
