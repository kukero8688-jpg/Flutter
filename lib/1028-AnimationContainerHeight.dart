import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Container Height',
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
  
  final ValueNotifier<double> _barHeight = ValueNotifier(100);

  @override
  void dispose(){
    _barHeight.dispose();
    super.dispose();
  }

  void _changeBarHeight() {
    _barHeight.value = _barHeight.value == 100 ? 400 : 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Container Height')),
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ValueListenableBuilder<double>(
                valueListenable: _barHeight, 
                builder: _animatedContainerBuilder,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _changeBarHeight,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  '改變高度',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animatedContainerBuilder (
    BuildContext context,
    double barHeight,
    Widget? child,
  ) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: 60,
      height: barHeight,
      curve: Curves.easeInOut,
      color: Colors.orangeAccent,
    );
  }
}
