import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llama_cpp_dart/llama_cpp_dart.dart';

import 'gemini_service.dart';

class AiService {
  AiService(this._ref);

  final Ref _ref;
  Llama? _localLlama;
  bool _initialized = false;

  /// Initializes the local llama.cpp engine if a model is found on the device.
  Future<void> initLocalModel(String modelPath) async {
    if (_initialized) return;
    if (File(modelPath).existsSync()) {
      try {
        // Run initialization inside a separate thread/isolate if supported,
        // or directly in try-catch to avoid app crashes.
        _localLlama = Llama(modelPath);
        _initialized = true;
      } catch (e) {
        debugPrint('AiService: Native llama.cpp initialization failed: $e. Falling back to local templates.');
      }
    } else {
      debugPrint('AiService: No local GGUF model found at $modelPath. Running in local template mode.');
    }
  }

  /// Master generate method: Checks cloud availability, then tries local llama.cpp,
  /// and finally falls back to the deterministic, offline-first template generator.
  Future<String> generate({
    required String systemPrompt,
    required String prompt,
    required String fallbackResponse,
  }) async {
    // 1. Try Gemini Cloud Enhancement if enabled
    try {
      final gemini = _ref.read(geminiServiceProvider);
      final remoteResponse = await gemini.generate('$systemPrompt\n\nUser: $prompt');
      if (remoteResponse != null && remoteResponse.trim().isNotEmpty) {
        return remoteResponse.trim();
      }
    } catch (_) {}

    // 2. Try on-device llama.cpp if loaded
    final llama = _localLlama;
    if (llama != null) {
      try {
        final fullPrompt = '$systemPrompt\n\nPrompt: $prompt\nResponse:';
        llama.setPrompt(fullPrompt);
        final buffer = StringBuffer();
        int tokenCount = 0;
        while (tokenCount < 500) {
          final (token, done) = llama.getNext();
          buffer.write(token);
          if (done) break;
          tokenCount++;
        }
        final response = buffer.toString();
        if (response.trim().isNotEmpty) {
          return response.trim();
        }
      } catch (e) {
        debugPrint('AiService: Llama inference failed: $e. Using fallback template.');
      }
    }

    // 3. Fallback to high-quality local template
    return fallbackResponse;
  }

  /// Generates a local, personal weekly financial story narrative.
  Future<String> generateWeeklyStoryNarrative({
    required String firstName,
    required int healthDelta,
    required int finalScore,
    required String topGoalName,
    required int topGoalProgress,
    required bool hasSavingsStreak,
    required int streakDays,
  }) async {
    final deltaText = healthDelta >= 0 ? 'grew by $healthDelta points' : 'changed by $healthDelta points';
    final streakText = hasSavingsStreak 
        ? 'You maintained your $streakDays-day savings consistency streak. Consistency beats intensity!'
        : 'Starting a small weekly automated savings habit is the best way to kick off a new streak.';

    const systemPrompt = 'You are Compass, a warm, celebratory on-device financial assistant. Write a personal weekly recap.';
    final prompt = 'User: $firstName. Health score: $finalScore ($deltaText). Top Goal: $topGoalName ($topGoalProgress% progress). Savings streak: $streakDays days.';
    
    final fallbackResponse = 'Hey $firstName! What a week. Your Financial Health Score $deltaText to end at $finalScore/100. '
        'You made great strides toward your "$topGoalName" goal, which has reached $topGoalProgress% completion. '
        '$streakText Keep up the great momentum and watch your habits shape your future!';

    return generate(
      systemPrompt: systemPrompt,
      prompt: prompt,
      fallbackResponse: fallbackResponse,
    );
  }

  /// Generates goal coaching responses.
  Future<String> generateGoalCoaching({
    required String firstName,
    required String goalName,
    required String category,
    required int progressPercent,
    required String milestoneContext,
  }) async {
    const systemPrompt = 'You are a supportive, high-context on-device goal coach. Provide a short 2-sentence response.';
    final prompt = 'User: $firstName. Goal: $goalName ($category category) is at $progressPercent%. Context: $milestoneContext.';
    
    final fallbackResponse = 'Great progress on your "$goalName", $firstName! You have reached $progressPercent% of your target. '
        'Every small milestone builds momentum — stay consistent and keep taking small savings steps!';

    return generate(
      systemPrompt: systemPrompt,
      prompt: prompt,
      fallbackResponse: fallbackResponse,
    );
  }

  /// Generates health score explanations.
  Future<String> generateHealthScoreExplanation({
    required String firstName,
    required int score,
    required int savings,
    required int consistency,
    required int goals,
    required int spending,
    required int stability,
  }) async {
    const systemPrompt = 'Explain a financial health score in 2 sentences. Focus on positive growth.';
    final prompt = 'Score: $score. Sub-scores: Savings $savings/100, Consistency $consistency/100, Goals $goals/100, Spending $spending/100, Stability $stability/100.';
    
    final fallbackResponse = 'Your overall score of $score indicates solid financial habits, $firstName. '
        'Your savings consistency ($consistency/100) and goal progress ($goals/100) are driving this positive momentum. '
        'Consider focusing a bit more on spending control ($spending/100) to unlock even higher scores next month.';

    return generate(
      systemPrompt: systemPrompt,
      prompt: prompt,
      fallbackResponse: fallbackResponse,
    );
  }
}

final aiServiceProvider = Provider<AiService>(AiService.new);
