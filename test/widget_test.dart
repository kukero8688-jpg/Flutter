import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_appl_1/main.dart';

void main() {
  testWidgets('Browse image page displays and switches images', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    Finder imageAsset(String assetName) {
      return find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName == assetName,
      );
    }

    expect(find.text('Browse Image 1'), findsOneWidget);
    expect(imageAsset('assets/images/1.png'), findsOneWidget);

    await tester.tap(find.byType(IconButton).last);
    await tester.pump();
    expect(imageAsset('assets/images/2.png'), findsOneWidget);

    await tester.tap(find.byType(IconButton).first);
    await tester.pump();
    expect(imageAsset('assets/images/1.png'), findsOneWidget);
  });
}
