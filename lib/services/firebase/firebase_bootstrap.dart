import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'demo_seeder.dart';
import 'firestore_repository.dart';

/// Whether Firebase initialized successfully for this run.
final firebaseAvailableProvider = StateProvider<bool>((_) => false);

/// The signed-in (anonymous) Firebase user id, when available.
final currentUserIdProvider = StateProvider<String?>((_) => null);

/// Initializes Firebase + anonymous auth and triggers demo seeding.
/// Failing closed into local demo mode keeps the prototype runnable
/// without platform configuration.
class FirebaseBootstrap {
  FirebaseBootstrap._();

  static Future<void> init(ProviderContainer container) async {
    try {
      await Firebase.initializeApp();
      final credential = await FirebaseAuth.instance.signInAnonymously();
      container.read(firebaseAvailableProvider.notifier).state = true;
      container.read(currentUserIdProvider.notifier).state = credential.user?.uid;
      final repo = container.read(firestoreRepositoryProvider);
      if (repo != null) unawaited(DemoSeeder.seedIfNeeded(repo));
    } catch (error) {
      debugPrint('Compass: Firebase unavailable, using local demo mode. $error');
    }
  }
}
