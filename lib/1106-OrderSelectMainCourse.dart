import 'package:flutter/material.dart';
import 'package:flutter_app_1/20261106_OrderData.dart';

class SelectMainCourse extends StatelessWidget {
  SelectMainCourse({super.key});

  final List<String> _mainCourses = ['牛肉麵', '排骨飯', '魚排飯'];

  final ValueNotifier<int?> _selectedItem = ValueNotifier<int?>(Data.mainCourseItem);

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () => _backToHomePage(context),
      child: Scaffold(
        appBar: AppBar(title: const Text('選擇主餐')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ValueListenableBuilder<int?>(
                  valueListenable: _selectedItem, 
                  builder: (
                    BuildContext context,
                    int? selectedItem,
                    Widget? child,
                  ){
                    return Column(
                      children: List.generate(_mainCourses.length, (index){
                        return RadioListTile(
                          value: index,
                          groupValue: selectedItem,
                          title: Text(
                            _mainCourses[index],
                            style: const TextStyle(fontSize: 20.0),                            
                          ),
                          onChanged: (value){
                            _selectedItem.value = value;
                          },
                        );
                      }),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => _backToHomePage(context), 
                child: const Text('確定'),
              ),
            ],
          ),
        ),
      ), 
    );
  }

  Future<bool> _backToHomePage(BuildContext context) async {
    Data.mainCourseItem = _selectedItem.value;

    final String? mainCourse = Data.mainCourseItem != null?
        _mainCourses[Data.mainCourseItem!] : null;

    Navigator.pop(context, mainCourse);
    return true;
  }
}