import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Container', home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 131, 6),
        title: const Text(
          'Hello! Container!!',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          color: Colors.tealAccent,
          margin: const EdgeInsets.all(20.0), //寫all代表四個邊往內縮
          padding: const EdgeInsets.all(50.0),
          child: const Text(
            "Flutter APP\nContainer Widget\nCos Design\nDer",
            style: TextStyle(
              fontSize: 30,
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
            maxLines: 4,
          ),
        ),
      ),
    );
  }
}
