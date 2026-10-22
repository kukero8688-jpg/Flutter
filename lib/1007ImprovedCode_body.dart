import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppBody extends StatelessWidget {
  const AppBody({super.key});

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
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: ElevatedButton(
        onPressed: () => showSnackBar(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 68, 87, 255),
          elevation: 8.0,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        ),
        child: const Text(
          'Button',
          style: TextStyle(
            fontSize: 20.0,
            color: Color.fromARGB(255, 230, 235, 238),
          ),
        ),
      ),
    );
  }
}
