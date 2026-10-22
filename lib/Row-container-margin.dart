import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container',
      theme: ThemeData(useMaterial3: false),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 111, 255),
        title: const Text(
          'Row!!!',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.tealAccent,
        margin: const EdgeInsets.all(20.0),
        height: 300.0,
        width: 300.0,
        transform: Matrix4.translationValues(50, 50, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            // --------------------------------------------------
            // 區塊 01
            // --------------------------------------------------
            Expanded(
              flex: 2,
              child: const Text(
                "Container 01 ",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromARGB(255, 228, 225, 225),
                ),
                maxLines: 4,
              ),
            ),

            // --------------------------------------------------
            // 區塊 02
            // --------------------------------------------------
            Expanded(
              flex: 2,
              child: const Text(
                "Container 02 ",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 2, 19, 250),
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromARGB(255, 119, 197, 129),
                ),
                maxLines: 4,
              ),
            ),

            // --------------------------------------------------
            // 區塊 03
            // --------------------------------------------------
            Expanded(
              flex: 2,
              child: const Text(
                "Container 02 ",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 2, 19, 250),
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromARGB(255, 119, 197, 129),
                ),
                maxLines: 4,
              ),
            ),

            // --------------------------------------------------
            // 區塊 04
            // --------------------------------------------------
            Expanded(
              flex: 2,
              child: const Text(
                "Container 03 ",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromARGB(255, 228, 225, 225),
                ),
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
