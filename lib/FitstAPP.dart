import 'package:flutter/material.dart';

void main(){
  var appTitle = Text(
    'First Flutter App',
    style: TextStyle(
      backgroundColor: Colors.indigo,
      color:Colors.white,
    ),
  );

  var appBar = AppBar(
    title: appTitle,
    backgroundColor: const Color.fromARGB(255, 16, 2, 78),
  );

  var hiFlutter = Text(
    'Hi! Weeeee!!',
    style: TextStyle(
      fontSize: 30,
      color: const Color.fromARGB(255, 0, 255, 242),
      backgroundColor: const Color.fromARGB(255, 0, 3, 7)
    ),
  );

  var appBody = Center(child: hiFlutter,);

  var app = MaterialApp(
    home: Scaffold(
      appBar: appBar,
      body: appBody,
    ),
  );

  runApp(app);
}
