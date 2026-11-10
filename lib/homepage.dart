import 'dart:io';
import 'package:flutter/material.dart';
import 'addlogpage.dart';

class TravelItem {
  final String title;
  final String transport;
  final int days;
  final String? imagePath;
  final bool isSatisfied;

  TravelItem({
    required this.title,
    required this.transport,
    required this.days,
    this.imagePath,
    required this.isSatisfied,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '旅行日記手札',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<List<TravelItem>> travelListNotifier = ValueNotifier([
    TravelItem(
      title: '淡水老街',
      transport: '捷運',
      days: 1,
      imagePath: null,
      isSatisfied: true,
    ),
  ]);

  @override
  void dispose() {
    travelListNotifier.dispose();
    super.dispose();
  }

  Future<void> _navigateAndAdd(BuildContext context) async {
    final newItem = await Navigator.push<TravelItem>(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => const AddLogPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );

    if (newItem != null) {
      final currentList = List<TravelItem>.from(travelListNotifier.value);
      currentList.add(newItem);
      travelListNotifier.value = currentList;
    }
  }

  void _sortList() {
    final currentList = List<TravelItem>.from(travelListNotifier.value);
    currentList.sort((a, b) {
      if (a.isSatisfied == b.isSatisfied) return 0;
      return a.isSatisfied ? -1 : 1;
    });
    travelListNotifier.value = currentList;
  }

  void _clearAll() {
    travelListNotifier.value = [];
  }

  void _removeItem(int index) {
    final currentList = List<TravelItem>.from(travelListNotifier.value);
    currentList.removeAt(index);
    travelListNotifier.value = currentList;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('已刪除該筆日記'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的旅行手札'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'sort') {
                _sortList();
              } else if (value == 'clear') {
                _clearAll();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'sort',
                child: Text('依評分排序'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'clear',
                child: Text('清除全部'),
              ),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder<List<TravelItem>>(
        valueListenable: travelListNotifier,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return const Center(
              child: Text('尚無旅行紀錄，請點擊下方按鈕新增！', style: TextStyle(fontSize: 18)),
            );
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: item.imagePath != null
                      ? FileImage(File(item.imagePath!))
                      : null,
                  child: item.imagePath == null
                      ? const Icon(Icons.place)
                      : null,
                ),
                title: Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('${item.transport} ｜ ${item.days} 天 ｜ ${item.isSatisfied ? "★ 滿意" : "☆ 待改善"}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onLongPress: () => _removeItem(index),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndAdd(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
