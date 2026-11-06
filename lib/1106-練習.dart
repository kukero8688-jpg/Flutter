import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '旅行手札 App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

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

final ValueNotifier<List<TravelItem>> travelListNotifier =
    ValueNotifier<List<TravelItem>>([]);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _navigateAndAdd(BuildContext context) async {
    final newItem = await Navigator.push<TravelItem>(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddLogPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: FadeTransition(opacity: animation, child: child),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的旅行手札'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              final currentList = List<TravelItem>.from(
                travelListNotifier.value,
              );
              if (value == 'sort') {
                currentList.sort(
                  (a, b) =>
                      (b.isSatisfied ? 1 : 0).compareTo(a.isSatisfied ? 1 : 0),
                );
                travelListNotifier.value = currentList;
              } else if (value == 'clear') {
                travelListNotifier.value = [];
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'sort', child: Text('依評分排序')),
              const PopupMenuItem(value: 'clear', child: Text('清除全部')),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder<List<TravelItem>>(
        valueListenable: travelListNotifier,
        builder: (context, list, child) {
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = list[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: item.imagePath != null
                      ? FileImage(File(item.imagePath!))
                      : null,
                  child: item.imagePath == null
                      ? const Icon(Icons.landscape)
                      : null,
                ),
                title: Text(item.title),
                subtitle: Text(
                  '${item.transport} ｜ ${item.days} 天 ｜ ${item.isSatisfied ? "滿意" : "待改善"}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onLongPress: () {
                  final currentList = List<TravelItem>.from(
                    travelListNotifier.value,
                  );
                  currentList.removeAt(index);
                  travelListNotifier.value = currentList;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('已刪除該筆日記')));
                },
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

class AddLogPage extends StatefulWidget {
  const AddLogPage({super.key});

  @override
  State<AddLogPage> createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {
  final TextEditingController _titleController = TextEditingController();
  final ValueNotifier<String> _transportNotifier = ValueNotifier<String>('高鐵');
  final ValueNotifier<int> _daysNotifier = ValueNotifier<int>(1);
  final ValueNotifier<bool> _isSatisfiedNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<String?> _imagePathNotifier = ValueNotifier<String?>(
    null,
  );
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _imagePathNotifier.value = pickedFile.path;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _transportNotifier.dispose();
    _daysNotifier.dispose();
    _isSatisfiedNotifier.dispose();
    _imagePathNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新增旅行手札')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: '請輸入景點名稱'),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<String>(
              valueListenable: _transportNotifier,
              builder: (context, currentTransport, child) {
                return Column(
                  children: ['高鐵', '火車', '自行開車', '飛機'].map((type) {
                    return RadioListTile<String>(
                      title: Text(type),
                      value: type,
                      groupValue: currentTransport,
                      onChanged: (value) {
                        if (value != null) _transportNotifier.value = value;
                      },
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ValueListenableBuilder<int>(
                valueListenable: _daysNotifier,
                builder: (context, currentDays, child) {
                  return NumberPicker(
                    value: currentDays,
                    minValue: 1,
                    maxValue: 30,
                    axis: Axis.horizontal,
                    onChanged: (value) => _daysNotifier.value = value,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: _isSatisfiedNotifier,
              builder: (context, isSatisfied, child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _isSatisfiedNotifier.value = true,
                          child: const Text('滿意'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () => _isSatisfiedNotifier.value = false,
                          child: const Text('待改善'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstChild: const Icon(
                        Icons.sentiment_very_satisfied,
                        size: 50,
                      ),
                      secondChild: const Icon(
                        Icons.sentiment_dissatisfied,
                        size: 50,
                      ),
                      crossFadeState: isSatisfied
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<String?>(
              valueListenable: _imagePathNotifier,
              builder: (context, path, child) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('挑選相簿照片'),
                    ),
                    const SizedBox(height: 12),
                    path != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(path),
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 150,
                            width: double.infinity,
                            color: Colors.grey,
                            child: const Center(child: Text('尚未挑選照片')),
                          ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('請輸入景點名稱')));
                    return;
                  }

                  final result = TravelItem(
                    title: _titleController.text.trim(),
                    transport: _transportNotifier.value,
                    days: _daysNotifier.value,
                    imagePath: _imagePathNotifier.value,
                    isSatisfied: _isSatisfiedNotifier.value,
                  );
                  Navigator.pop(context, result);
                },
                child: const Text('儲存日記'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
