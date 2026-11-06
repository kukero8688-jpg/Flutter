import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MaterialApp(home: AppBody()));
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

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

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text('message'),
      duration: const Duration(seconds: 3),
      backgroundColor: const Color.fromARGB(255, 247, 140, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      action: SnackBarAction(
        label: 'Toast',
        onPressed: () => Fluttertoast.showToast(msg: '彈出logo框'),
        textColor: Colors.black45,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () => _showSnackBar(context, "Button1"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 248, 126, 45),
                  elevation: 8.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 15.0,
                  ),
                ),
                child: const Text(
                  'Button1',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 230, 235, 238),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextButton(
                onPressed: () => _showSnackBar(context, "Button2"),
                child: Text(
                  'Buton2',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 230, 235, 238),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 13),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(color: Colors.white, width: 2.0),
                ),
                child: const Text(
                  'Button3',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.lightGreenAccent,
                  ),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 13),
              child: IconButton(
                onPressed: () => _showSnackBar(context, "Button4"),
                icon: const Icon(Icons.phone_android),
                iconSize: 40.0,
                color: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: FloatingActionButton(
                onPressed: () => _showSnackBar(context, "Button5"),
                shape: const CircleBorder(),
                elevation: 5.0,
                child: const Icon(Icons.phone_iphone),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton.icon(
                onPressed: () => _showSnackBar(context, "Button6"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  elevation: 8.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 15.0,
                  ),
                ),
                label: const Text(
                  'Button6',
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
