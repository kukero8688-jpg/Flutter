import 'package:flutter/material.dart';

//執行時請用1014Textfield03.dart run

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final ValueNotifier<String> _inputName = ValueNotifier<String>("");

  final TextEditingController _namecontroller = TextEditingController();

  @override
  void dispose() {
    _inputName.dispose();
    _namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 200.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0),

            child: TextField(
              controller: _namecontroller,
              style: const TextStyle(fontSize: 20.0),
              decoration: const InputDecoration(
                labelText: "請輸入姓名",
                labelStyle: TextStyle(fontSize: 20.0),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _inputName.value = _namecontroller.text;
                });
              },
              child: const Text("送出"),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ValueListenableBuilder<String>(
              valueListenable: _inputName,
              builder: _inputNameWidgetBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputNameWidgetBuilder(
    BuildContext context,
    String inputName,
    Widget? child,
  ) {
    return Text(inputName, style: const TextStyle(fontSize: 20.0));
  }
}
