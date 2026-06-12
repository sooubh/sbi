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

    // Advance the clock by 3 seconds to trigger the navigation from splash screen.
    // We use pump(duration) instead of pumpAndSettle because SplashScreen 
    // contains an infinite CircularProgressIndicator.
    await tester.pump(const Duration(seconds: 3));
    
    // Pump one more frame to process the navigation result.
    await tester.pump();

    // Verify that the app pumps without error.
    expect(tester.takeException(), isNull);
  });
}
