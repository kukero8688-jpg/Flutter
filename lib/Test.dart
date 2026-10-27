import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('登入頁面'),
        backgroundColor: Colors.amber),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
          const Text('登入頁面',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          ), 
          const SizedBox(height: 10),
          const Text('請輸入帳號及密碼'),
          const SizedBox(
            width: 250,
            child: TextField(
              decoration: InputDecoration(
                labelText: '帳號',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          


         ],
        ), 
       ),
      ),
    );
  }
}
