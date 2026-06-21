import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

// ─────────────────────────────────────────────────────────────────────────────
// Gemini Live Session Events
// ─────────────────────────────────────────────────────────────────────────────

enum GeminiLiveStatus { idle, connecting, connected, thinking, responding, error, closed }

class GeminiLiveMessage {
  final String text;
  final bool isComplete;
  final bool isFromUser;

  const GeminiLiveMessage({
    required this.text,
    required this.isComplete,
    required this.isFromUser,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Gemini Live WebSocket Service
// Connects to:
// wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta
//   .GenerativeService.BidiGenerateContent?key=API_KEY
// ─────────────────────────────────────────────────────────────────────────────

class GeminiLiveService {
  static const String _model = 'gemini-2.5-flash';
  static const String _wsBase =
      'wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta.GenerativeService.BidiGenerateContent';

  final String apiKey;
  final String systemPrompt;
  final void Function(String toolName, Map<String, dynamic> args)? onToolCall;

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  // Public streams
  final StreamController<GeminiLiveStatus> _statusController =
      StreamController<GeminiLiveStatus>.broadcast();
  final StreamController<GeminiLiveMessage> _messageController =
      StreamController<GeminiLiveMessage>.broadcast();

  Stream<GeminiLiveStatus> get statusStream => _statusController.stream;
  Stream<GeminiLiveMessage> get messageStream => _messageController.stream;

  GeminiLiveStatus _status = GeminiLiveStatus.idle;
  GeminiLiveStatus get status => _status;

  // Buffer for streaming text chunks
  final StringBuffer _textBuffer = StringBuffer();

  GeminiLiveService({
    required this.apiKey,
    required this.systemPrompt,
    this.onToolCall,
  });

  // ── Connect & setup session ──────────────────────────────────────────────

  Future<void> connect() async {
    if (_status == GeminiLiveStatus.connected || _status == GeminiLiveStatus.connecting) {
      return;
    }

    _setStatus(GeminiLiveStatus.connecting);

    try {
      final uri = Uri.parse('$_wsBase?key=$apiKey');
      _channel = WebSocketChannel.connect(uri);

      // Send BidiGenerateContent setup message with system prompt + model config
      final setupMsg = {
        'setup': {
          'model': 'models/$_model',
          'system_instruction': {
            'parts': [
              {'text': systemPrompt}
            ]
          },
          'generation_config': {
            'temperature': 0.35,
            'max_output_tokens': 600,
            'response_modalities': ['TEXT'],
          },
          if (onToolCall != null)
            'tools': [
              {
                'function_declarations': [
                  {
                    'name': 'surface_recommendation',
                    'description': 'Surfaces a recommendation card to the user\'s home screen. Use this when the user needs to take a specific action (like complete KYC, set up UPI, create a goal, or open a fixed deposit).',
                    'parameters': {
                      'type': 'OBJECT',
                      'properties': {
                        'id': {
                          'type': 'STRING',
                          'description': 'The recommendation ID to surface. Known values: \'r_kyc\', \'r_upi\', \'r_goal\', \'r_fd\'.'
                        },
                        'reason': {
                          'type': 'STRING',
                          'description': 'A compelling reason explaining why this recommendation is being surfaced right now.'
                        }
                      },
                      'required': ['id', 'reason']
                    }
                  },
                  {
                    'name': 'log_spending_insight',
                    'description': 'Logs an analysis of spending patterns to the user\'s engagement tracking system. Use this when detecting abnormal spending, high category usage, or saving opportunities.',
                    'parameters': {
                      'type': 'OBJECT',
                      'properties': {
                        'category': {
                          'type': 'STRING',
                          'description': 'The category of spending (e.g., Food, Travel, Shopping, Bills).'
                        },
                        'insight': {
                          'type': 'STRING',
                          'description': 'The detailed insight text explaining what was found.'
                        },
                        'reason': {
                          'type': 'STRING',
                          'description': 'The context/rationale behind the logged event.'
                        }
                      },
                      'required': ['category', 'insight', 'reason']
                    }
                  },
                  {
                    'name': 'boost_goal_savings',
                    'description': 'Transfers funds from the main account to a specified savings goal. Capped at a maximum amount of ₹500.',
                    'parameters': {
                      'type': 'OBJECT',
                      'properties': {
                        'goal_id': {
                          'type': 'STRING',
                          'description': 'The ID of the goal to boost (e.g., \'g001\', \'g005\', \'g006\').'
                        },
                        'amount': {
                          'type': 'NUMBER',
                          'description': 'The amount to transfer. Must be less than or equal to 500.'
                        },
                        'reason': {
                          'type': 'STRING',
                          'description': 'The explanation for the auto-saving action.'
                        }
                      },
                      'required': ['goal_id', 'amount', 'reason']
                    }
                  },
                  {
                    'name': 'suggest_service_activation',
                    'description': 'Activates a service and logs an engagement event for the user. Used for services like \'s_autosave\', \'acc_fd\', \'inv_sip\', \'ins_health\'.',
                    'parameters': {
                      'type': 'OBJECT',
                      'properties': {
                        'service_id': {
                          'type': 'STRING',
                          'description': 'The service ID to activate (e.g., \'acc_fd\', \'inv_sip\', \'s_autosave\', \'ins_health\').'
                        },
                        'reason': {
                          'type': 'STRING',
                          'description': 'Why this service is suggested and activated.'
                        }
                      },
                      'required': ['service_id', 'reason']
                    }
                  }
                ]
              }
            ]
        }
      };

      _channel!.sink.add(jsonEncode(setupMsg));

      _subscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );

      _setStatus(GeminiLiveStatus.connected);
    } catch (e) {
      debugPrint('[GeminiLive] Connection error: $e');
      _setStatus(GeminiLiveStatus.error);
    }
  }

  // ── Send a text turn to Gemini ───────────────────────────────────────────

  void sendText(String text) {
    if (_channel == null || _status == GeminiLiveStatus.error || _status == GeminiLiveStatus.closed) {
      debugPrint('[GeminiLive] Not connected. Attempting reconnect...');
      connect().then((_) => _doSendText(text));
      return;
    }
    _doSendText(text);
  }

  void _doSendText(String text) {
    _textBuffer.clear();
    _setStatus(GeminiLiveStatus.thinking);

    final clientMsg = {
      'client_content': {
        'turn_complete': true,
        'turns': [
          {
            'role': 'user',
            'parts': [
              {'text': text}
            ]
          }
        ]
      }
    };

    try {
      _channel!.sink.add(jsonEncode(clientMsg));
    } catch (e) {
      debugPrint('[GeminiLive] Send error: $e');
      _setStatus(GeminiLiveStatus.error);
    }
  }

  // ── Handle incoming WebSocket messages ──────────────────────────────────

  void _onMessage(dynamic rawData) {
    try {
      final data = jsonDecode(rawData as String) as Map<String, dynamic>;

      // Setup acknowledgment
      if (data.containsKey('setupComplete')) {
        debugPrint('[GeminiLive] Session established.');
        return;
      }

      // Server content / streaming text response
      if (data.containsKey('serverContent')) {
        final serverContent = data['serverContent'] as Map<String, dynamic>;
        final turnComplete = serverContent['turnComplete'] as bool? ?? false;

        // Extract text parts from model turn
        final modelTurn = serverContent['modelTurn'] as Map<String, dynamic>?;
        if (modelTurn != null) {
          final parts = modelTurn['parts'] as List<dynamic>? ?? [];
          for (final part in parts) {
            final partMap = part as Map<String, dynamic>;
            if (partMap.containsKey('text')) {
              final chunk = partMap['text'] as String;
              _textBuffer.write(chunk);
              _setStatus(GeminiLiveStatus.responding);

              // Emit partial chunk for streaming UI effect
              _messageController.add(GeminiLiveMessage(
                text: _textBuffer.toString(),
                isComplete: false,
                isFromUser: false,
              ));
            }
          }
        }

        // Turn is complete — emit final message
        if (turnComplete && _textBuffer.isNotEmpty) {
          _messageController.add(GeminiLiveMessage(
            text: _textBuffer.toString().trim(),
            isComplete: true,
            isFromUser: false,
          ));
          _textBuffer.clear();
          _setStatus(GeminiLiveStatus.connected);
        }
      }

      // Tool call / function call from model
      if (data.containsKey('toolCall')) {
        debugPrint('[GeminiLive] Tool call received: ${data['toolCall']}');
        final toolCall = data['toolCall'] as Map<String, dynamic>;
        final functionCalls = toolCall['functionCalls'] as List<dynamic>? ?? [];

        final responses = <Map<String, dynamic>>[];

        for (final call in functionCalls) {
          final callMap = call as Map<String, dynamic>;
          final id = callMap['id'] as String? ?? '';
          final name = callMap['name'] as String? ?? '';
          final args = callMap['args'] as Map<String, dynamic>? ?? {};

          if (name.isNotEmpty) {
            try {
              onToolCall?.call(name, args);
            } catch (e) {
              debugPrint('[GeminiLive] Error invoking onToolCall callback: $e');
            }
          }

          responses.add({
            'id': id,
            'name': name,
            'response': {'result': 'dispatched'}
          });
        }

        if (responses.isNotEmpty && _channel != null) {
          final responseMsg = {
            'tool_response': {
              'function_responses': responses
            }
          };
          try {
            _channel!.sink.add(jsonEncode(responseMsg));
            debugPrint('[GeminiLive] Sent toolResponse: ${jsonEncode(responseMsg)}');
          } catch (e) {
            debugPrint('[GeminiLive] Error sending tool response: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('[GeminiLive] Parse error: $e | raw: $rawData');
    }
  }

  void _onError(dynamic error) {
    debugPrint('[GeminiLive] WebSocket error: $error');
    _setStatus(GeminiLiveStatus.error);
    _messageController.add(const GeminiLiveMessage(
      text: 'Connection error. Retrying with standard API...',
      isComplete: true,
      isFromUser: false,
    ));
  }

  void _onDone() {
    debugPrint('[GeminiLive] WebSocket closed.');
    _setStatus(GeminiLiveStatus.closed);
  }

  // ── Disconnect & cleanup ─────────────────────────────────────────────────

  Future<void> disconnect() async {
    await _subscription?.cancel();
    await _channel?.sink.close(ws_status.goingAway);
    _channel = null;
    _setStatus(GeminiLiveStatus.closed);
  }

  void dispose() {
    disconnect();
    _statusController.close();
    _messageController.close();
  }

  void _setStatus(GeminiLiveStatus s) {
    _status = s;
    if (!_statusController.isClosed) {
      _statusController.add(s);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Proactive suggestion — what the AI should say first on home screen load
// ─────────────────────────────────────────────────────────────────────────────

class ProactiveSuggestion {
  final String message;
  final String actionLabel;
  final String? actionRoute;
  final Map<String, String>? routeArgs;
  final IconData icon;

  const ProactiveSuggestion({
    required this.message,
    required this.actionLabel,
    this.actionRoute,
    this.routeArgs,
    required this.icon,
  });
}

// Rule-based proactive suggestion generator (uses app state — no API call needed)
class ProactiveAdvisor {
  static ProactiveSuggestion generateSuggestion({
    required String userName,
    required bool kycComplete,
    required bool upiEnabled,
    required int goalCount,
    required double balance,
    required int healthScore,
    required List<Map<String, dynamic>> recentTransactions,
  }) {
    // Priority 1: KYC urgent
    if (!kycComplete) {
      return const ProactiveSuggestion(
        message: '⚠️ Hi! Your Video KYC is still pending. Complete it now to unlock high-value transfers and full account access.',
        actionLabel: 'Complete KYC →',
        actionRoute: '/onboarding/kyc',
        icon: Icons.verified_user_outlined,
      );
    }

    // Priority 2: UPI not set up
    if (!upiEnabled) {
      return const ProactiveSuggestion(
        message: '💡 Good morning! Enable UPI in 30 seconds to start paying anyone instantly with just their phone number.',
        actionLabel: 'Enable UPI →',
        actionRoute: '/onboarding/upi',
        icon: Icons.payment_outlined,
      );
    }

    // Priority 3: No savings goal
    if (goalCount == 0) {
      return const ProactiveSuggestion(
        message: '🎯 You have no savings goals yet! Users with goals save 3× faster. Set one up — it takes under a minute.',
        actionLabel: 'Create Goal →',
        actionRoute: '/goals/create',
        icon: Icons.flag_outlined,
      );
    }

    // Priority 4: High balance — suggest FD
    if (balance > 50000) {
      return ProactiveSuggestion(
        message: '📈 You have ₹${balance.toStringAsFixed(0)} sitting idle. Open a Fixed Deposit now and earn up to 7.2% interest annually.',
        actionLabel: 'Open FD →',
        actionRoute: '/services',
        icon: Icons.account_balance_outlined,
      );
    }

    // Priority 5: Low health score
    if (healthScore < 70) {
      return ProactiveSuggestion(
        message: '📊 Your Financial Health Score is $healthScore/100. Let\'s get it above 80 — tap to see your next best actions.',
        actionLabel: 'Improve Score →',
        actionRoute: '/coach',
        icon: Icons.insights_outlined,
      );
    }

    // Default: Send money nudge
    return ProactiveSuggestion(
      message: '👋 Welcome back, $userName! Your balance is ₹${balance.toStringAsFixed(2)}. Want to send money or check investments?',
      actionLabel: 'Send Money →',
      actionRoute: '/send-money',
      routeArgs: {},
      icon: Icons.send_rounded,
    );
  }
}
