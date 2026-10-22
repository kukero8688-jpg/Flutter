import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Browse Image2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Browse Image 2'), centerTitle: true),
      body: Stack(
        children: [
          Positioned.fill(
            child: ValueListenableBuilder<int>(
              valueListenable: _imageIndex,
              builder: _imageBuilder,
            ),
          ),
          Positioned(bottom: 20, left: 0, child: _buildControls()),
        ],
      ),
    );
  }

  Widget _imageBuilder(BuildContext context, int index, Widget? child) {
    return PhotoView(
      imageProvider: AssetImage(_images[index]),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 2,
      enableRotation: true,
      backgroundDecoration: const BoxDecoration(color: Colors.amber),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _controlButton(icon: Icons.arrow_back_ios, onTap: _previousImage),
        const SizedBox(width: 20),
        ValueListenableBuilder(
          valueListenable: _imageIndex,
          builder: (context, index, _) {
            return Text(
              '${index + 1}/${_images.length}',
              style: const TextStyle(fontSize: 16, color: Colors.black12),
            );
          },
        ),
        const SizedBox(width: 20),
        _controlButton(icon: Icons.arrow_forward_ios, onTap: _nextImage),
      ],
    );
  }

  Widget _controlButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ), // BoxDecoration
        child: Icon(icon, color: Colors.white),
      ), // Container
    ); // InkWell
  }

  void _previousImage() {
    _imageIndex.value =
        (_imageIndex.value - 1 + _images.length) % _images.length;
  }

  void _nextImage() {
    _imageIndex.value = (_imageIndex.value + 1) % _images.length;
  }
}
