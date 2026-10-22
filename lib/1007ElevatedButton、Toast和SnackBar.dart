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

  void showToast() {
    Fluttertoast.showToast(
      msg: '按鈕',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.deepPurple,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Elevated Button'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: ElevatedButton(
            onPressed: showToast,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 2, 29, 75),
              elevation: 8.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 15.0,
              ),
            ),
            child: const Text(
              'Button',
              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
            ),
          ),
        ),
      ),
    );
  }
}
