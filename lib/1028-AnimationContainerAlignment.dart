import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Container Alignment',
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
  final ValueNotifier<Alignment> _alignment = ValueNotifier(
    Alignment.bottomCenter,
  );

  @override
  void dispose() {
    _alignment.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _alignment.value = Alignment.topCenter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Container Alignment')),
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ValueListenableBuilder<Alignment>(
                  valueListenable: _alignment,
                  builder: (context, alignment, child) {
                    return AnimatedContainer(
                      // duration: const Duration(seconds: 3),
                      duration: alignment == Alignment.bottomCenter
                          ? Duration.zero
                          : const Duration(seconds: 3),
                      curve: Curves.fastOutSlowIn,
                      alignment: alignment,
                      onEnd: () {
                        _alignment.value = Alignment.bottomCenter;
                      },
                      child: child,
                    );
                  },
                  child: const Icon(
                    Icons.airplanemode_active,
                    color: Color.fromARGB(255, 247, 210, 4),
                    size: 50,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton.icon(
                  onPressed: _startAnimation,
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Icon(
                      Icons.airplanemode_inactive,
                      color: Colors.white,
                    ),
                  ),
                  label: const Padding(
                    padding: EdgeInsets.only(top: 10, right: 20, bottom: 10),
                    child: Text(
                      '起飛',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 30, 139),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
