import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/privacy/privacy_level.dart';

/// User-controlled privacy and AI preferences (PRD Feature 8).
class UserSettings {
  const UserSettings({
    this.privacyLevel = PrivacyLevel.standard,
    this.demoConsent = true,
    this.eventTracking = true,
    this.goalTracking = true,
    this.chatExplanations = true,
  });

  final PrivacyLevel privacyLevel;
  final bool demoConsent;
  final bool eventTracking;
  final bool goalTracking;
  final bool chatExplanations;

  UserSettings copyWith({
    PrivacyLevel? privacyLevel,
    bool? demoConsent,
    bool? eventTracking,
    bool? goalTracking,
    bool? chatExplanations,
  }) {
    return UserSettings(
      privacyLevel: privacyLevel ?? this.privacyLevel,
      demoConsent: demoConsent ?? this.demoConsent,
      eventTracking: eventTracking ?? this.eventTracking,
      goalTracking: goalTracking ?? this.goalTracking,
      chatExplanations: chatExplanations ?? this.chatExplanations,
    );
  }
}

class UserSettingsNotifier extends Notifier<UserSettings> {
  @override
  UserSettings build() => const UserSettings();

  void setPrivacyLevel(PrivacyLevel level) =>
      state = state.copyWith(privacyLevel: level);
  void setDemoConsent(bool value) => state = state.copyWith(demoConsent: value);
  void setEventTracking(bool value) =>
      state = state.copyWith(eventTracking: value);
  void setGoalTracking(bool value) =>
      state = state.copyWith(goalTracking: value);
  void setChatExplanations(bool value) =>
      state = state.copyWith(chatExplanations: value);
}

final userSettingsProvider =
    NotifierProvider<UserSettingsNotifier, UserSettings>(
  UserSettingsNotifier.new,
);
