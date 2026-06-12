import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../services/user_settings.dart';

class GeminiService {
  GeminiService(this._ref);

  final Ref _ref;

  /// Generates a response using the Gemini API. Only called if Cloud Enhancement
  /// is enabled in Settings and the device is connected to the internet.
  Future<String?> generate(String prompt) async {
    final settings = _ref.read(userSettingsProvider);
    if (!settings.demoConsent) {
      // If user hasn't consented to sharing demo signals, abort.
      return null;
    }

    try {
      // In a hackathon demo, we read the API key from environment, metadata or fallback.
      const apiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
      if (apiKey.isEmpty) return null;

      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text;
    } catch (e) {
      // Degrade gracefully if offline or request fails
      return null;
    }
  }
}

final geminiServiceProvider = Provider<GeminiService>(GeminiService.new);
