import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final ValueNotifier<String> _text = ValueNotifier<String>("");

  final ValueNotifier<int> _age = ValueNotifier<int>(20);

  static const int _maxAge = 100;
  static const int _minAge = 0;

  @override
  void dispose() {
    _age.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: _age,
            builder: (context, selectedAge, _) {
              return NumberPicker(
                minValue: _minAge,
                maxValue: _maxAge,
                value: selectedAge,
                onChanged: (newValue) => _age.value = newValue,
              );
            },
          ),

          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => {_text.value = "年齡： ${_age.value} 歲"},
            child: const Text("確定"),
          ),

          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: _text,
            builder: (context, text, _) {
              return Text(text, style: const TextStyle(fontSize: 20.0));
            },
          ),
        ],
      ),
    );
  }
}
