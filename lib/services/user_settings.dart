import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/privacy/privacy_level.dart';
import 'firebase/firestore_repository.dart';

/// User-controlled privacy and AI preferences (PRD Feature 8).
class UserSettings {
  const UserSettings({
    this.privacyLevel = PrivacyLevel.standard,
    this.detailedInsights = true,
    this.demoConsent = true,
    this.eventTracking = true,
    this.goalTracking = true,
    this.chatExplanations = true,
  });

  final PrivacyLevel privacyLevel;

  /// Insight detail level: when off, insights stay generic regardless of
  /// the personalization level.
  final bool detailedInsights;
  final bool demoConsent;
  final bool eventTracking;
  final bool goalTracking;
  final bool chatExplanations;

  UserSettings copyWith({
    PrivacyLevel? privacyLevel,
    bool? detailedInsights,
    bool? demoConsent,
    bool? eventTracking,
    bool? goalTracking,
    bool? chatExplanations,
  }) {
    return UserSettings(
      privacyLevel: privacyLevel ?? this.privacyLevel,
      detailedInsights: detailedInsights ?? this.detailedInsights,
      demoConsent: demoConsent ?? this.demoConsent,
      eventTracking: eventTracking ?? this.eventTracking,
      goalTracking: goalTracking ?? this.goalTracking,
      chatExplanations: chatExplanations ?? this.chatExplanations,
    );
  }

  /// `privacySettings` map in the PRD `users` document.
  Map<String, dynamic> toMap() => {
        'detailedInsights': detailedInsights,
        'demoConsent': demoConsent,
        'eventTracking': eventTracking,
        'goalTracking': goalTracking,
        'chatExplanations': chatExplanations,
      };
}

class UserSettingsNotifier extends Notifier<UserSettings> {
  @override
  UserSettings build() => const UserSettings();

  /// Updates state and persists privacy settings to Firestore when available.
  void _update(UserSettings next) {
    state = next;
    ref.read(firestoreRepositoryProvider)?.saveUserSettings(next).ignore();
  }

  void setPrivacyLevel(PrivacyLevel level) =>
      _update(state.copyWith(privacyLevel: level));
  void setDetailedInsights(bool value) =>
      _update(state.copyWith(detailedInsights: value));
  void setDemoConsent(bool value) => _update(state.copyWith(demoConsent: value));
  void setEventTracking(bool value) =>
      _update(state.copyWith(eventTracking: value));
  void setGoalTracking(bool value) =>
      _update(state.copyWith(goalTracking: value));
  void setChatExplanations(bool value) =>
      _update(state.copyWith(chatExplanations: value));
}

final userSettingsProvider =
    NotifierProvider<UserSettingsNotifier, UserSettings>(
  UserSettingsNotifier.new,
);
