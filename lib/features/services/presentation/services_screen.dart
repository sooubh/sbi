import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/models/service_model.dart';
import '../../../data/repositories/state_providers.dart';
import '../widgets/ai_chat_modal.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showActivationSheet(ServiceModel service) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.sbiBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      service.category,
                      style: const TextStyle(
                        color: AppTheme.sbiBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                service.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _getServiceDescription(service.id),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: service.isActivated ? 'Open Service Dashboard' : 'Activate & Try It Now',
                      isAiAction: service.isNew,
                      useGradient: service.isNew,
                      onPressed: () {
                        Navigator.of(context).pop(); // Close sheet
                        _activateService(service);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _activateService(ServiceModel service) {
    if (service.isActivated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Opening "${service.name}" interface...'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Show setup spinner
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          ),
          title: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.aiTeal),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Activating...',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          content: Text(
            'Sooubh AI is enabling services for "${service.name}". Please wait.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      Navigator.of(context).pop(); // Close dialog

      // Activate service
      ref.read(servicesProvider.notifier).activateService(service.id);

      // Check if this connects to Next Best Action setup
      if (service.id == 'acc_fd') {
        ref.read(userProfileProvider.notifier).incrementGoals(); // Simulates goal progress
        ref.read(recommendationsProvider.notifier).completeRecommendation('r_fd');
      } else if (service.id == 'pay_upi') {
        ref.read(userProfileProvider.notifier).enableUpi();
        ref.read(recommendationsProvider.notifier).completeRecommendation('r_upi');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
              const SizedBox(width: 8),
              Text('"${service.name}" is now fully activated!'),
            ],
          ),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicesProvider);
    
    // Group categories
    final categories = ['Payments', 'Accounts', 'Investments', 'Loans', 'Insurance'];

    return GradientScaffold(
      body: Column(
        children: [
          // Sticky search and assistant triggers
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              boxShadow: AppTheme.softShadow,
            ),
            child: Column(
              children: [
                // Header Capsule Search bar
                TextField(
                  controller: _searchController,
                  style: Theme.of(context).textTheme.bodyLarge,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search services, loans, FD...',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.textSecondary),
                    filled: true,
                    fillColor: AppTheme.background,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Sooubh Chat Button
                SooubhCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  hasAiBorder: true,
                  onTap: () => AiChatModal.show(context),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppTheme.aiTeal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Talk to Sooubh AI Assistant',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 14,
                            color: AppTheme.aiTeal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.aiTeal, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Categories list view
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, catIndex) {
                final category = categories[catIndex];
                
                // Filter elements in category based on search input
                final catServices = services.where((svc) {
                  final matchesCat = svc.category == category;
                  final matchesSearch = svc.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                      svc.category.toLowerCase().contains(_searchQuery.toLowerCase());
                  return matchesCat && matchesSearch;
                }).toList();

                if (catServices.isEmpty) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.sbiBlue,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.95,
                      ),
                      itemCount: catServices.length,
                      itemBuilder: (context, index) {
                        final service = catServices[index];
                        return _buildServiceGridTile(service);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGridTile(ServiceModel service) {
    final theme = Theme.of(context);
    final isNew = service.isNew;
    
    return Stack(
      children: [
        SooubhCard(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          margin: EdgeInsets.zero,
          hasAiBorder: isNew && !service.isActivated,
          onTap: () => _showActivationSheet(service),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: service.isActivated 
                      ? AppTheme.sbiBlue.withValues(alpha: 0.08)
                      : Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getServiceIcon(service.id),
                  color: service.isActivated ? AppTheme.sbiBlue : Colors.grey[600],
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                service.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
        
        // Custom Badge
        if (service.badge != null && !service.isActivated)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isNew ? AppTheme.aiTeal : AppTheme.sbiBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                service.badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  IconData _getServiceIcon(String id) {
    switch (id) {
      case 'pay_upi':
        return Icons.qr_code_rounded;
      case 'pay_bills':
        return Icons.receipt_long_rounded;
      case 'pay_recharge':
        return Icons.phone_android_rounded;
      case 'acc_fd':
        return Icons.account_balance_rounded;
      case 'acc_rd':
        return Icons.savings_rounded;
      case 'acc_ppf':
        return Icons.pie_chart_rounded;
      case 'inv_sip':
        return Icons.trending_up_rounded;
      case 'inv_mf':
        return Icons.analytics_rounded;
      case 'inv_nps':
        return Icons.security_rounded;
      case 'loan_home':
        return Icons.home_rounded;
      case 'loan_personal':
        return Icons.person_rounded;
      case 'loan_car':
        return Icons.directions_car_rounded;
      case 'ins_life':
        return Icons.accessibility_new_rounded;
      case 'ins_health':
        return Icons.medical_services_rounded;
      case 'ins_motor':
        return Icons.minor_crash_rounded;
      default:
        return Icons.widgets_rounded;
    }
  }

  String _getServiceDescription(String id) {
    switch (id) {
      case 'acc_fd':
        return 'Fixed Deposit accounts let you earn higher interest (up to 7.2% annually) by locking in your funds for a chosen duration. Safely grow your idle cash with guaranteed returns.';
      case 'inv_sip':
        return 'Setup a Systematic Investment Plan (SIP) to invest a fixed amount in mutual funds every month. Build wealth over time using rupee cost averaging and power of compounding.';
      case 'pay_upi':
        return 'Unified Payments Interface (UPI) lets you transfer funds instantly using virtual payment addresses (VPA) or mobile numbers. Seamless, fast, and completely free.';
      case 'ins_health':
        return 'Safeguard your family against sudden medical expenses. Health insurance policies cover hospitalization, critical illness treatments, and day-care procedures.';
      default:
        return 'Discover and activate this feature to expand your banking capability. Setup is fast, paperless, and fully configured in seconds by Sooubh AI.';
    }
  }
}
