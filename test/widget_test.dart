// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:compass/app.dart';

void main() {
  testWidgets('App starts smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CompassApp());

    // Wait for splash screen animations and navigation to complete.
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify that the app pumps without error.
    expect(tester.takeException(), isNull);
  });
}
