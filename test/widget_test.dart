import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbi/main.dart';

void main() {
  testWidgets('App launches and displays Home screen stub', (WidgetTester tester) async {
    // Build our app under ProviderScope and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: SooubhApp(),
      ),
    );

    // Verify that the home screen stub is displayed
    expect(find.text('Home Screen (Stub)'), findsOneWidget);
  });
}
