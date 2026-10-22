import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: AppBody())));
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(heightFactor: 5.0, child: _DropdownWidget());
  }
}

class _DropdownWidget extends StatefulWidget {
  const _DropdownWidget();

  @override
  State<_DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<_DropdownWidget> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      hint: const Text("請選擇", style: TextStyle(fontSize: 20.0)),

      value: selectedValue,

      items: const <DropdownMenuItem<int>>[
        DropdownMenuItem<int>(
          value: 1,
          child: Text("蘋果", style: TextStyle(fontSize: 20.0)),
        ),

        DropdownMenuItem<int>(
          value: 2,
          child: Text("香蕉", style: TextStyle(fontSize: 20.0)),
        ),

        DropdownMenuItem<int>(
          value: 3,
          child: Text("橘子", style: TextStyle(fontSize: 20.0)),
        ),
      ],
      onChanged: (int? value) {
        setState(() {
          selectedValue = value;
        });
      },
    );
  }
}
