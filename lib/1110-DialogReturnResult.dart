import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialog Return Result',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();        
}

class _MyHomePageState extends State<MyHomePage>{
  final ValueNotifier<int?> _dialogResult = ValueNotifier<int?>(null);

  @override
  void dispose(){
    _dialogResult.dispose();
    super.dispose();
  }

  Future<void> _showSaveDialog() async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          content: const Text('是否儲存？'),
          contentTextStyle: const TextStyle(color: Colors.indigo, fontSize: 20.0),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 1);
              }, 
              child: const Text('是', style: TextStyle(color: Colors.blue, fontSize: 20.0)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 0);
              }, 
              child: const Text('否', style: TextStyle(color: Colors.red, fontSize: 20.0)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, -1);
              }, 
              child: const Text('取消', style: TextStyle(color: Colors.green, fontSize: 20.0)),
            ),
          ],
        );
      }
    );
  
    _dialogResult.value = result;
  }
    

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Return Result')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _showSaveDialog, 
              child: const Text('Show Dialog', style: TextStyle(fontSize: 20.0)),
            ),

            const SizedBox(height: 20),
            ValueListenableBuilder<int?>(
              valueListenable: _dialogResult, 
              builder: (context, result, child) {
                return Text(
                  result?.toString() ?? '',
                  style: const TextStyle(fontSize: 20.0),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
}