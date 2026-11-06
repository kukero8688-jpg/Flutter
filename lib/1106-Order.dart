import 'package:flutter/material.dart';
import 'package:flutter_appl_1/1106-OrderSelectMainCourse.dart';
import 'package:flutter_appl_1/1106-OrderSelectDrink.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute: '/',

      routes: {
        '/':(context) => const MyHomePage(),
        '/select-main-course':(context) => SelectMainCourse(),
        '/select-drink':(context) => SelectDrink(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key}); 

  @override
  State<MyHomePage> createState() => _MyHomePageState();        
}

class _MyHomePageState extends State<MyHomePage>{
  final ValueNotifier<String> _selectedMainCourse = ValueNotifier<String>('尚未選擇主餐');

  final ValueNotifier<String> _selectedDrink = ValueNotifier<String>('尚未選擇飲料');

  @override
  void dispose(){
    _selectedMainCourse.dispose();
    _selectedDrink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('點餐系統')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSelectionRow(
              valueNotifier: _selectedMainCourse,
              buttonText: '選擇主餐',
              onPressed: ()=> _showMainCourseScreen(context),
            ),

            const SizedBox(height: 20.0),

            _buildSelectionRow(
              valueNotifier: _selectedDrink,
              buttonText: '選擇飲料',
              onPressed: ()=> _showDrinkScreen(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionRow({
    required ValueNotifier<String> valueNotifier,
    required String buttonText,
    required VoidCallback onPressed,
  }){
    return Row(
      children: [
        Expanded(
          child:ValueListenableBuilder<String>(
            valueListenable: valueNotifier, 
            builder: (context, value, child) {
              return Text(value, style: const TextStyle(fontSize: 20.0));
            }
          ), 
        ),

        const SizedBox(width: 16.0),

        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent,
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            elevation: 8,
          ), 
          child: Text(buttonText, style: const TextStyle(fontSize: 18.0)),
        ),
      ],
    );
  }

  Future<void> _showMainCourseScreen(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/select-main-course');

    _selectedMainCourse.value = result?.toString() ?? '沒有選擇主餐';
  }

  Future<void> _showDrinkScreen(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/select-drink');

    _selectedDrink.value = result?.toString() ?? '沒有選擇飲料';
  }

}