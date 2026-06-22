import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repositories/state_providers.dart';
import '../../ai/presentation/ai_dev_config_modal.dart';
import '../../ai/presentation/proactive_ai_widget.dart';
import '../../navigation/state/bottom_nav_state.dart';

enum OnboardingStep {
  intentSelection,
  panAadhaarScan,
  videoKyc,
  upiSetup,
  success,
}

class OnboardingScreen extends ConsumerStatefulWidget {
  final OnboardingStep initialStep;

  const OnboardingScreen({
    super.key,
    this.initialStep = OnboardingStep.intentSelection,
  });

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> with TickerProviderStateMixin {
  late OnboardingStep _currentStep;
  late AnimationController _scannerController;
  
  // Forms & OCR State
  bool _isScanning = false;
  String _scanCardType = ''; // 'PAN' or 'Aadhaar'
  bool _panScanned = false;
  bool _aadhaarScanned = false;
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  
  // Video KYC State
  bool _kycVerified = false;
  bool _isKycCalling = false;
  
  // UPI State
  bool _isLinkingUpi = false;
  final TextEditingController _upiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep;
    _scannerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _nameController.dispose();
    _idNumberController.dispose();
    _dobController.dispose();
    _upiController.dispose();
    super.dispose();
  }

  void _startScanning(String cardType) {
    setState(() {
      _scanCardType = cardType;
      _isScanning = true;
    });
    _scannerController.repeat(reverse: true);

    final apiKey = ref.read(geminiApiKeyProvider);
    if (apiKey.isEmpty) {
      // Simulate OCR finish after 2 seconds
      Timer(const Duration(milliseconds: 2200), () {
        if (!mounted) return;
        _scannerController.stop();
        setState(() {
          _isScanning = false;
          if (cardType == 'PAN') {
            _panScanned = true;
            _nameController.text = 'Sourabh Sharma';
            _idNumberController.text = 'ABCPD1234F';
            _dobController.text = '12/04/1995';
          } else {
            _aadhaarScanned = true;
            if (_nameController.text.isEmpty) {
              _nameController.text = 'Sourabh Sharma';
            }
            _idNumberController.text = '8842 1290 8371';
            _dobController.text = '12/04/1995';
          }
        });
        
        ref.read(engagementProvider.notifier).trackEvent(
          'Simulated OCR Scan ($cardType)',
          coins: 25,
          details: 'Scanned mock $cardType card and auto-filled data parameters via OCR engine.',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🎉 $cardType scanned successfully! Details pre-filled.'),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  void _submitOcrDetails() {
    if (_nameController.text.trim().isEmpty || _idNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please scan cards or input your details.'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    // KYC completed (Lightweight transition)
    ref.read(userProfileProvider.notifier).completeKyc();
    setState(() {
      _currentStep = OnboardingStep.videoKyc;
    });
  }

  void _startVideoKyc() {
    setState(() {
      _isKycCalling = true;
    });

    final apiKey = ref.read(geminiApiKeyProvider);
    if (apiKey.isEmpty) {
      Timer(const Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() {
          _isKycCalling = false;
          _kycVerified = true;
        });
        ref.read(engagementProvider.notifier).trackEvent(
          'Completed Video KYC',
          coins: 30,
          details: 'Verified identity via agentic video KYC portal.',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('KYC Verified successfully!'),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  void _skipVideoKyc() {
    setState(() {
      _kycVerified = true;
      _currentStep = OnboardingStep.upiSetup;
    });
  }

  void _activateUpi() {
    setState(() {
      _isLinkingUpi = true;
    });

    final apiKey = ref.read(geminiApiKeyProvider);
    if (apiKey.isEmpty) {
      Timer(const Duration(milliseconds: 1800), () {
        if (!mounted) return;
        ref.read(userProfileProvider.notifier).enableUpi();
        setState(() {
          _isLinkingUpi = false;
          _currentStep = OnboardingStep.success;
        });
        ref.read(engagementProvider.notifier).trackEvent(
          'UPI Activated during Onboarding',
          coins: 40,
          details: 'Enabled unified payment interface and registered primary banking VPA',
        );
      });
    }
  }

  void _skipUpi() {
    setState(() {
      _currentStep = OnboardingStep.success;
    });
  }

  void _completeOnboarding() {
    ref.read(userProfileProvider.notifier).completeOnboarding();
    // Re-route to main screen (MainShell is loaded by main.dart when newUser is false)
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(userProfileProvider);

    ref.listen<KycStepState?>(agentKycProvider, (previous, next) {
      if (next == null) return;
      if (next.step == 'pan' && next.userConfirmed) {
        _scannerController.stop();
        setState(() {
          _isScanning = false;
          _panScanned = true;
          _nameController.text = 'Sourabh Sharma';
          _idNumberController.text = 'ABCPD1234F';
          _dobController.text = '12/04/1995';
        });
        ref.read(engagementProvider.notifier).trackEvent(
          'Simulated OCR Scan (PAN)',
          coins: 25,
          details: 'Scanned mock PAN card and auto-filled data parameters via OCR engine.',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 PAN scanned successfully! Details pre-filled.'),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (next.step == 'aadhaar' && next.userConfirmed) {
        _scannerController.stop();
        setState(() {
          _isScanning = false;
          _aadhaarScanned = true;
          if (_nameController.text.isEmpty) {
            _nameController.text = 'Sourabh Sharma';
          }
          _idNumberController.text = '8842 1290 8371';
          _dobController.text = '12/04/1995';
        });
        ref.read(engagementProvider.notifier).trackEvent(
          'Simulated OCR Scan (Aadhaar)',
          coins: 25,
          details: 'Scanned mock Aadhaar card and auto-filled data parameters via OCR engine.',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 Aadhaar scanned successfully! Details pre-filled.'),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        if (_panScanned) {
          Timer(const Duration(milliseconds: 1000), () {
            if (!mounted) return;
            _submitOcrDetails();
          });
        }
      } else if (next.step == 'video' && next.userConfirmed) {
        if (_currentStep != OnboardingStep.videoKyc) {
          setState(() {
            _currentStep = OnboardingStep.videoKyc;
          });
        }
        setState(() {
          _isKycCalling = true;
        });
        Timer(const Duration(milliseconds: 1000), () {
          if (!mounted) return;
          setState(() {
            _isKycCalling = false;
            _kycVerified = true;
          });
          ref.read(engagementProvider.notifier).trackEvent(
            'Completed Video KYC',
            coins: 30,
            details: 'Verified identity via agentic video KYC portal.',
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('KYC Verified successfully!'),
              backgroundColor: AppTheme.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Timer(const Duration(milliseconds: 1000), () {
            if (!mounted) return;
            setState(() {
              _currentStep = OnboardingStep.upiSetup;
            });
          });
        });
      }
    });

    ref.listen<UserProfile>(userProfileProvider, (previous, next) {
      if (next.upiEnabled && _currentStep == OnboardingStep.upiSetup) {
        setState(() {
          _currentStep = OnboardingStep.success;
        });
      }
    });

    // If user loading presets sets newUser to false, we can trigger re-route directly
    if (!user.newUser && _currentStep != OnboardingStep.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(userProfileProvider.notifier).completeOnboarding();
      });
    }

    return GradientScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with settings and progress indicators
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bolt_rounded, color: AppTheme.aiTeal, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'SBI YONO AI',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.sbiBlue,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Settings gear for API key + presets
                      IconButton(
                        icon: const Icon(Icons.settings_suggest_rounded, color: AppTheme.textSecondary, size: 26),
                        onPressed: () => AiDevConfigModal.show(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Progress Indicator Bar
            if (_currentStep != OnboardingStep.intentSelection && _currentStep != OnboardingStep.success)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: OnboardingStep.values.sublist(1, 4).map((step) {
                    final index = step.index;
                    final currentIndex = _currentStep.index;
                    final isActive = index <= currentIndex;
                    return Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isActive ? AppTheme.aiTeal : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$index',
                                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          if (step != OnboardingStep.upiSetup)
                            Expanded(
                              child: Container(
                                height: 3,
                                color: index < currentIndex ? AppTheme.aiTeal : Colors.grey[300],
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

            const SizedBox(height: 16),
            
            // Onboarding Wizard Card Container
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const ProactiveAIBanner(),
                    const SizedBox(height: 16),
                    _buildStepContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case OnboardingStep.intentSelection:
        return _buildIntentSelectionStep();
      case OnboardingStep.panAadhaarScan:
        return _buildPanAadhaarStep();
      case OnboardingStep.videoKyc:
        return _buildVideoKycStep();
      case OnboardingStep.upiSetup:
        return _buildUpiStep();
      case OnboardingStep.success:
        return _buildSuccessStep();
    }
  }

  // STEP 1: Intent Selection
  Widget _buildIntentSelectionStep() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Hello, I am Sooubh AI.',
          style: theme.textTheme.headlineLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 8),
        Text(
          'Your intelligent financial companion. What would you like to achieve today?',
          style: theme.textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary),
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
        const SizedBox(height: 28),
        
        // Option 1
        _buildIntentCard(
          icon: Icons.account_balance_rounded,
          title: 'Open Digital Savings Account',
          subtitle: 'Create an instant zero-balance savings account with paperless KYC',
          onTap: () {
            setState(() {
              _currentStep = OnboardingStep.panAadhaarScan;
            });
          },
        ).animate().fadeIn(delay: 350.ms).slideX(begin: 0.1, end: 0),
        
        // Option 2
        _buildIntentCard(
          icon: Icons.qr_code_scanner_rounded,
          title: 'Activate UPI Payments',
          subtitle: 'Send and receive money instantly directly to other mobile numbers',
          onTap: () {
            setState(() {
              _currentStep = OnboardingStep.upiSetup;
            });
          },
        ).animate().fadeIn(delay: 450.ms).slideX(begin: 0.1, end: 0),
        
        // Option 3
        _buildIntentCard(
          icon: Icons.savings_rounded,
          title: 'Explore Goals & Deposits',
          subtitle: 'Set up emergency savings targets or high-interest fixed deposits',
          onTap: () {
            ref.read(userProfileProvider.notifier).completeOnboarding();
            ref.read(bottomNavIndexProvider.notifier).state = 2; // Services tab
          },
        ).animate().fadeIn(delay: 550.ms).slideX(begin: 0.1, end: 0),
        
        // Option 4
        _buildIntentCard(
          icon: Icons.insights_rounded,
          title: 'Analyze Spending & Insights',
          subtitle: 'Check weekly savings overview, salary allocations, and budgets',
          onTap: () {
            ref.read(userProfileProvider.notifier).completeOnboarding();
          },
        ).animate().fadeIn(delay: 650.ms).slideX(begin: 0.1, end: 0),
      ],
    );
  }

  Widget _buildIntentCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: SooubhCard(
        hasAiBorder: true,
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.sbiBlue.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.sbiBlue, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // STEP 2: PAN & Aadhaar OCR Scan
  Widget _buildPanAadhaarStep() {
    final theme = Theme.of(context);
    
    if (_isScanning) {
      return _buildCameraScannerOverlay();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scan Documents',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppTheme.textPrimary),
        ),
        const SizedBox(height: 6),
        const Text(
          'Provide your PAN and Aadhaar card details. The AI agent will verify formats and auto-extract information.',
          style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 20),

        // Scanning grid
        Row(
          children: [
            Expanded(
              child: SooubhCard(
                onTap: () => _startScanning('PAN'),
                hasAiBorder: _panScanned,
                child: Column(
                  children: [
                    Icon(
                      _panScanned ? Icons.check_circle_rounded : Icons.camera_alt_outlined,
                      color: _panScanned ? AppTheme.success : AppTheme.sbiBlue,
                      size: 32,
                    ),
                    const SizedBox(height: 10),
                    const Text('PAN Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(
                      _panScanned ? 'OCR Completed' : 'Tap to scan',
                      style: TextStyle(fontSize: 10, color: _panScanned ? AppTheme.success : AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SooubhCard(
                onTap: () => _startScanning('Aadhaar'),
                hasAiBorder: _aadhaarScanned,
                child: Column(
                  children: [
                    Icon(
                      _aadhaarScanned ? Icons.check_circle_rounded : Icons.camera_alt_outlined,
                      color: _aadhaarScanned ? AppTheme.success : AppTheme.sbiBlue,
                      size: 32,
                    ),
                    const SizedBox(height: 10),
                    const Text('Aadhaar Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(
                      _aadhaarScanned ? 'OCR Completed' : 'Tap to scan',
                      style: TextStyle(fontSize: 10, color: _aadhaarScanned ? AppTheme.success : AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Pre-filled Info fields
        if (_panScanned || _aadhaarScanned) ...[
          Text('Extracted OCR Information', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _idNumberController,
            decoration: const InputDecoration(
              labelText: 'Document Reference Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dobController,
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Proceed to Video KYC',
                  onPressed: _submitOcrDetails,
                  isAiAction: true,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildCameraScannerOverlay() {
    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background layout
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Center(
                child: Icon(
                  _scanCardType == 'PAN' ? Icons.credit_card_rounded : Icons.portrait_rounded,
                  color: Colors.white,
                  size: 200,
                ),
              ),
            ),
          ),
          
          // Camera targeting box
          Container(
            width: 290,
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.aiTeal, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          // Animated laser line
          AnimatedBuilder(
            animation: _scannerController,
            builder: (context, child) {
              final double topVal = 100 + (_scannerController.value * 180);
              return Positioned(
                top: topVal,
                child: Container(
                  width: 284,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppTheme.aiTeal,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.aiTeal.withValues(alpha: 0.8),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          Positioned(
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Scanning $_scanCardType Card via AI OCR...',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // STEP 3: Video KYC
  Widget _buildVideoKycStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Video KYC Verification',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppTheme.textPrimary),
        ),
        const SizedBox(height: 6),
        const Text(
          'Complete Video KYC to unlock unlimited deposits. For this demo, Video KYC is optional and can be skipped or completed instantly.',
          style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 24),

        if (_isKycCalling)
          _buildKycConnectingCard()
        else if (_kycVerified)
          _buildKycSuccessCard()
        else
          _buildKycStartCard(),
        
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _skipVideoKyc,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppTheme.textSecondary),
                ),
                child: const Text('Skip / Do Later', style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
              ),
            ),
            if (_kycVerified) ...[
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  label: 'Setup UPI',
                  onPressed: () {
                    setState(() {
                      _currentStep = OnboardingStep.upiSetup;
                    });
                  },
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildKycStartCard() {
    return SooubhCard(
      child: Column(
        children: [
          const Icon(Icons.video_call_rounded, color: AppTheme.sbiBlue, size: 64),
          const SizedBox(height: 12),
          const Text(
            'Instant Video verification',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'Connects to a simulated agent matching your face profile to Aadhaar credentials.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'Start verification',
            onPressed: _startVideoKyc,
            isAiAction: true,
          ),
        ],
      ),
    );
  }

  Widget _buildKycConnectingCard() {
    return SooubhCard(
      child: Column(
        children: [
          const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.aiTeal),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Verifying Face Biometrics...',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          Text(
            'Checking extracted parameters against Aadhaar card databases',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildKycSuccessCard() {
    return SooubhCard(
      hasAiBorder: true,
      child: const Column(
        children: [
          Icon(Icons.verified_rounded, color: AppTheme.success, size: 64),
          SizedBox(height: 12),
          Text(
            'KYC verification Complete!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.success),
          ),
          SizedBox(height: 8),
          Text(
            'Your identity has been fully qualified. +30 SBI Coins credited.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  // STEP 4: UPI Setup
  Widget _buildUpiStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activate UPI Payments',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppTheme.textPrimary),
        ),
        const SizedBox(height: 6),
        const Text(
          'Link your mobile number to create your unique SBI UPI ID. You can skip this and configure it on the dashboard later.',
          style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 24),

        SooubhCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.flash_on, color: Colors.amber, size: 24),
                  SizedBox(width: 8),
                  Text('Create UPI Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _upiController,
                decoration: const InputDecoration(
                  labelText: 'Desired UPI ID',
                  hintText: 'e.g., sourabh',
                  suffixText: '@sbi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              if (_isLinkingUpi)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.sbiBlue)),
                  ),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Link Bank & Activate UPI',
                        onPressed: _activateUpi,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: _skipUpi,
                child: const Text('Set Up Later on Dashboard', style: TextStyle(color: AppTheme.textSecondary)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // STEP 5: Success & Coins Grant
  Widget _buildSuccessStep() {
    final theme = Theme.of(context);
    final profile = ref.watch(userProfileProvider);

    return Column(
      children: [
        const SizedBox(height: 30),
        const Icon(Icons.check_circle_rounded, color: AppTheme.success, size: 76)
            .animate().scale(duration: 400.ms, curve: Curves.bounceOut),
        const SizedBox(height: 20),
        
        Text(
          'Congratulations, ${profile.name}!',
          style: theme.textTheme.headlineLarge?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 8),
        
        Text(
          'Your YONO SBI Agentic AI profile is now active.',
          style: theme.textTheme.bodyMedium,
        ).animate().fadeIn(delay: 350.ms),
        const SizedBox(height: 24),

        // Achievement card
        SooubhCard(
          hasAiBorder: true,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    '+100 SBI Coins Earned',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.amber.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'You have unlocked the "YONO Explorer" badge for completing your onboarding mission.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: AppTheme.textSecondary, height: 1.4),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
        
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                label: 'Enter YONO SBI Dashboard',
                onPressed: _completeOnboarding,
                useGradient: true,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 650.ms),
      ],
    );
  }
}
