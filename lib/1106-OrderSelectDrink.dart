import 'package:flutter/material.dart';
import 'package:flutter_app_1/1106-OrderData.dart';

class SelectDrink extends StatelessWidget {
  SelectDrink({super.key});

  final List<String> _drinkList = ['紅茶', '綠茶', '烏龍茶'];

  final ValueNotifier<int?> _selectedItem = ValueNotifier<int?>(Data.drinkItem);

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async { _backToHomePage(context);
      return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('選擇飲料')),
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
                      children: List.generate(_drinkList.length, (index){
                        return RadioListTile(
                          value: index,
                          groupValue: selectedItem,
                          title: Text(
                            _drinkList[index],
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

  void _backToHomePage(BuildContext context){
    Data.drinkItem = _selectedItem.value;

    final String? drink = Data.drinkItem != null?
    _drinkList[Data.drinkItem!] : null;

    Navigator.pop(context, drink);
  }
}