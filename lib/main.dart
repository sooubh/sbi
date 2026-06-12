import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'services/firebase/firebase_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // Firebase is optional at runtime: the app degrades to local demo mode
  // when platform config is absent (fresh clone without `flutterfire configure`).
  await FirebaseBootstrap.init(container);
  runApp(UncontrolledProviderScope(container: container, child: const CompassApp()));
}
