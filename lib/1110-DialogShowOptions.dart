import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '對話盒範例',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    ); // MaterialApp
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const List<String> cities = ['華盛頓', '紐約', '洛杉磯', '舊金山', '鳳凰城'];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<String> _dialogResult = ValueNotifier('');
  final ValueNotifier<int?> _selectedCity = ValueNotifier(null);
  @override
  void dispose() {
    _dialogResult.dispose();
    _selectedCity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('對話盒範例-DialogShowOptions')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await _showCityDialog(context);
                _dialogResult.value = result ?? '';
              },
              child: const Text('顯示對話盒', style: TextStyle(fontSize: 20)),
            ), // ElevatedButton
            const SizedBox(height: 20),
            ValueListenableBuilder<String>(
              valueListenable: _dialogResult,
              builder: _buildDialogResult,
            ), // ValueListenableBuilder
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }

  Future<String?> _showCityDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ), // RoundedRectangleBorder
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          content: ValueListenableBuilder<int?>(
            valueListenable: _selectedCity,
            builder: _buildCityOptions,
          ), // ValueListenableBuilder
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, '');
              },
              child: const Text(
                '取消',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ), // Text
            ), // TextButton
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  _selectedCity.value == null
                      ? ''
                      : MyHomePage.cities[_selectedCity.value!],
                );
              },
              child: const Text('確定'),
            ), // TextButton
          ],
        ); // AlertDialog
      },
    ); // showDialog
  }

  Widget _buildDialogResult(
    BuildContext context,
    String result,
    Widget? child,
  ) {
    return Text(result, style: const TextStyle(fontSize: 20));
  }

  Widget _buildCityOptions(
    BuildContext context,
    int? selectedItem,
    Widget? child,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        MyHomePage.cities.length,
        (index) => RadioListTile<int>(
          value: index,
          // ignore: deprecated_member_use
          groupValue: selectedItem,
          title: Text(
            MyHomePage.cities[index],
            style: const TextStyle(fontSize: 20),
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            _selectedCity.value = value;
          },
        ),
      ),
    ); // Column
  }
}
