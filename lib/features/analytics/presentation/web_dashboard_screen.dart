import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../data/repositories/state_providers.dart';
import '../../../data/models/engagement_model.dart';
import 'package:intl/intl.dart';

class WebDashboardScreen extends ConsumerWidget {
  const WebDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bool isLargeScreen = size.width > 900;
    final engagement = ref.watch(engagementProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Row(
        children: [
          // 1. Left Sidebar Navigation
          if (isLargeScreen) _buildSidebar(context),

          // 2. Right Main Content Area
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Title Bar
                  _buildHeader(context),
                  const SizedBox(height: 24),

                  // KPIs Cards Row
                  _buildKpiGrid(context, isLargeScreen),
                  const SizedBox(height: 24),

                  // Chart Row (Funnel & Line Chart)
                  if (isLargeScreen)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _buildEngagementTrend(context)),
                        const SizedBox(width: 24),
                        Expanded(flex: 2, child: _buildAdoptionFunnel(context)),
                      ],
                    )
                  else ...[
                    _buildEngagementTrend(context),
                    const SizedBox(height: 24),
                    _buildAdoptionFunnel(context),
                  ],
                  const SizedBox(height: 24),

                  // Bottom Grid (Feature Discovery & Recommendation Stats)
                  if (isLargeScreen)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _buildFeatureDiscovery(context)),
                        const SizedBox(width: 24),
                        Expanded(flex: 2, child: _buildAiRecommendationsStats(context)),
                      ],
                    )
                  else ...[
                    _buildFeatureDiscovery(context),
                    const SizedBox(height: 24),
                    _buildAiRecommendationsStats(context),
                  ],
                  const SizedBox(height: 24),

                  // Live User Activity Logs Tracking (Hackathon Feature Live Stream)
                  _buildLiveActivityLogs(context, engagement.trackedEvents),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 260,
      color: AppTheme.sbiBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppTheme.aiTeal,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Sooubh AI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildSidebarItem(context, Icons.dashboard_outlined, 'Overview', isActive: true),
          _buildSidebarItem(context, Icons.filter_alt_outlined, 'Adoption Funnels'),
          _buildSidebarItem(context, Icons.analytics_outlined, 'Engagement'),
          _buildSidebarItem(context, Icons.recommend_outlined, 'Recommendations'),
          _buildSidebarItem(context, Icons.settings_input_component_outlined, 'AI Settings'),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Bank Management Console\nv1.0 (SBI Hackathon)',
              style: TextStyle(color: Colors.white54, fontSize: 10, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(BuildContext context, IconData icon, String label, {bool isActive = false}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
          border: isActive 
              ? const Border(left: BorderSide(color: AppTheme.aiTeal, width: 4))
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.white70, size: 20),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white70,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enterprise Admin Dashboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'SBI Digital Adoption & Recommendation Performance Analytics',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.softShadow,
              ),
              child: const Row(
                children: [
                  Icon(Icons.calendar_today_rounded, color: AppTheme.sbiBlue, size: 14),
                  SizedBox(width: 8),
                  Text(
                    'Last 30 Days',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKpiGrid(BuildContext context, bool isLargeScreen) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isLargeScreen ? 4 : 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: isLargeScreen ? 1.6 : 1.3,
      children: [
        _buildKpiCard(context, 'Total Active Users', '142.8k', '+12.4%', Icons.people_outline_rounded, Colors.blue),
        _buildKpiCard(context, 'Adoption Completion', '78.2%', '+8.3%', Icons.assignment_turned_in_outlined, Colors.purple),
        _buildKpiCard(context, 'Recommendation CTR', '46.1%', '+18.5%', Icons.ads_click_rounded, AppTheme.aiTeal),
        _buildKpiCard(context, 'Avg Wellness Score', '82.4', '+4.1 pts', Icons.favorite_border_rounded, const Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildKpiCard(BuildContext context, String label, String value, String change, IconData icon, Color accentColor) {
    return SooubhCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    change,
                    style: const TextStyle(
                      color: AppTheme.success,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'vs last month',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementTrend(BuildContext context) {
    return SooubhCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Active Engagement',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}k',
                          style: const TextStyle(color: Colors.grey, fontSize: 10),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 1: return const Text('Jun 01', style: TextStyle(color: Colors.grey, fontSize: 10));
                          case 4: return const Text('Jun 05', style: TextStyle(color: Colors.grey, fontSize: 10));
                          case 8: return const Text('Jun 10', style: TextStyle(color: Colors.grey, fontSize: 10));
                          case 12: return const Text('Jun 15', style: TextStyle(color: Colors.grey, fontSize: 10));
                          default: return const Text('');
                        }
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(1, 92),
                      FlSpot(3, 98),
                      FlSpot(5, 115),
                      FlSpot(7, 108),
                      FlSpot(9, 128),
                      FlSpot(11, 142),
                      FlSpot(13, 140),
                    ],
                    isCurved: true,
                    color: AppTheme.sbiBlue,
                    barWidth: 4,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppTheme.sbiBlue.withValues(alpha: 0.1),
                    ),
                  ),
                  LineChartBarData(
                    spots: const [
                      FlSpot(1, 40),
                      FlSpot(3, 48),
                      FlSpot(5, 52),
                      FlSpot(7, 68),
                      FlSpot(9, 84),
                      FlSpot(11, 118),
                      FlSpot(13, 124),
                    ],
                    isCurved: true,
                    color: AppTheme.aiTeal,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppTheme.aiTeal.withValues(alpha: 0.05),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdoptionFunnel(BuildContext context) {
    return SooubhCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Adoption Funnel',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          _buildFunnelRow(context, 'Registered Users', '142.8k', 1.0),
          _buildFunnelRow(context, 'Onboarded Complete', '111.4k', 0.78),
          _buildFunnelRow(context, 'UPI Channels Active', '92.3k', 0.64),
          _buildFunnelRow(context, 'Savings Goal Created', '68.0k', 0.47),
          _buildFunnelRow(context, 'First SIP Started', '32.1k', 0.22),
        ],
      ),
    );
  }

  Widget _buildFunnelRow(BuildContext context, String label, String value, double ratio) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              backgroundColor: AppTheme.background,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.lerp(AppTheme.aiTeal, AppTheme.sbiBlue, ratio) ?? AppTheme.aiTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureDiscovery(BuildContext context) {
    return SooubhCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Discovery Index',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            children: [
              const TableRow(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Service', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Clicks', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
                ],
              ),
              _buildTableRow('Fixed Deposit (FD)', '18,432', 'High discovery', AppTheme.success),
              _buildTableRow('SIP Setup', '14,210', 'High discovery', AppTheme.success),
              _buildTableRow('Health Insurance', '8,924', 'Moderate', AppTheme.warning),
              _buildTableRow('NPS Pension', '2,142', 'Low discovery', AppTheme.error),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String service, String clicks, String status, Color statusColor) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(service, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(clicks, style: const TextStyle(fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildAiRecommendationsStats(BuildContext context) {
    return SooubhCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Action Outcomes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOutcomeMetric(context, 'Nudges Shown', '1.2M', Colors.grey),
              _buildOutcomeMetric(context, 'Accepted CTAs', '553.2k', AppTheme.aiTeal),
              _buildOutcomeMetric(context, 'Goal conversions', '142.1k', AppTheme.sbiBlue),
            ],
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Overall Conversion rate: 46.1%',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.aiTeal, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutcomeMetric(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 22,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildLiveActivityLogs(BuildContext context, List<EngagementEvent> events) {
    final timeFormat = DateFormat('HH:mm:ss');
    return SooubhCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Live User Activity Log (Engagement Telemetry)',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.aiTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.circle, color: AppTheme.aiTeal, size: 8),
                    const SizedBox(width: 6),
                    Text(
                      'Live Feed',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.aiTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (events.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Center(
                child: Text(
                  'No live events tracked yet.\nTry checking balance, viewing story, or configuring auto-save to stream logs here.',
                  style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length > 5 ? 5 : events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppTheme.background, width: 0.8)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppTheme.sbiBlue.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.radio_button_checked_rounded, color: AppTheme.sbiBlue, size: 14),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.actionName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              event.details,
                              style: const TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '+${event.coinsEarned} Coins',
                            style: const TextStyle(color: AppTheme.success, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            timeFormat.format(event.timestamp),
                            style: const TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
