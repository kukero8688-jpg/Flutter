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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 248, 195),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 133, 2),
        title: const Text(
          'RowContainer',
          style: TextStyle(backgroundColor: Color.fromARGB(255, 244, 245, 240)),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        color: const Color.fromARGB(255, 72, 0, 240),
        height: 300.0,
        width: 300.0,

        transform: Matrix4.translationValues(50, 50, 0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: const Text(
                  '第一格在左邊',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 247, 247, 247),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                child: const Text(
                  '第二格在中間',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 0, 5, 3),
                    backgroundColor: Color.fromARGB(255, 238, 9, 47),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                child: const Text(
                  '第三格在右邊',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 255, 196, 0),
                    backgroundColor: Color.fromARGB(255, 162, 2, 255),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
