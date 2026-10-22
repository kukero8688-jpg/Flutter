import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> _imageIndex = ValueNotifier(0);

  static const _images = <String>[
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
  ];

  @override
  void dispose() {
    _imageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final previousBtn = IconButton(
      icon: Image.asset('assets/images/previous.png'),
      iconSize: 40,
      onPressed: _previousImage,
    );
    final nextBtn = IconButton(
      icon: Image.asset('assets/images/next.png'),
      iconSize: 40,
      onPressed: _nextImage,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Browse Image 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder<int>(
              valueListenable: _imageIndex,
              builder: _imageBuilder,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[previousBtn, nextBtn],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageBuilder(BuildContext context, int imageIndex, Widget? child) {
    return Image.asset(
      _images[imageIndex],
      width: 240,
      height: 280,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(
          width: 240,
          height: 280,
          child: Center(
            child: Text(
              '無法載入圖片',
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  void _previousImage() {
    _imageIndex.value = _imageIndex.value == 0
        ? _images.length - 1
        : _imageIndex.value - 1;
  }

  void _nextImage() {
    _imageIndex.value = (_imageIndex.value + 1) % _images.length;
  }
}
