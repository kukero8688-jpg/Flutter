import 'package:flutter/material.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('按鈕'),
        backgroundColor: const Color.fromARGB(255, 17, 0, 252),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 145, 138),
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
              backgroundColor: const Color.fromARGB(255, 68, 87, 255),
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
                color: Color.fromARGB(255, 230, 235, 238),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
