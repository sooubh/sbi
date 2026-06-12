import '../demo_catalog.dart';
import 'firestore_repository.dart';

/// Seeds the PRD section 12 demo scenarios into Firestore, once per user.
class DemoSeeder {
  DemoSeeder._();

  static Future<void> seedIfNeeded(FirestoreRepository repo) async {
    try {
      if (await repo.hasSeedData()) return;
      final now = DateTime.now();
      await repo.seedAll(
        goals: DemoCatalog.goals,
        events: DemoCatalog.events(now),
        recommendations: DemoCatalog.recommendations,
        timeline: DemoCatalog.timeline(now),
        signals: DemoCatalog.signals(now),
      );
    } catch (_) {
      // Seeding is best-effort; the app continues with local demo data.
    }
  }
}
