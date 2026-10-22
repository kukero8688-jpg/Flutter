import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp( 
      title: 'Hello Flutter',
      home: const HomePage(),
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
        title: const Text('Hello! Flutter!!'),
      ),
      body: const Center(
        child: Text('Hello! World!',style:TextStyle(
          fontSize:56,
          backgroundColor: Colors.amber,
          ),),
      ),
    );
  }
}
