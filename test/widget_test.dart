import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_appl_1/main.dart';

void main() {
  testWidgets('Dropdown menu is shown and can be selected', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Dropdown Menu Button'), findsOneWidget);
    expect(find.text('請選擇'), findsOneWidget);

    await tester.tap(find.text('請選擇'));
    await tester.pumpAndSettle();

    expect(find.text('蘋果'), findsOneWidget);

    await tester.tap(find.text('蘋果').last);
    await tester.pumpAndSettle();
    expect(find.text('蘋果'), findsOneWidget);
  });
}
