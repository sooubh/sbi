import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/repositories/state_providers.dart';
import '../../../data/models/transaction_model.dart';

class SendMoneyScreen extends ConsumerStatefulWidget {
  final String? recipient;
  final String? amount;
  final String mode; // 'send' | 'request' | 'pay' | 'scan'

  const SendMoneyScreen({
    super.key,
    this.recipient,
    this.amount,
    this.mode = 'send',
  });

  @override
  ConsumerState<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends ConsumerState<SendMoneyScreen> {
  late final TextEditingController _recipientController;
  late final TextEditingController _amountController;
  final TextEditingController _ifscController = TextEditingController();
  
  bool _isUpi = true;
  String _validationMsg = 'Enter details to validate recipient.';
  bool _isValid = false;
  bool _isProcessing = false;
  bool _isSuccess = false;
  
  // Beneficiary Assistant Nudge State
  bool _showNudge = false;
  String _suggestedNickname = '';
  final TextEditingController _nicknameController = TextEditingController();

  // New states for multiple modes
  late String _currentMode;
  String? _selectedBiller;
  bool _scanComplete = false;
  Timer? _scanTimer;

  @override
  void initState() {
    super.initState();
    _currentMode = widget.mode;
    _recipientController = TextEditingController(text: widget.recipient ?? '');
    _amountController = TextEditingController(text: widget.amount ?? '');
    _recipientController.addListener(_validateRecipient);
    _ifscController.addListener(_validateRecipient);
    
    if (widget.recipient != null && widget.recipient!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _validateRecipient();
      });
    }

    if (_currentMode == 'scan') {
      _startScanTimer();
    }
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    _recipientController.dispose();
    _amountController.dispose();
    _ifscController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _startScanTimer() {
    _scanTimer = Timer(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      _detectQR();
    });
  }

  void _detectQR() {
    _scanTimer?.cancel();
    if (_scanComplete) return;
    setState(() {
      _scanComplete = true;
    });

    ref.read(engagementProvider.notifier).trackEvent(
      'QR Code Detected',
      coins: 15,
      details: 'Mock camera scanned and detected biller Starbucks Coffee',
    );

    setState(() {
      _selectedBiller = 'Starbucks Coffee';
      _currentMode = 'pay';
    });
  }

  void _validateRecipient() {
    final recipient = _recipientController.text.trim();
    if (recipient.isEmpty) {
      setState(() {
        _validationMsg = 'Enter details to validate recipient.';
        _isValid = false;
      });
      return;
    }

    if (_isUpi) {
      if (recipient.contains('@')) {
        setState(() {
          _validationMsg = '✨ Validated UPI ID: ${recipient.split('@').first.toUpperCase()} (SBI Peer verified)';
          _isValid = true;
          _suggestedNickname = recipient.split('@').first;
        });
      } else {
        setState(() {
          _validationMsg = '⚠️ VPA must contain @ (e.g. name@sbi)';
          _isValid = false;
        });
      }
    } else {
      final ifsc = _ifscController.text.trim().toUpperCase();
      if (recipient.length >= 9 && ifsc.length == 11) {
        String bank = 'State Bank of India';
        if (ifsc.startsWith('HDFC')) bank = 'HDFC Bank';
        if (ifsc.startsWith('ICIC')) bank = 'ICICI Bank';
        
        setState(() {
          _validationMsg = '✨ Validated Account: $recipient matched at $bank ($ifsc)';
          _isValid = true;
          _suggestedNickname = 'Rent Payee';
        });
      } else {
        setState(() {
          _validationMsg = '⚠️ Enter 9+ digit Account & 11-char IFSC code';
          _isValid = false;
        });
      }
    }
  }

  void _executeTransfer() {
    final amtText = _amountController.text.trim();
    if (amtText.isEmpty || double.tryParse(amtText) == null || double.parse(amtText) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid transfer amount.'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final amount = double.parse(amtText);
    final user = ref.read(userProfileProvider);
    if (amount > user.balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insufficient balance.'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    Timer(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      
      // Deduct balance and add transaction
      final newBalance = user.balance - amount;
      ref.read(userProfileProvider.notifier).updateBalance(newBalance);

      final isPay = _currentMode == 'pay';
      final newTx = TransactionModel(
        id: 'tx_send_${DateTime.now().millisecondsSinceEpoch}',
        merchant: isPay ? (_selectedBiller ?? 'Merchant') : _recipientController.text.trim(),
        category: isPay ? 'Utility Bill' : (_isUpi ? 'UPI Transfer' : 'Bank Transfer'),
        amount: -amount,
        date: 'Today',
      );
      ref.read(transactionsProvider.notifier).addTransaction(newTx);

      ref.read(engagementProvider.notifier).trackEvent(
        isPay ? 'Paid Bill' : 'Sent Money',
        coins: 15,
        details: isPay 
            ? 'Paid ₹$amount to ${_selectedBiller ?? "Merchant"}'
            : 'Transferred ₹$amount to ${_recipientController.text.trim()}',
      );

      _nicknameController.text = _suggestedNickname;

      setState(() {
        _isProcessing = false;
        _isSuccess = true;
        _showNudge = _currentMode == 'send'; // Only show payee save nudge for custom send flow
      });
    });
  }

  void _executeRequest() {
    final amtText = _amountController.text.trim();
    if (amtText.isEmpty || double.tryParse(amtText) == null || double.parse(amtText) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid request amount.'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final amount = double.parse(amtText);
    setState(() {
      _isProcessing = true;
    });

    Timer(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      ref.read(engagementProvider.notifier).trackEvent(
        'Requested Money',
        coins: 15,
        details: 'Requested ₹$amount from ${_recipientController.text.trim()}',
      );

      setState(() {
        _isProcessing = false;
        _isSuccess = true;
      });
    });
  }

  void _saveBeneficiary() {
    final label = _nicknameController.text.trim();
    ref.read(engagementProvider.notifier).trackEvent(
      'Saved Beneficiary',
      coins: 30,
      details: 'Added recipient ${_recipientController.text.trim()} as nickname "$label" via Assistant nudge.',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 8),
            Text('Beneficiary "$label" saved! +30 SBI Coins.'),
          ],
        ),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
      ),
    );

    setState(() {
      _showNudge = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSuccess) {
      return _buildSuccessScreen();
    }

    if (_currentMode == 'scan') {
      return _buildScanScreen();
    }

    if (_currentMode == 'pay') {
      if (_selectedBiller == null) {
        return _buildBillerSelectionScreen();
      } else {
        return _buildPayBillerScreen();
      }
    }

    final theme = Theme.of(context);
    final isRequest = _currentMode == 'request';

    return GradientScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  isRequest ? 'Request Money' : 'Send Money',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tab bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isUpi = true;
                          _recipientController.clear();
                          _isValid = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _isUpi ? AppTheme.sbiBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'UPI Address',
                            style: TextStyle(
                              color: _isUpi ? Colors.white : AppTheme.textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isUpi = false;
                          _recipientController.clear();
                          _ifscController.clear();
                          _isValid = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !_isUpi ? AppTheme.sbiBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Account Transfer',
                            style: TextStyle(
                              color: !_isUpi ? Colors.white : AppTheme.textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Input fields
            SooubhCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isUpi 
                        ? (isRequest ? 'Requester UPI VPA' : 'Receiver UPI VPA') 
                        : (isRequest ? 'Sender Bank Account Number' : 'Receiver Bank Account Number'),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _recipientController,
                    decoration: InputDecoration(
                      hintText: _isUpi ? 'e.g. priya@sbi' : 'e.g. 10098328711',
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  if (!_isUpi) ...[
                    const SizedBox(height: 16),
                    const Text('Bank IFSC Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textPrimary)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _ifscController,
                      decoration: const InputDecoration(
                        hintText: 'e.g. SBIN0000123',
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Text('Enter Amount (₹)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textPrimary)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                    decoration: const InputDecoration(
                      hintText: '₹ 0.00',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Embedded micro-agent panel
            SooubhCard(
              hasAiBorder: true,
              child: Row(
                children: [
                  Icon(
                    isRequest ? Icons.arrow_downward_rounded : Icons.security_rounded, 
                    color: AppTheme.aiTeal, 
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              isRequest ? 'Request Assistant' : 'Transfer Agent',
                              style: const TextStyle(color: AppTheme.aiTeal, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(color: AppTheme.aiTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                              child: const Text('AI', style: TextStyle(color: AppTheme.aiTeal, fontSize: 8, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isRequest 
                              ? 'I will track request fulfillment. Provide UPI address.' 
                              : _validationMsg,
                          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 12, height: 1.4, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            if (_isProcessing)
              const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.sbiBlue)),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: isRequest ? 'Request Money Instantly' : 'Send Money Instantly',
                      onPressed: _isValid ? (isRequest ? _executeRequest : _executeTransfer) : null,
                      useGradient: true,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanScreen() {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    'Scan QR Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.aiTeal, width: 3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.qr_code_scanner_rounded,
                            color: Colors.white38,
                            size: 80,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: Container(
                          width: 210,
                          height: 2,
                          color: AppTheme.aiTeal,
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .moveY(begin: 0, end: 180, duration: 1500.ms),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Point your camera at a YONO UPI QR code',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                'Auto-detecting... (1.8s)',
                style: TextStyle(color: AppTheme.aiTeal, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Simulate Detect QR',
                onPressed: _detectQR,
                isAiAction: true,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBillerSelectionScreen() {
    final theme = Theme.of(context);
    final mockBillers = [
      {'name': 'Tata Power', 'desc': 'Electricity Bill', 'icon': Icons.electric_bolt_rounded},
      {'name': 'Airtel Fiber', 'desc': 'Broadband & Landline', 'icon': Icons.router_rounded},
      {'name': 'Starbucks Coffee', 'desc': 'Merchant Payment', 'icon': Icons.coffee_rounded},
      {'name': 'Indraprastha Gas', 'desc': 'Piped Gas Bill', 'icon': Icons.local_fire_department_rounded},
      {'name': 'SBI Credit Card', 'desc': 'Card Bill Settlement', 'icon': Icons.credit_card_rounded},
    ];

    return GradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Select Biller',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Select a utility biller or merchant to pay',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: mockBillers.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final biller = mockBillers[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.sbiBlue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(biller['icon'] as IconData, color: AppTheme.sbiBlue),
                    ),
                    title: Text(
                      biller['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                    ),
                    subtitle: Text(biller['desc'] as String),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      setState(() {
                        _selectedBiller = biller['name'] as String;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayBillerScreen() {
    final theme = Theme.of(context);
    return GradientScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () {
                    setState(() {
                      _selectedBiller = null;
                    });
                  },
                ),
                Text(
                  'Pay Bill',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SooubhCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.sbiBlue.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.business_rounded, color: AppTheme.sbiBlue),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedBiller ?? 'Selected Biller',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Verified Biller account',
                          style: TextStyle(color: AppTheme.success, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SooubhCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Enter Amount (₹)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textPrimary)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                    decoration: const InputDecoration(
                      hintText: '₹ 0.00',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            if (_isProcessing)
              const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.sbiBlue)),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Confirm & Pay Bill',
                      onPressed: _executeTransfer,
                      useGradient: true,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessScreen() {
    final theme = Theme.of(context);
    final amountText = _amountController.text;
    final isRequest = _currentMode == 'request';
    final isPay = _currentMode == 'pay';

    String title = 'Transfer Successful!';
    String subtitle = '₹ $amountText has been sent to ${_recipientController.text}';
    if (isRequest) {
      title = 'Request Sent!';
      subtitle = '₹ $amountText requested from ${_recipientController.text}';
    } else if (isPay) {
      title = 'Payment Successful!';
      subtitle = '₹ $amountText paid to $_selectedBiller';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isRequest ? Icons.arrow_downward_rounded : Icons.check_circle_rounded, 
                color: isRequest ? AppTheme.aiTeal : AppTheme.success, 
                size: 84,
              ).animate().scale(duration: 400.ms, curve: Curves.bounceOut),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: AppTheme.textPrimary),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 28),

              if (_showNudge)
                SooubhCard(
                  hasAiBorder: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.face_retouching_natural_rounded, color: AppTheme.aiTeal, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'AI Beneficiary Assistant',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppTheme.aiTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Do you want to save this payee for future transfers? I can auto-suggest a label.',
                        style: TextStyle(fontSize: 12, color: AppTheme.textPrimary, height: 1.4),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _nicknameController,
                        decoration: const InputDecoration(
                          labelText: 'Nickname Label',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _showNudge = false;
                                });
                              },
                              child: const Text('No, thanks'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PrimaryButton(
                              label: 'Save Payee (+30)',
                              onPressed: _saveBeneficiary,
                              isAiAction: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 32),
              if (!_showNudge)
                PrimaryButton(
                  label: 'Back to Dashboard',
                  onPressed: () => Navigator.of(context).pop(),
                  width: double.infinity,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
