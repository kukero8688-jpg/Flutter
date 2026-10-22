import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Change Text',
          style: TextStyle(backgroundColor: Color(0xFF00FF00)),
        ),
      ),
      body: Center(
        child: const Text(
          'StatelessWidget\nWidget\nChange\nText\nNice-day\nJames',
          style: TextStyle(
            fontSize: 30.5,
            color: Color(0xFFFF0000),
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
          maxLines: 6,
        ),
      ),

    );
  }
}
