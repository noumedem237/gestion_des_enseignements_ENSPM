
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'authentication/register.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        //'/uideleguete': (context) => UIdeleguetes(),
        // '/uiteachers': (context) =>UIteachers()
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget image_carousel = new Container(
    height: 200.0,
    child:  new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('lib/images/i1.JPG'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                          Welcome ',textAlign: TextAlign.center,),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(height: 300,child: image_carousel,),
            SizedBox(height: 100,),

            ElevatedButton(
                onPressed:(){
                    // visible ? Login(toggle, islogin) : Register(toggle);
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {return new Register();}));
                },
                child: Text('Compte', style: TextStyle(fontSize:30
                ))),
          ],
        ),
      ),
    );
  }
}
