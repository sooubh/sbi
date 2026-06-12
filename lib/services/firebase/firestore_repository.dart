import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/privacy/safe_signal.dart';
import '../../models/goal.dart';
import '../../models/insight.dart';
import '../../models/life_event.dart';
import '../../models/recommendation.dart';
import '../../models/timeline_entry.dart';
import '../user_settings.dart';
import 'firebase_bootstrap.dart';
import 'firestore_paths.dart';

/// Typed access to the PRD section 10 Firestore schema, scoped to one user.
class FirestoreRepository {
  FirestoreRepository(this._db, this.userId);

  final FirebaseFirestore _db;
  final String userId;

  Query<Map<String, dynamic>> _owned(String collection) =>
      _db.collection(collection).where('userId', isEqualTo: userId);

  /// Converts Firestore [Timestamp]s to [DateTime] so models stay
  /// independent of the Firestore SDK.
  Map<String, dynamic> _normalize(Map<String, dynamic> data) => {
        for (final entry in data.entries)
          entry.key: entry.value is Timestamp
              ? (entry.value as Timestamp).toDate()
              : entry.value,
      };

  // --- users -------------------------------------------------------------

  Future<void> saveUserSettings(UserSettings settings) {
    return _db.collection(FirestorePaths.users).doc(userId).set({
      'personalizationLevel': settings.privacyLevel.name,
      'privacySettings': settings.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // --- goals -------------------------------------------------------------

  Future<List<Goal>> fetchGoals() async {
    final snapshot = await _owned(FirestorePaths.goals).get();
    return [
      for (final doc in snapshot.docs) Goal.fromMap(doc.id, _normalize(doc.data())),
    ];
  }

  Future<void> addGoal(Goal goal) =>
      _db.collection(FirestorePaths.goals).doc(goal.id).set(goal.toMap(userId));

  // --- events ------------------------------------------------------------

  Future<List<LifeEvent>> fetchEvents() async {
    final snapshot = await _owned(FirestorePaths.events).get();
    final events = [
      for (final doc in snapshot.docs)
        LifeEvent.fromMap(doc.id, _normalize(doc.data())),
    ];
    events.sort((a, b) => b.detectedAt.compareTo(a.detectedAt));
    return events;
  }

  // --- recommendations ---------------------------------------------------

  Future<List<Recommendation>> fetchRecommendations() async {
    final snapshot = await _owned(FirestorePaths.recommendations).get();
    return [
      for (final doc in snapshot.docs)
        Recommendation.fromMap(doc.id, _normalize(doc.data())),
    ];
  }

  Future<void> setRecommendationStatus(String id, RecommendationStatus status) =>
      _db
          .collection(FirestorePaths.recommendations)
          .doc(id)
          .set({'status': status.name}, SetOptions(merge: true));

  // --- timeline ------------------------------------------------------------

  Future<List<TimelineEntry>> fetchTimeline() async {
    final snapshot = await _owned(FirestorePaths.timeline).get();
    final entries = [
      for (final doc in snapshot.docs)
        TimelineEntry.fromMap(doc.id, _normalize(doc.data())),
    ];
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }

  // --- financialSignals ----------------------------------------------------

  Future<void> logSignal(SafeSignal signal) => _db
      .collection(FirestorePaths.financialSignals)
      .add({'userId': userId, ...signal.toMap()});

  // --- AI insights & sessions ----------------------------------------------

  /// Insights written by the generateInsightOnSignal Cloud Function.
  Future<List<Insight>> fetchAiInsights() async {
    final snapshot = await _owned(FirestorePaths.insights).get();
    return [
      for (final doc in snapshot.docs)
        Insight.fromMap(doc.id, _normalize(doc.data())),
    ];
  }

  /// PRD `aiSessions` document: promptType, responseType, privacyLevel.
  Future<void> logAiSession({
    required String promptType,
    required String responseType,
    required String privacyLevel,
  }) =>
      _db.collection(FirestorePaths.aiSessions).add({
        'userId': userId,
        'promptType': promptType,
        'responseType': responseType,
        'privacyLevel': privacyLevel,
        'createdAt': FieldValue.serverTimestamp(),
      });

  // --- seeding ---------------------------------------------------------------

  Future<bool> hasSeedData() async {
    final snapshot = await _owned(FirestorePaths.goals).limit(1).get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> seedAll({
    required List<Goal> goals,
    required List<LifeEvent> events,
    required List<Recommendation> recommendations,
    required List<TimelineEntry> timeline,
    required List<SafeSignal> signals,
  }) async {
    final batch = _db.batch();
    batch.set(
      _db.collection(FirestorePaths.users).doc(userId),
      {
        'name': 'Aarav Rao',
        'email': 'demo@compass.app',
        'personalizationLevel': 'standard',
        'createdAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
    for (final goal in goals) {
      batch.set(_db.collection(FirestorePaths.goals).doc(goal.id), goal.toMap(userId));
    }
    for (final event in events) {
      batch.set(_db.collection(FirestorePaths.events).doc(event.id), event.toMap(userId));
    }
    for (final rec in recommendations) {
      batch.set(_db.collection(FirestorePaths.recommendations).doc(rec.id), rec.toMap(userId));
    }
    for (final entry in timeline) {
      batch.set(_db.collection(FirestorePaths.timeline).doc(entry.id), entry.toMap(userId));
    }
    for (final signal in signals) {
      batch.set(
        _db.collection(FirestorePaths.financialSignals).doc(),
        {'userId': userId, ...signal.toMap()},
      );
    }
    await batch.commit();
  }
}

/// Null when Firebase is not configured — consumers fall back to demo data.
final firestoreRepositoryProvider = Provider<FirestoreRepository?>((ref) {
  if (!ref.watch(firebaseAvailableProvider)) return null;
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return null;
  return FirestoreRepository(FirebaseFirestore.instance, userId);
});
