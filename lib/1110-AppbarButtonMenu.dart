import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appbar Button Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ValueNotifier<String> _msg = ValueNotifier('');

  @override
  Widget build(BuildContext context){
    final phoneButton = IconButton(
      onPressed: () {_msg.value = '按下手機按鈕';}, 
      icon: const Icon(Icons.phone_android, color: Colors.white),
    );

    final popupMenu = PopupMenuButton<int>(
      itemBuilder: (context) => const [
        PopupMenuItem<int>(
          value: 1,
          child: Text('第一項', style: TextStyle(fontSize: 20.0)),          
        ),
        PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 2,
          child: Text('第二項', style: TextStyle(fontSize: 20.0)),          
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
          _msg.value = '第一項';
          break;
          case 2:
          _msg.value = '第二項';
          break;
        }
      },
    );

    final appBar = AppBar(
      title: const Text('Appbar Button Menu'),
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          _msg.value = '按下選單按鈕';
        },
        child: const Icon(Icons.menu),
      ),
      actions: [phoneButton, popupMenu],
    );

    return Scaffold(
      appBar: appBar,
      body: ValueListenableBuilder<String>(
        valueListenable: _msg, 
        builder: _showMsg,
      ),
    );
  }

  Widget _showMsg(
    BuildContext context,
    String msg,
    Widget? child,
  ){
    return Center(child: Text(msg, style: const TextStyle(fontSize: 20)));
  }
}


