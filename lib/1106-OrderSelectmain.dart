import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Dynamic Add Delete',
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
  
  final ValueNotifier<List<String>> _listItems = ValueNotifier(<String>["1", "2", "3"]);

  @override
  void dispose(){
    _listItems.dispose();
    super.dispose();
  }

  void _addItem() {
    final maxNumber = _listItems.value.isEmpty ? 0 : _listItems.value.map(int.parse).reduce((a, b) => a > b ? a : b);
    
    // final newList = List<String>.from(_listItems.value)..add((_listItems.value.length + 1).toString());

    final newList = List<String>.from(_listItems.value)..add((maxNumber + 1).toString());

    _listItems.value = newList;
  }

  void _removeItem(int index){
    final newList = List<String>.from(_listItems.value)..removeAt(index);

    _listItems.value = newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView Dynamic Add Delete')),
      body:ValueListenableBuilder<List<String>>(
        valueListenable: _listItems, 
        builder: (context, listItems, child) {
          return ListView.separated(
            itemCount: listItems.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: const Icon(Icons.list),
                title: Text(
                  listItems[index],
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: const Text('點擊新增 / 長按刪除'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _addItem,
                onLongPress: () => _removeItem(index),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1), 
          );
        },
      ),
    );    
  }           
}