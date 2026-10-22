import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_appl_1/1014PopupMenuButton_body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: '1014PopupMenu Button', home: AppBody());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text("SnackBar"),
      duration: const Duration(seconds: 3),
      backgroundColor: const Color.fromARGB(255, 247, 140, 52),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      action: SnackBarAction(
        label: 'Toast',
        onPressed: () => Fluttertoast.showToast(msg: '彈出logo框'),
        textColor: Colors.black45,
      ),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
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
        child: ElevatedButton(
          onPressed: () => showSnackBar(context),
          child: const Text('Button'),
        ),
      ),
    );
  }
}
