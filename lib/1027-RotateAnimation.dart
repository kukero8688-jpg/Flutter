import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RotateAnimation Demo',
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
      appBar: AppBar(title: const Text('旋轉動畫範例')),
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
  late final Animation<double> _rotationAnimation;

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

    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(curvedAnimation)
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
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          alignment: Alignment.center,
          child: child,
        ); // Transform.rotate
      },
      child: const Text(
        'Flutter動畫',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ), // Text
    ); // AnimatedBuilder
  }
}
