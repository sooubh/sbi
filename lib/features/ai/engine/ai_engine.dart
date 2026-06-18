import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/recommendation.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/models/financial_goal.dart';
import '../../../data/models/service_model.dart';

// Local Model state model
class LocalModel {
  final String id;
  final String name;
  final String size;
  final bool isDownloaded;
  final bool isActive;

  const LocalModel({
    required this.id,
    required this.name,
    required this.size,
    this.isDownloaded = false,
    this.isActive = false,
  });

  LocalModel copyWith({
    String? id,
    String? name,
    String? size,
    bool? isDownloaded,
    bool? isActive,
  }) {
    return LocalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      size: size ?? this.size,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Local AI state provider
class LocalAiNotifier extends StateNotifier<List<LocalModel>> {
  LocalAiNotifier() : super([
    const LocalModel(id: 'tiny_llama', name: 'TinyLlama 1.1B GGUF', size: '640 MB', isDownloaded: true, isActive: true),
    const LocalModel(id: 'gemma_2b', name: 'Gemma 2B Chat GGUF', size: '1.4 GB'),
    const LocalModel(id: 'phi_3', name: 'Phi-3 Mini GGUF', size: '2.2 GB'),
    const LocalModel(id: 'qwen_1_5b', name: 'Qwen 1.5B Instruct GGUF', size: '920 MB'),
  ]);

  void downloadModel(String id) {
    state = [
      for (final model in state)
        if (model.id == id)
          model.copyWith(isDownloaded: true)
        else
          model
    ];
  }

  void activateModel(String id) {
    state = [
      for (final model in state)
        model.copyWith(isActive: model.id == id)
    ];
  }

  void importCustomModel(String name, String size) {
    final custom = LocalModel(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      size: size,
      isDownloaded: true,
      isActive: true,
    );
    // Deactivate others
    state = [
      for (final model in state)
        model.copyWith(isActive: false),
      custom
    ];
  }
}

final localAiProvider = StateNotifierProvider<LocalAiNotifier, List<LocalModel>>((ref) {
  return LocalAiNotifier();
});

// Coordinator Result structure
class CoordinatorResult {
  final String text;
  final String engineSource; // "Rule-Based Router", "Llama.cpp (Offline 1.1B)", "Gemini 2.5 Flash"
  final String? actionRoute;
  final Widget? actionWidget;

  const CoordinatorResult({
    required this.text,
    required this.engineSource,
    this.actionRoute,
    this.actionWidget,
  });
}

// Layer 1 — Rule Engine Logic helper & Offline Router
class RuleEngine {
  static List<Recommendation> evaluateRules(UserProfile user) {
    final List<Recommendation> recs = [];
    
    if (!user.kycComplete) {
      recs.add(const Recommendation(
        id: 'r_kyc',
        type: 'next_best_action',
        title: 'Complete KYC',
        subtitle: 'Complete video KYC to unlock high transfer limits.',
        actionLabel: 'Verify Now',
        priority: 1,
        completed: false,
        actionRoute: '/onboarding/kyc',
      ));
    }
    
    if (!user.upiEnabled) {
      recs.add(const Recommendation(
        id: 'r_upi',
        type: 'next_best_action',
        title: 'Enable UPI',
        subtitle: 'Activate UPI to send payments directly to phone numbers.',
        actionLabel: 'Set Up UPI',
        priority: 2,
        completed: false,
        actionRoute: '/onboarding/upi',
      ));
    }
    
    if (!user.hasGoal) {
      recs.add(const Recommendation(
        id: 'r_goal',
        type: 'next_best_action',
        title: 'Create Savings Goal',
        subtitle: 'Users with visual goals save 3x faster. Set one up.',
        actionLabel: 'Create Goal',
        priority: 3,
        completed: false,
        actionRoute: '/goals/create',
      ));
    }
    
    recs.add(const Recommendation(
      id: 'r_fd',
      type: 'next_best_action',
      title: 'Start Fixed Deposit',
      subtitle: 'Earn up to 7.2% interest on your idle savings.',
      actionLabel: 'Open FD',
      priority: 4,
      completed: false,
      actionRoute: '/services/fd',
    ));

    return recs;
  }

  static CoordinatorResult? matchRule(
    String query,
    UserProfile user,
    List<FinancialGoal> goals,
    List<TransactionModel> transactions,
    List<ServiceModel> services,
  ) {
    final lower = query.toLowerCase().trim();
    
    // 1. Pay/Send money intents (regex matching amount and recipient)
    if (lower.startsWith('send') || lower.startsWith('pay') || lower.contains('transfer') || lower.contains('send money')) {
      // Find amount if present, default to 500
      final RegExp amountRegExp = RegExp(r'\b\d+\b');
      final amountMatch = amountRegExp.firstMatch(lower);
      final amount = amountMatch != null ? amountMatch.group(0) : '500';

      // Find recipient nickname
      String recipient = 'Priya';
      if (lower.contains('aisha')) {
        recipient = 'Aisha';
      } else if (lower.contains('rahul')) {
        recipient = 'Rahul';
      } else if (lower.contains('amit')) {
        recipient = 'Amit';
      } else if (lower.contains('sourabh')) {
        recipient = 'Sourabh';
      } else if (lower.contains('vikram')) {
        recipient = 'Vikram';
      }

      final vpa = '${recipient.toLowerCase()}@sbi';
      return CoordinatorResult(
        text: 'Okay, I\'ve configured a secure UPI transfer of ₹$amount to $recipient ($vpa). Tap the action button below to execute the payment.',
        engineSource: 'Rule-Based Engine',
        actionRoute: '/send-money?recipient=$vpa&amount=$amount',
      );
    }

    // 2. Card block/freeze commands
    if (lower.contains('block card') || lower.contains('lock card') || lower.contains('freeze card') || lower.contains('card control') || lower.contains('deactivate card')) {
      return const CoordinatorResult(
        text: 'For security, you can lock/freeze your primary debit card instantly. Use the control panel toggle below to freeze your card.',
        engineSource: 'Rule-Based Engine',
        actionRoute: '/card-control',
      );
    }

    // 3. Quick budget audit summary
    if (lower.contains('audit') || lower.contains('budget') || lower.contains('spend summary') || lower.contains('spending audit')) {
      double totalDebit = 0.0;
      double totalCredit = 0.0;
      for (final tx in transactions) {
        if (tx.amount < 0) {
          totalDebit += tx.amount.abs();
        } else {
          totalCredit += tx.amount;
        }
      }
      
      final activeGoalsStr = goals.isEmpty 
          ? 'No active goals' 
          : goals.map((g) => '${g.name} (${g.progressPercent}% saved)').join(', ');
          
      return CoordinatorResult(
        text: '📊 Quick Budget Audit for ${user.name}:\n'
            '• Current Balance: ₹${user.balance.toStringAsFixed(2)}\n'
            '• Active Savings Targets: $activeGoalsStr\n'
            '• Spent in Demo Period: ₹${totalDebit.toStringAsFixed(2)}\n'
            '• Inflow in Demo Period: ₹${totalCredit.toStringAsFixed(2)}\n'
            'Your current Financial Score is ${user.financialHealthScore}/100. I suggest setting up a savings target to reduce spend leaks.',
        engineSource: 'Rule-Based Engine',
        actionRoute: goals.isEmpty ? '/goals/create' : null,
      );
    }

    if (lower.contains('balance') || lower.contains('how much money') || lower.contains('account details')) {
      return CoordinatorResult(
        text: 'Your current account balance for account ${user.maskedAccount} is ₹${user.balance.toStringAsFixed(2)}.',
        engineSource: 'Rule-Based Engine',
      );
    }
    
    if (lower.contains('kyc') || lower.contains('video kyc') || lower.contains('verification')) {
      return CoordinatorResult(
        text: 'Your Video KYC status is currently ${user.kycComplete ? 'COMPLETE' : 'PENDING'}. ${user.kycComplete ? 'You have full access to all high-value transactions.' : 'Please complete your video KYC to raise limits and secure your account.'}',
        engineSource: 'Rule-Based Engine',
        actionRoute: user.kycComplete ? null : '/onboarding/kyc',
      );
    }

    if (lower.contains('upi') || lower.contains('enable upi') || lower.contains('pay contact')) {
      return CoordinatorResult(
        text: 'UPI payments are currently ${user.upiEnabled ? 'ENABLED' : 'INACTIVE'}. ${user.upiEnabled ? 'You can instantly transfer funds using mobile numbers or UPI IDs.' : 'Activate your UPI account to configure seamless phone transfers.'}',
        engineSource: 'Rule-Based Engine',
        actionRoute: user.upiEnabled ? null : '/onboarding/upi',
      );
    }

    if (lower.contains('goals') || lower.contains('savings goal') || lower.contains('my goal')) {
      if (goals.isEmpty) {
        return const CoordinatorResult(
          text: 'You do not have any active savings goals. Visualizing your targets can help you save up to 3x faster! Would you like to create one now?',
          engineSource: 'Rule-Based Engine',
          actionRoute: '/goals/create',
        );
      } else {
        final goalList = goals.map((g) => '- ${g.name}: saved ₹${g.savedAmount} of ₹${g.targetAmount} (${g.progressPercent}% progress)').join('\n');
        return CoordinatorResult(
          text: 'You have ${goals.length} active savings goals:\n$goalList',
          engineSource: 'Rule-Based Engine',
        );
      }
    }

    if (lower.contains('services') || lower.contains('features list') || lower.contains('what can i do')) {
      final active = services.where((s) => s.isActivated).map((s) => s.name).join(', ');
      final inactive = services.where((s) => !s.isActivated).map((s) => s.name).join(', ');
      return CoordinatorResult(
        text: 'YONO SBI services status:\n• Active: $active\n• Available: $inactive',
        engineSource: 'Rule-Based Engine',
      );
    }
    
    return null;
  }

  static bool isSmallTask(String query) {
    final lower = query.toLowerCase();
    
    // Static definitions or quick lookups
    if (lower.contains('what is a fixed deposit') || lower.contains('what is fd') || lower.contains('define fd')) return true;
    if (lower.contains('what is a sip') || lower.contains('what is sip') || lower.contains('define sip')) return true;
    if (lower.contains('how auto-save works') || lower.contains('what is auto-save') || lower.contains('auto-save round')) return true;
    if (lower.contains('what is mutual fund') || lower.contains('define mutual fund')) return true;
    if (lower.contains('interest rate') || lower.contains('rate of interest')) return true;
    if (lower.contains('what is ppf') || lower.contains('define ppf')) return true;
    if (lower.contains('what is nps') || lower.contains('define nps')) return true;
    
    // Very short queries
    if (query.trim().split(' ').length <= 4) return true;
    
    return false;
  }

  static String generateLlamaResponse(String query, String activeModelName) {
    final lower = query.toLowerCase();
    
    String response = '';
    if (lower.contains('fixed deposit') || lower.contains('fd')) {
      response = 'Fixed Deposits (FD) let you secure a guaranteed interest rate (up to 7.2% p.a.) on a lump sum for a chosen tenure. It is ideal for low-risk, steady growth of your savings.';
    } else if (lower.contains('sip')) {
      response = 'A Systematic Investment Plan (SIP) is a method of investing a fixed sum regularly into Mutual Funds. It instills financial discipline and benefits from rupee cost averaging.';
    } else if (lower.contains('auto-save')) {
      response = 'Auto-Save is a smart tool that rounds up your daily card transactions to the nearest ₹10/₹50 and deposits the change into your active Savings Goal automatically.';
    } else if (lower.contains('mutual fund')) {
      response = 'A Mutual Fund pools money from multiple investors to purchase a diversified portfolio of stocks, bonds, or other securities managed by professional fund managers.';
    } else if (lower.contains('interest rate')) {
      response = 'SBI offers interest rates up to 7.2% on Fixed Deposits, 2.70% on Savings Accounts, and competitive market rates for SIPs/Mutual Funds.';
    } else if (lower.contains('ppf')) {
      response = 'Public Provident Fund (PPF) is a tax-free savings avenue backed by the government of India. It offers competitive interest rates with a 15-year lock-in period.';
    } else if (lower.contains('nps')) {
      response = 'National Pension System (NPS) is a voluntary long-term retirement savings scheme designed to provide systematic savings with tax benefits under Section 80CCD.';
    } else {
      response = 'Offline query processed successfully. SBI offers a wide range of services including FDs, SIP Mutual Funds, and automated savings triggers to help grow your funds.';
    }
    
    return '[$activeModelName - On-Device GGUF Engine]:\n$response';
  }
}

// Layer 2 — Insight Engine Helper
class InsightEngine {
  static String generateInsight(UserProfile user) {
    if (user.financialHealthScore < 70) {
      return 'Action required: Complete onboarding setups to increase safety and digital health.';
    }
    if (!user.upiEnabled) {
      return 'Insight: Setting up UPI speeds up utility bill payments and peer transfers.';
    }
    if (user.goalCount == 0) {
      return 'Insight: Setting up a Goal is proven to keep your savings consistent.';
    }
    return 'You saved ₹1,200 more this week than last week. Great progress!';
  }
}

// Smart Local Advisor (for hard tasks when offline / no API key)
class SmartLocalAdvisor {
  static String generateResponse({
    required String prompt,
    required UserProfile userProfile,
    required List<TransactionModel> transactions,
    required List<FinancialGoal> goals,
    required List<Recommendation> recommendations,
    required List<ServiceModel> services,
  }) {
    final lower = prompt.toLowerCase();
    
    if (lower.contains('where') || lower.contains('spend') || lower.contains('money') || lower.contains('transaction')) {
      final highSpends = transactions.where((t) => t.amount < -1000).toList();
      String spentText = '';
      if (highSpends.isNotEmpty) {
        spentText = 'Your highest transactions are ${highSpends.map((t) => '${t.merchant} (₹${t.amount.abs()})').join(', ')}.';
      } else if (transactions.isNotEmpty) {
        spentText = 'Your recent transactions include ${transactions.take(2).map((t) => '${t.merchant} (₹${t.amount.abs()})').join(', ')}.';
      } else {
        spentText = 'You have no recent transactions recorded.';
      }
      return 'Hello ${userProfile.name}, I reviewed your spending context. $spentText Your current balance is ₹${userProfile.balance.toStringAsFixed(2)}. I recommend setting up a savings target or auto-saving change on your card recharges to manage your budget better.';
    }

    if (lower.contains('leak') || lower.contains('save') || lower.contains('budget') || lower.contains('plan')) {
      final kycText = userProfile.kycComplete ? '' : ' First, consider completing your Video KYC to raise limits.';
      final goalText = goals.isEmpty 
          ? ' Currently, you have no active goals. Creating an emergency fund goal is the easiest way to start.' 
          : ' You are currently saving for: ${goals.map((g) => g.name).join(', ')}.';
      return 'Here is your custom savings plan, ${userProfile.name}. Your Financial Health Score is ${userProfile.financialHealthScore}/100.$kycText$goalText To maximize growth, check out the Fixed Deposit (offering 7.2% interest) in the Services screen, which will increase your score by +10 points.';
    }

    if (lower.contains('loan') || lower.contains('borrow') || lower.contains('home')) {
      return 'SBI offers Home, Personal, and Car loans. Since your account balance is ₹${userProfile.balance.toStringAsFixed(2)}, you may qualify for favorable rates on pre-approved personal loans. Tap the Services panel to explore loan options.';
    }

    if (lower.contains('insurance') || lower.contains('health') || lower.contains('life')) {
      return 'Protecting your wealth is essential. SBI offers comprehensive Life and Health Insurance options. Check the Insurance section in the Services tab to configure a policy tailored to your age and background.';
    }

    return 'Hello ${userProfile.name}! As your SBI AI companion, I have full visibility of your account (Balance: ₹${userProfile.balance.toStringAsFixed(2)}). You can ask me details about your recent transactions, seek advice on savings goals, or request assistance setting up Fixed Deposits / SIP investments.';
  }
}

// Layer 3 — Gemini Engine Helper (updated with rich contextual system prompt)
class GeminiEngine {
  static Future<String> generateGeminiResponse({
    required String prompt,
    required String apiKey,
    required UserProfile userProfile,
    required List<TransactionModel> transactions,
    required List<FinancialGoal> goals,
    required List<Recommendation> recommendations,
    required List<ServiceModel> services,
  }) async {
    if (apiKey.isEmpty) {
      return 'Error: Gemini API Key is empty. Please open settings (gear icon) and add your API Key to enable Gemini 2.5 Flash.';
    }

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey',
    );

    try {
      final client = HttpClient();
      final request = await client.postUrl(url);
      request.headers.contentType = ContentType.json;

      // Rich contextual system prompt
      final systemPrompt = '''
You are Sooubh AI, the agentic financial companion built for the YONO SBI banking app.
You have access to the full application state, user preferences, active services, and screen route contexts.

App Context & Routing Tables:
- Conversational Onboarding / Video KYC Screen: /onboarding/kyc
- UPI Registration Screen: /onboarding/upi
- Savings Goal Creator Screen: /goals/create
- Services / Products Showcase: /services/fd (Fixed Deposit), /services/sip (Mutual Funds SIP), /services/insurance (Insurance policies)

Current User Profile State:
- Name: ${userProfile.name}
- Account Masked: ${userProfile.maskedAccount}
- Account Balance: ₹${userProfile.balance.toStringAsFixed(2)}
- KYC Complete: ${userProfile.kycComplete}
- UPI Enabled: ${userProfile.upiEnabled}
- Financial Health Score: ${userProfile.financialHealthScore}/100
- Active goals count: ${userProfile.goalCount}

Active Services Status:
${services.map((s) => '- ${s.name} (${s.category}): ${s.isActivated ? "Active" : "Not Activated"}${s.isNew ? " [New Product]" : ""}').join('\n')}

Pending Recommendations:
${recommendations.where((r) => !r.completed).map((r) => '- [Pending] ${r.title}: ${r.subtitle} (Route: ${r.actionRoute})').join('\n')}

Completed Recommendations:
${recommendations.where((r) => r.completed).map((r) => '- [Completed] ${r.title}').join('\n')}

Active Goals:
${goals.isEmpty ? "No active goals." : goals.map((g) => '- Goal: ${g.name}, Target: ₹${g.targetAmount}, Saved: ₹${g.savedAmount} (${g.progressPercent}% progress, Status: ${g.status})').join('\n')}

Recent Account Transactions:
${transactions.map((t) => '- ${t.date}: ${t.merchant} (Category: ${t.category}), Amount: ₹${t.amount} (${t.amount < 0 ? "Debit" : "Credit"})').join('\n')}

INSTRUCTIONS:
1. Provide highly personalized, accurate responses addressing the user's specific financial situation.
2. Coordinate with YONO SBI services! Suggest specific actions and tell the user they can navigate or check the recommendation cards on their home screen.
3. Be professional, friendly, and brief (maximum 3-4 sentences) because this response will be read on a mobile screen.
4. If the user asks how to do something (e.g. open FD, start SIP, do KYC, setup UPI), point them directly to the corresponding screen route or recommend checking their next-best-action cards.
5. If the user refers to the app context, you have full view of it. Frame your responses referencing their real data (e.g., active goals like Holiday Fund, specific transactions, or health score).

User Query: "$prompt"
''';

      final body = jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': systemPrompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.3,
          'maxOutputTokens': 800,
        }
      });

      request.write(body);
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody);
        try {
          final text = data['candidates'][0]['content']['parts'][0]['text'] as String;
          return text.trim();
        } catch (e) {
          return 'Error parsing Gemini response. Please check your API key / parameters.';
        }
      } else {
        final responseBody = await response.transform(utf8.decoder).join();
        return 'API Error (${response.statusCode}): $responseBody';
      }
    } catch (e) {
      return 'Connection Error: $e. Please verify your internet connection.';
    }
  }
}

// Unified Orchestrator and Router
class AIEngineCoordinator {
  static Future<CoordinatorResult> processQuery({
    required String prompt,
    required String apiKey,
    required UserProfile userProfile,
    required List<TransactionModel> transactions,
    required List<FinancialGoal> goals,
    required List<Recommendation> recommendations,
    required List<ServiceModel> services,
    required String activeModelName,
  }) async {
    // 1. Rule-Based Interceptor (Deterministic Checks)
    final ruleResult = RuleEngine.matchRule(
      prompt,
      userProfile,
      goals,
      transactions,
      services,
    );
    if (ruleResult != null) {
      return ruleResult;
    }

    // 2. Task Complexity Routing
    if (RuleEngine.isSmallTask(prompt)) {
      // Route to llama.cpp Engine (offline simulated model)
      final text = RuleEngine.generateLlamaResponse(prompt, activeModelName);
      
      String? actionRoute;
      final lower = prompt.toLowerCase();
      if (lower.contains('fd') || lower.contains('deposit')) {
        actionRoute = '/services/fd';
      } else if (lower.contains('sip') || lower.contains('mutual')) {
        actionRoute = '/services/sip';
      } else if (lower.contains('kyc')) {
        actionRoute = userProfile.kycComplete ? null : '/onboarding/kyc';
      } else if (lower.contains('upi')) {
        actionRoute = userProfile.upiEnabled ? null : '/onboarding/upi';
      }

      return CoordinatorResult(
        text: text,
        engineSource: 'Llama.cpp (Offline)',
        actionRoute: actionRoute,
      );
    }

    // 3. Major/Hard Task - Route to Gemini or Smart Local Advisory fallback
    if (apiKey.isNotEmpty) {
      try {
        final text = await GeminiEngine.generateGeminiResponse(
          prompt: prompt,
          apiKey: apiKey,
          userProfile: userProfile,
          transactions: transactions,
          goals: goals,
          recommendations: recommendations,
          services: services,
        );
        return CoordinatorResult(
          text: text,
          engineSource: 'Gemini 2.5 Flash',
        );
      } catch (_) {
        // Fall through to fallback if network error
      }
    }

    // Fallback to Smart Local Advisor
    final fallbackText = SmartLocalAdvisor.generateResponse(
      prompt: prompt,
      userProfile: userProfile,
      transactions: transactions,
      goals: goals,
      recommendations: recommendations,
      services: services,
    );

    return CoordinatorResult(
      text: fallbackText,
      engineSource: 'Smart Local Advisory (Fallback)',
    );
  }
}
