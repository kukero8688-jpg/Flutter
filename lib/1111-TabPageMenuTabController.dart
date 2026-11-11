import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Page Menu With Tab Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ValueNotifier<String> _messageNotifier = ValueNotifier('');

  static const  List<String> _menuItems = ['選項一', '選項二', '選項三'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab Page Menu With Tab Controller')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Tab 標題',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            ...List.generate(_menuItems.length, (index) => ListTile(
                title: Text(_menuItems[index], style: const TextStyle(fontSize: 20.0)),
                onTap: () {
                  _messageNotifier.value = _menuItems[index];
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: ValueListenableBuilder<String>(
          valueListenable: _messageNotifier, 
          builder: _showMsg
        ),
      ),
    );  
  }

  Widget _showMsg(BuildContext context, String msg, Widget? child) {
    return Text(msg, style: const TextStyle(fontSize: 20.0));
  }
}


