import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appbar Drawer Menu',
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

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<String> _messageNotifier = ValueNotifier<String>('請選擇 Drawer 選單');

  @override
  void dispose(){
    _messageNotifier.dispose();
    super.dispose();
  }

  void _selectMenu(String menu){
    _messageNotifier.value = menu;
    Navigator.pop(context);
  }

  Widget _buildDrawerItem(String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 20.0)),
      onTap: () => _selectMenu(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appbar Drawer Menu')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Drawer 標題',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            _buildDrawerItem('選項一'),
            _buildDrawerItem('選項二'),
            _buildDrawerItem('選項三'),
          ],
        ),
      ),

      body: Center(
        child: ValueListenableBuilder<String>(
          valueListenable: _messageNotifier, 
          builder: (context, value, child) {
            return Text(value, style: TextStyle(fontSize: 20.0));
          }
        ),
      ),
    );  
  }
}


