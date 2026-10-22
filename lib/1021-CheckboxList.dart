import 'package:flutter/material.dart';

const List<String> cities = ["洛杉磯", "鳳凰城", "紐約", "休士頓"];

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final ValueNotifier<String> _cityName = ValueNotifier<String>("");

  final ValueNotifier<int> _selectedCity = ValueNotifier<int>(0);

  @override
  void dispose() {
    _cityName.dispose();
    _selectedCity.dispose();
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

            child: ValueListenableBuilder<int>(
              valueListenable: _selectedCity,
              builder: _radioButtonBuilder,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                _cityName.value = cities[_selectedCity.value];
              },
              child: const Text("確定"),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ValueListenableBuilder<String>(
              valueListenable: _cityName,
              builder: _cityNameWidgetBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cityNameWidgetBuilder(
    BuildContext context,
    String cityName,
    Widget? child,
  ) {
    return Text(cityName, style: const TextStyle(fontSize: 20.0));
  }

  Widget _radioButtonBuilder(
    BuildContext context,
    int selectedCity,
    Widget? child,
  ) {
    final List<Widget> radioItems = [];

    for (var i = 0; i < cities.length; i++) {
      radioItems.add(
        RadioListTile<int>(
          value: i,

          // ignore: deprecated_member_use
          groupValue: selectedCity,
          title: Text(cities[i], style: const TextStyle(fontSize: 20.0)),

          // ignore: deprecated_member_use
          onChanged: (int? value) {
            if (value != null) {
              _selectedCity.value = value;
            }
          },
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: radioItems,
    );
  }
}
