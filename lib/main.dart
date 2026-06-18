import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/constants/navigation_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive storage for local persistence
  await Hive.initFlutter();
  await Hive.openBox('settings');
  
  runApp(
    const ProviderScope(
      child: SooubhApp(),
    ),
  );
}

class SooubhApp extends StatelessWidget {
  const SooubhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sooubh AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: kIsWeb ? NavigationRoutes.dashboard : NavigationRoutes.mainShell,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
