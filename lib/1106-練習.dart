import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue),
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
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddLogPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(position: offsetAnimation, child: child);
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
      const SnackBar(content: Text('已刪除該筆日記'), duration: Duration(seconds: 2)),
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
              const PopupMenuItem(value: 'sort', child: Text('依評分排序')),
              const PopupMenuDivider(),
              const PopupMenuItem(value: 'clear', child: Text('清除全部')),
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
                title: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${item.transport} ｜ ${item.days} 天 ｜ ${item.isSatisfied ? "★ 滿意" : "☆ 待改善"}',
                ),
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

class AddLogPage extends StatefulWidget {
  const AddLogPage({super.key});

  @override
  State<AddLogPage> createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {
  final TextEditingController _titleController = TextEditingController();
  final ValueNotifier<String> _transportNotifier = ValueNotifier('高鐵');
  final ValueNotifier<int> _daysNotifier = ValueNotifier(1);
  final ValueNotifier<bool> _isSatisfiedNotifier = ValueNotifier(true);
  final ValueNotifier<XFile?> _imageFileNotifier = ValueNotifier(null);
  final ImagePicker _imagePicker = ImagePicker();

  final List<String> _transportOptions = ['高鐵', '火車', '自行開車', '飛機'];

  @override
  void dispose() {
    _titleController.dispose();
    _transportNotifier.dispose();
    _daysNotifier.dispose();
    _isSatisfiedNotifier.dispose();
    _imageFileNotifier.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      _imageFileNotifier.value = file;
    }
  }

  void _saveLog() {
    final String title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('請輸入景點名稱'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final newItem = TravelItem(
      title: title,
      transport: _transportNotifier.value,
      days: _daysNotifier.value,
      imagePath: _imageFileNotifier.value?.path,
      isSatisfied: _isSatisfiedNotifier.value,
    );

    Navigator.pop(context, newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新增手札頁')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '景點名稱',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '請輸入景點名稱',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '交通工具選擇',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<String>(
              valueListenable: _transportNotifier,
              builder: (context, selectedTransport, _) {
                return DropdownButton<String>(
                  value: selectedTransport,
                  isExpanded: true,
                  items: _transportOptions.map((String transport) {
                    return DropdownMenuItem<String>(
                      value: transport,
                      child: Text(
                        transport,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _transportNotifier.value = newValue;
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '旅遊停留天數',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Center(
              child: ValueListenableBuilder<int>(
                valueListenable: _daysNotifier,
                builder: (context, days, _) {
                  return NumberPicker(
                    value: days,
                    minValue: 1,
                    maxValue: 30,
                    onChanged: (newValue) => _daysNotifier.value = newValue,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '滿意度評分',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<bool>(
              valueListenable: _isSatisfiedNotifier,
              builder: (context, isSatisfied, _) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _isSatisfiedNotifier.value =
                            !_isSatisfiedNotifier.value;
                      },
                      child: Text(isSatisfied ? '目前狀態：滿意' : '目前狀態：待改善'),
                    ),
                    const SizedBox(height: 10),
                    AnimatedCrossFade(
                      duration: const Duration(seconds: 1),
                      crossFadeState: isSatisfied
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Container(
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                          size: 60,
                        ),
                      ),
                      secondChild: Container(
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.red,
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '景點照片上傳',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text('挑選相簿照片'),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<XFile?>(
              valueListenable: _imageFileNotifier,
              builder: (context, imageFile, _) {
                if (imageFile != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imageFile.path),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '尚未挑選照片',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveLog,
                child: const Text('儲存日記', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
