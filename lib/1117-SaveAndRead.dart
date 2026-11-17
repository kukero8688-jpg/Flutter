import 'package:flutter/material.dart';//第一區：引進工具與啟動 App
import '1117-SharedPreferencesHelper.dart';

void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {// 第二區 設定 App 的外觀皮膚（MyApp）
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Save And Read',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
//第三區：準備大腦與記憶工具（MyHomePage 的上半部）
class _MyHomePageState extends State<MyHomePage> { 
  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<String> _name = ValueNotifier<String>('');
  final SharePreferencesHelper _helper = SharePreferencesHelper();

  @override //離開頁面清除記憶體
  void dispose() {
    _nameController.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _saveName() async {
    await _helper.saveName(_nameController.text);
  }

  Future<void> _readName() async {
    final name = await _helper.readName();
    _name.value = name;
  }

  //第四區：把畫面「畫」出來（build 方法）
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('儲存資料')),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _nameController,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  labelText: '輸入姓名',
                  labelStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: _buildButton(text: '儲存', onPressed: _saveName),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: _buildButton(text: '讀取', onPressed: _readName),
            ),
            Container( //顯示讀取畫面區塊
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ValueListenableBuilder<String>(
                valueListenable: _name,
                builder: _nameWidgetBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(6),
        ),
        elevation: 8,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.redAccent),
      ),
    );
  }

  Widget _nameWidgetBuilder(BuildContext context, String name, Widget? child) {
    return Text(name, style: const TextStyle(fontSize: 20));
  }
}
