import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight device-only preferences (never synced, privacy-neutral).
class AppPrefs {
  AppPrefs(this._prefs);

  static const _kOnboardingComplete = 'onboarding_complete';

  final SharedPreferences _prefs;

  bool get onboardingComplete => _prefs.getBool(_kOnboardingComplete) ?? false;

  Future<void> setOnboardingComplete() =>
      _prefs.setBool(_kOnboardingComplete, true);
}

/// Overridden with a real instance in main().
final appPrefsProvider = Provider<AppPrefs>(
  (_) => throw UnimplementedError('appPrefsProvider must be overridden in main()'),
);
