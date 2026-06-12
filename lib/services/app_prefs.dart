import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight device-only preferences (never synced, privacy-neutral).
class AppPrefs {
  AppPrefs(this._prefs);

  static const _kOnboardingComplete = 'onboarding_complete';
  static const _kPersona = 'demo_persona';

  final SharedPreferences _prefs;

  bool get onboardingComplete => _prefs.getBool(_kOnboardingComplete) ?? false;

  Future<void> setOnboardingComplete() =>
      _prefs.setBool(_kOnboardingComplete, true);

  String? get personaName => _prefs.getString(_kPersona);

  Future<void> setPersona(String name) => _prefs.setString(_kPersona, name);
}

/// Overridden with a real instance in main().
final appPrefsProvider = Provider<AppPrefs>(
  (_) => throw UnimplementedError('appPrefsProvider must be overridden in main()'),
);
