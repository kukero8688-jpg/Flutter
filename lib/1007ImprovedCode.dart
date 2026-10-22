import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Change Text', home: const MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text("SnackBar"),
      duration: const Duration(seconds: 3),
      backgroundColor: const Color.fromARGB(255, 247, 140, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      action: SnackBarAction(
        label: 'Toast',
        onPressed: () => Fluttertoast.showToast(msg: '彈出logo框'),
        textColor: Colors.black45,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 141, 129),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Elevated Button'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: ElevatedButton(
            onPressed: () => showSnackBar(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 248, 126, 45),
              elevation: 8.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 15.0,
              ),
            ),
            child: const Text(
              'Button',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 230, 235, 238),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
