

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
/// example widget showing how to use signature widget
///
class Sd_se extends StatefulWidget {
  @override
  _Sd_seState createState() => _Sd_seState();
}

class _Sd_seState extends State<Sd_se> {
  final SignatureController _controller = SignatureController(
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
  }



  @override
  Widget build(BuildContext context) {
    Uint8List data;
    print(" egale21 a $data");
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: ListView(
            children: <Widget>[
              Container(
                height: 300,
                child: const Center(
                  child: Text('Big container to test scrolling issues'),
                ),
              ),
              //SIGNATURE CANVAS
              Signature(
                controller: _controller,
                height: 300,
                backgroundColor: Colors.lightBlueAccent,
              ),
              //OK AND CLEAR BUTTONS
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          print(" la taille a ${data.length}");
                          if (data != null) {
                          //   await Navigator.of(context).push(MaterialPageRoute<void>(
                          //       builder: (BuildContext context) {
                          //         return Scaffold(
                          //           appBar: AppBar(),
                          //           body: Center(
                          //             child: Container(
                          //               color: Colors.grey[300],
                          //               child: Image.memory(data),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   );
                          // print("egale1 a $data");
                          }
                        }
                        print(" egale2 a $data");
                      },
                    ),
                    //CLEAR CANVAS
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() => _controller.clear());
                        print(" egale22 a $data");
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                child: const Center(
                  child: Text('Big container to test scrolling issues'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
