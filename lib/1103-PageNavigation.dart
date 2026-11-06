import 'package:flutter/material.dart';
import 'package:flutter_app_1/20261103_PageNavigation_SecondPage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key}); 

  void _openSecondPage(BuildContext context){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Navigation')),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(30),
          child: ElevatedButton(
            onPressed: () => _openSecondPage(context), 
            child: const Text('Open Second Page', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }

        
}