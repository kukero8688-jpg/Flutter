import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

import 'homepage.dart';

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
