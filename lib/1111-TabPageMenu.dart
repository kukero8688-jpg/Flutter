import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Page Menu',
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
  final ValueNotifier<String> _messageNotifier = ValueNotifier<String>(
    '請從左側選單選擇項目',
  );

  final List<String> _menuItems = const ['選項一', '選項二', '選項三'];

  @override
  void dispose() {
    _messageNotifier.dispose();
    super.dispose();
  }

  void _selectMenuItem(String item) {
    _messageNotifier.value = item;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab Page Menu')),
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
            for (final item in _menuItems)
              ListTile(
                title: Text(item, style: const TextStyle(fontSize: 20.0)),
                onTap: () => _selectMenuItem(item),
              ),
          ],
        ),
      ),

      body: Center(
        child: ValueListenableBuilder<String>(
          valueListenable: _messageNotifier,
          builder: (context, value, child) {
            return Text(value, style: TextStyle(fontSize: 20.0));
          },
        ),
      ),
    );
  }
}
