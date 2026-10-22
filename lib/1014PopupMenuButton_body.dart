import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: AppBody())));
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  void _showToast() {
    Fluttertoast.showToast(
      msg: 'Toast',
      toastLength: Toast.LENGTH_LONG, //LENGTH_SHORT(2s), ENGTH_LONG(3.5s)
      gravity: ToastGravity.BOTTOM, //TOP, BOTTOM, CENTER, SNACKBAR
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      action: SnackBarAction(
        label: 'Toast',
        onPressed: _showToast,
        textColor: Colors.white,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 3.0,
      child: PopupMenuButton<int>(
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        offset: const Offset(100, 50),
        onSelected: (value) => _showSnackBar(context, "選擇了 $value "),
        onCanceled: () => _showSnackBar(context, "取消選擇"),
        itemBuilder: (context) => const [
          PopupMenuItem<int>(
            value: 1,
            child: Text("Item1", style: TextStyle(fontSize: 20.0)),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 2,
            child: Text("Item2", style: TextStyle(fontSize: 20.0)),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 3,
            child: Text("Item3", style: TextStyle(fontSize: 20.0)),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 4,
            child: Text("Item4", style: TextStyle(fontSize: 20.0)),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 5,
            child: Text("Item5", style: TextStyle(fontSize: 20.0)),
          ),
        ],
      ),
    );
  }
}
