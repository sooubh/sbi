import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../data/repositories/state_providers.dart';
import '../engine/ai_engine.dart';

class CoachMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? engineSource;

  CoachMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.engineSource,
  });
}

class FinancialCoachScreen extends ConsumerStatefulWidget {
  const FinancialCoachScreen({super.key});

  @override
  ConsumerState<FinancialCoachScreen> createState() => _FinancialCoachScreenState();
}

class _FinancialCoachScreenState extends ConsumerState<FinancialCoachScreen> {
  final List<CoachMessage> _messages = [];
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  String _aiSummary = 'Analyzing your transactions...';
  String? _summaryEngineSource;
  bool _isLoadingSummary = true;

  final List<String> _suggestedPrompts = [
    'Where did my money go this month?',
    'Suggest a monthly savings plan',
    'Analyze my spending leaks',
    'Help me create a savings target',
  ];

  @override
  void initState() {
    super.initState();
    _messages.add(
      CoachMessage(
        text: 'Hello! I am your AI Financial Coach. I have analyzed your recent transactions. You can ask me custom questions or use one of the quick analysis templates below.',
        isUser: false,
        timestamp: DateTime.now(),
        engineSource: 'Rule-Based Engine',
      ),
    );
    // Fetch summary on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialSummary();
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _loadInitialSummary() async {
    final apiKey = ref.read(geminiApiKeyProvider);
    final user = ref.read(userProfileProvider);
    final transactions = ref.read(transactionsProvider);
    final goals = ref.read(goalsProvider);
    final recommendations = ref.read(recommendationsProvider);
    final services = ref.read(servicesProvider);
    final models = ref.read(localAiProvider);
    final activeModel = models.firstWhere((m) => m.isActive, orElse: () => models.first);

    try {
      final result = await AIEngineCoordinator.processQuery(
        prompt: 'Give a 2-sentence summary of my current financial health status and recent category spendings based on my profile data. Keep it highly action-focused.',
        apiKey: apiKey,
        userProfile: user,
        transactions: transactions,
        goals: goals,
        recommendations: recommendations,
        services: services,
        activeModel: activeModel,
      );
      if (mounted) {
        setState(() {
          _aiSummary = result.text;
          _summaryEngineSource = result.engineSource;
          _isLoadingSummary = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _aiSummary = 'Welcome ${user.name}! Your health score is ${user.financialHealthScore}/100. Consider completing pending setups to boost savings.';
          _summaryEngineSource = 'Rule-Based Engine';
          _isLoadingSummary = false;
        });
      }
    }
  }

  void _handleSend(String text) async {
    if (text.trim().isEmpty) return;

    _chatController.clear();
    setState(() {
      _messages.add(
        CoachMessage(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });
    _scrollToBottom();

    ref.read(engagementProvider.notifier).trackEvent(
      'Consulted Coach',
      coins: 10,
      details: 'Asked Coach: "$text"',
    );

    final apiKey = ref.read(geminiApiKeyProvider);
    final userProfile = ref.read(userProfileProvider);
    final transactions = ref.read(transactionsProvider);
    final goals = ref.read(goalsProvider);
    final recommendations = ref.read(recommendationsProvider);
    final services = ref.read(servicesProvider);
    final models = ref.read(localAiProvider);
    final activeModel = models.firstWhere((m) => m.isActive, orElse: () => models.first);

    final result = await AIEngineCoordinator.processQuery(
      prompt: text,
      apiKey: apiKey,
      userProfile: userProfile,
      transactions: transactions,
      goals: goals,
      recommendations: recommendations,
      services: services,
      activeModel: activeModel,
    );

    if (!mounted) return;
    setState(() {
      _isTyping = false;
      _messages.add(
        CoachMessage(
          text: result.text,
          isUser: false,
          timestamp: DateTime.now(),
          engineSource: result.engineSource,
        ),
      );
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactions = ref.watch(transactionsProvider);
    
    // Calculate category spending totals for fl_chart
    final Map<String, double> categorySums = {};
    double totalDebit = 0.0;
    
    for (final tx in transactions) {
      if (tx.amount < 0) {
        final amt = tx.amount.abs();
        categorySums[tx.category] = (categorySums[tx.category] ?? 0.0) + amt;
        totalDebit += amt;
      }
    }

    return GradientScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Icon(Icons.insights_rounded, color: AppTheme.aiTeal, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'AI Financial Coach',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Dashboard Content
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  // Summary Insight Card (Gemini generated)
                  SooubhCard(
                    hasAiBorder: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.face_retouching_natural_rounded, color: AppTheme.aiTeal, size: 22),
                                const SizedBox(width: 8),
                                Text(
                                  'Coach Summary',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: AppTheme.aiTeal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (_summaryEngineSource != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: AppTheme.aiTeal.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: AppTheme.aiTeal.withValues(alpha: 0.2)),
                                ),
                                child: Text(
                                  _summaryEngineSource!,
                                  style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: AppTheme.aiTeal),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (_isLoadingSummary)
                          const LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.aiTeal))
                        else
                          Text(
                            _aiSummary,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textPrimary,
                              height: 1.45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Spend breakdown fl_chart
                  SooubhCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Debits Category Breakdown',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.textPrimary),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 130,
                          child: categorySums.isEmpty
                              ? const Center(child: Text('No spending records found.'))
                              : PieChart(
                                  PieChartData(
                                    sectionsSpace: 3,
                                    centerSpaceRadius: 35,
                                    sections: _buildPieChartSections(categorySums, totalDebit),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 12),
                        // Legend
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          alignment: WrapAlignment.center,
                          children: categorySums.keys.map((cat) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(cat),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  cat,
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Chat Dialogue box section
                  const Text(
                    'Ask Coach Anything',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.sbiBlue),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppTheme.softShadow,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(12),
                            itemCount: _messages.length,
                            itemBuilder: (context, idx) {
                              final msg = _messages[idx];
                              return _buildMessageBubble(msg);
                            },
                          ),
                        ),
                        if (_isTyping)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppTheme.aiTeal)),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Coach is typing...',
                                  style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Quick prompt templates
                  SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _suggestedPrompts.length,
                      itemBuilder: (context, idx) {
                        final prompt = _suggestedPrompts[idx];
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: ActionChip(
                            label: Text(prompt, style: const TextStyle(fontSize: 11, color: AppTheme.aiTeal, fontWeight: FontWeight.bold)),
                            backgroundColor: AppTheme.cardBg,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            side: BorderSide(color: AppTheme.aiTeal.withValues(alpha: 0.15)),
                            onPressed: () => _handleSend(prompt),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Text Box Entry Row
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: AppTheme.softShadow,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _chatController,
                            onSubmitted: _handleSend,
                            decoration: const InputDecoration(
                              hintText: 'Ask financial coach...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send_rounded, color: AppTheme.aiTeal),
                          onPressed: () => _handleSend(_chatController.text),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(CoachMessage message) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isUser ? AppTheme.sbiBlue : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(isUser ? 12 : 3),
                bottomRight: Radius.circular(isUser ? 3 : 12),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isUser ? Colors.white : AppTheme.textPrimary,
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ),
          if (!isUser && message.engineSource != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                decoration: BoxDecoration(
                  color: AppTheme.aiTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppTheme.aiTeal.withValues(alpha: 0.15)),
                ),
                child: Text(
                  message.engineSource!,
                  style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: AppTheme.aiTeal),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(Map<String, double> categorySums, double totalDebit) {
    if (totalDebit == 0) return [];
    return categorySums.entries.map((entry) {
      final percentage = (entry.value / totalDebit) * 100;
      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 18,
        titleStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return const Color(0xFF5E35B1);
      case 'Bills':
        return AppTheme.error;
      case 'Travel':
        return AppTheme.warning;
      case 'Savings':
        return AppTheme.aiTeal;
      default:
        return AppTheme.sbiBlue;
    }
  }
}
