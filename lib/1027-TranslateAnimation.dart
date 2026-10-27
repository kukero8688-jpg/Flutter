import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TranslateAnimation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    ); // MaterialApp
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('動畫範例')),
      body: const Center(child: AnimationWrapper()),
    ); // Scaffold
  }
}

class AnimationWrapper extends StatefulWidget {
  const AnimationWrapper({super.key});

  @override
  State<AnimationWrapper> createState() => _AnimationWrapperState();
}

class _AnimationWrapperState extends State<AnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    ); // AnimationController

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    _animation = Tween<double>(begin: -250, end: 250).animate(curvedAnimation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: child,
        );
      },
      child: const Text(
        'Flutter動畫',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ), // Text
    ); // AnimatedBuilder
  }
}
