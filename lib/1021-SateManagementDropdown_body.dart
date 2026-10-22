import 'package:flutter/material.dart';

const List<String> trans = ["高鐵", "台鐵", "捷運"];

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final ValueNotifier<String> _itemName = ValueNotifier<String>("");

  final ValueNotifier<int> _selectedItem = ValueNotifier<int>(-1);

  @override
  void dispose() {
    _itemName.dispose();
    _selectedItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),

            child: ValueListenableBuilder(
              valueListenable: _selectedItem,
              builder: _dropdownButtonBuilder,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                _itemName.value = _selectedItem.value < 0
                    ? ""
                    : trans[_selectedItem.value];
              },
              child: const Text("確定"),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ValueListenableBuilder<String>(
              valueListenable: _itemName,
              builder: _itemNameWidgetBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemNameWidgetBuilder(
    BuildContext context,
    String itemName,
    Widget? child,
  ) {
    return Text(itemName, style: const TextStyle(fontSize: 20.0));
  }

  Widget _dropdownButtonBuilder(
    BuildContext context,
    int selectedItem,
    Widget? child,
  ) {
    return DropdownButton<int>(
      hint: const Text("請選擇交通工具", style: TextStyle(fontSize: 20.0)),
      value: selectedItem < 0 ? null : selectedItem,

      items: const <DropdownMenuItem<int>>[
        DropdownMenuItem<int>(
          value: 0,
          child: Text("高鐵", style: TextStyle(fontSize: 20.0)),
        ),

        DropdownMenuItem<int>(
          value: 1,
          child: Text("台鐵", style: TextStyle(fontSize: 20.0)),
        ),

        DropdownMenuItem<int>(
          value: 2,
          child: Text("捷運", style: TextStyle(fontSize: 20.0)),
        ),
      ],

      onChanged: (int? value) {
        if (value != null) {
          _selectedItem.value = value;
        }
      },
    );
  }
}
