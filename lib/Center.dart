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
          'Center Widget',
          style: TextStyle(backgroundColor: Color(0xFF00FF00)),
        ),
      ),
      body: Center(
        heightFactor: 1,
        widthFactor: 1,

        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Image.asset('assets/images/cc.png'),
            // Image.network('https://plus.unsplash.com/premium_photo-1704518704021-8a195b821d5c?q=80&w=1032&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D, Width:100, Height:100'),
            Image.network(
              'https://plus.unsplash.com/premium_photo-1704518704021-8a195b821d5c?q=80&w=1032&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              cacheWidth: 100,
              cacheHeight: 100,
            ),
            const Text(
              'StatelessWidget\nWidget\nChange\nText\nNice-day\nJames',
              style: TextStyle(
                fontSize: 30.5,
                color: Color(0xFFFF0000),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
  }
}
