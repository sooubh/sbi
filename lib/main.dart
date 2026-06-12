import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/database/isar_service.dart';
import 'services/app_prefs.dart';
import 'services/firebase/firebase_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isarService = await IsarService.init();
  
  final container = ProviderContainer(
    overrides: [
      appPrefsProvider.overrideWithValue(AppPrefs(prefs)),
      isarServiceProvider.overrideWithValue(isarService),
    ],
  );
  
  // Firebase is optional at runtime: the app degrades to local demo mode
  // when platform config is absent (fresh clone without `flutterfire configure`).
  await FirebaseBootstrap.init(container);
  runApp(UncontrolledProviderScope(container: container, child: const CompassApp()));
}
