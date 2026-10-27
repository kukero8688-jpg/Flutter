import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_appl_1/1027-MultiImage.dart';

void main() {
  testWidgets('Image picker page displays its controls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('挑選照片'), findsOneWidget);
    expect(find.text('相機拍照'), findsOneWidget);
    expect(find.text('挑選相簿照片'), findsOneWidget);
    expect(find.text('尚未選擇照片'), findsOneWidget);
  });
}
