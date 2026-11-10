import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customize Dialog',
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
  static const List<String> _cities = ['台北', '台中', '台南', '高雄'];
  final ValueNotifier<String> _dialogResult = ValueNotifier('');
  final ValueNotifier<int?> _selectedCity = ValueNotifier(null);

  @override
  void dispose(){
    _dialogResult.dispose();
    _selectedCity.dispose();
    super.dispose();
  }

  Future<void> _openDialog() async {
    final result = await _showCityDialog();
    
    if (result != null){
      _dialogResult.value = result;
    }
  }

  Future<String?> _showCityDialog() {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('請選擇城市'),
          content: ValueListenableBuilder<int?>(
            valueListenable: _selectedCity, 
            builder: _buildCityOptions,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, '');
              }, 
              child: const Text('取消', style: TextStyle(color: Colors.red, fontSize: 20.0)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context, 
                  _selectedCity.value == null ? '' : _cities[_selectedCity.value!],
                );
              }, 
              child: const Text('確定', style: TextStyle(color: Colors.green, fontSize: 20.0)),
            ),
          ],
        );
      }
    );
  }

  Widget _buildCityOptions(
    BuildContext context,
    int? selectedItem,
    Widget? child,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_cities.length, (index) {
        return RadioListTile(
          value: index,
          groupValue: selectedItem,
          title: Text(_cities[index], style: const TextStyle(fontSize: 20.0)),
          onChanged: (value) {
            _selectedCity.value = value;
          },
        );
      }),
    );
  }

  Widget _dialogResultBuilder(
    BuildContext context,
    String result,
    Widget? child,
  ) {
    return Text(result, style: const TextStyle(fontSize: 20.0));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text('Customize Dialog'));
    final showDialogButton = ElevatedButton(
      onPressed: _openDialog, 
      child: const Text('Show Dialog', style: TextStyle(fontSize: 20.0)),
    );

    final body = Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: showDialogButton,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ValueListenableBuilder<String>(
              valueListenable: _dialogResult, 
              builder: _dialogResultBuilder,
            ),
          ),
        ],
      ),
    );
    return Scaffold(appBar: appBar, body: body);
  }
}