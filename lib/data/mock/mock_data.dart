import '../models/user_profile.dart';
import '../models/financial_goal.dart';
import '../models/recommendation.dart';
import '../models/weekly_story.dart';
import '../models/service_model.dart';
import '../models/transaction_model.dart';

class MockData {
  static const UserProfile initialUser = UserProfile(
    userId: 'u001',
    name: 'Sourabh',
    maskedAccount: '•••• 4821',
    balance: 124500.0,
    kycComplete: false,
    upiEnabled: false,
    hasGoal: true,
    goalCount: 1,
    financialHealthScore: 86,
    lastLogin: '2026-06-18',
    newUser: true,
  );

  static final List<FinancialGoal> initialGoals = [
    const FinancialGoal(
      id: 'g001',
      name: 'Emergency Fund',
      targetAmount: 50000.0,
      savedAmount: 36000.0,
      monthlyContribution: 4000.0,
      status: 'active',
    ),
  ];

  static final List<Recommendation> initialRecommendations = [
    const Recommendation(
      id: 'r_kyc',
      type: 'next_best_action',
      title: 'Complete KYC',
      subtitle: 'Complete video KYC to unlock high transfer limits.',
      actionLabel: 'Verify Now',
      priority: 1,
      completed: false,
      actionRoute: '/onboarding/kyc',
    ),
    const Recommendation(
      id: 'r_upi',
      type: 'next_best_action',
      title: 'Enable UPI',
      subtitle: 'Activate UPI to send payments directly to phone numbers.',
      actionLabel: 'Set Up UPI',
      priority: 2,
      completed: false,
      actionRoute: '/onboarding/upi',
    ),
    const Recommendation(
      id: 'r_goal',
      type: 'next_best_action',
      title: 'Create Savings Goal',
      subtitle: 'Users with visual goals save 3x faster. Set one up.',
      actionLabel: 'Create Goal',
      priority: 3,
      completed: false,
      actionRoute: '/goals/create',
    ),
    const Recommendation(
      id: 'r_fd',
      type: 'next_best_action',
      title: 'Start Fixed Deposit',
      subtitle: 'Earn up to 7.2% interest on your idle savings.',
      actionLabel: 'Open FD',
      priority: 4,
      completed: false,
      actionRoute: '/services/fd',
    ),
  ];

  static const WeeklyStory mockStory = WeeklyStory(
    weekStart: '2026-06-10',
    weekEnd: '2026-06-16',
    savedThisWeek: 1200.0,
    spendChangePercent: -8,
    goalProgressChange: 5,
    scoreChange: 3,
    summaryText: 'You saved more and spent less this week than average.',
  );

  static final List<ServiceModel> initialServices = [
    // Payments
    const ServiceModel(id: 'pay_upi', name: 'UPI Payments', category: 'Payments', isActivated: true),
    const ServiceModel(id: 'pay_bills', name: 'Bill Payment', category: 'Payments', isActivated: true),
    const ServiceModel(id: 'pay_recharge', name: 'Mobile Recharge', category: 'Payments', isActivated: true),
    
    // Accounts
    const ServiceModel(id: 'acc_fd', name: 'Fixed Deposit', category: 'Accounts', isNew: true, badge: 'Recommended'),
    const ServiceModel(id: 'acc_rd', name: 'Recurring Deposit', category: 'Accounts'),
    const ServiceModel(id: 'acc_ppf', name: 'PPF Account', category: 'Accounts'),
    
    // Investments
    const ServiceModel(id: 'inv_sip', name: 'SIP Setup', category: 'Investments', isNew: true, badge: 'Hot'),
    const ServiceModel(id: 'inv_mf', name: 'Mutual Funds', category: 'Investments'),
    const ServiceModel(id: 'inv_nps', name: 'NPS Pension', category: 'Investments'),
    
    // Loans
    const ServiceModel(id: 'loan_home', name: 'Home Loan', category: 'Loans'),
    const ServiceModel(id: 'loan_personal', name: 'Personal Loan', category: 'Loans'),
    const ServiceModel(id: 'loan_car', name: 'Car Loan', category: 'Loans'),
    
    // Insurance
    const ServiceModel(id: 'ins_life', name: 'Life Insurance', category: 'Insurance'),
    const ServiceModel(id: 'ins_health', name: 'Health Insurance', category: 'Insurance', isNew: true, badge: 'Try It'),
    const ServiceModel(id: 'ins_motor', name: 'Motor Insurance', category: 'Insurance'),
  ];

  static final List<TransactionModel> initialTransactions = [
    const TransactionModel(id: 'tx001', merchant: 'Swiggy Food delivery', category: 'Food', amount: -240.0, date: 'June 17, 2026'),
    const TransactionModel(id: 'tx002', merchant: 'SBI Monthly Salary Credit', category: 'Salary', amount: 50000.0, date: 'June 01, 2026'),
    const TransactionModel(id: 'tx003', merchant: 'Electricity Utility Bill', category: 'Bills', amount: -1250.0, date: 'June 15, 2026'),
    const TransactionModel(id: 'tx004', merchant: 'Uber Ride City ride', category: 'Travel', amount: -450.0, date: 'June 16, 2026'),
    const TransactionModel(id: 'tx005', merchant: 'Sooubh Auto-Save Nudge', category: 'Savings', amount: -50.0, date: 'June 17, 2026'),
  ];
}
