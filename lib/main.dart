import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/database/isar_service.dart';
import 'domain/services/ai_service.dart';
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
  
  // Initialize local llama.cpp model if present in App Documents directory
  try {
    final documentsDir = await getApplicationDocumentsDirectory();
    final localModelPath = '${documentsDir.path}/model.gguf';
    await container.read(aiServiceProvider).initLocalModel(localModelPath);
  } catch (e) {
    debugPrint('Failed to initialize local model path: $e');
  }
  
  // Firebase is optional at runtime: the app degrades to local demo mode
  // when platform config is absent (fresh clone without `flutterfire configure`).
  await FirebaseBootstrap.init(container);
  runApp(UncontrolledProviderScope(container: container, child: const CompassApp()));
}
