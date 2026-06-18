class UserProfile {
  final String userId;
  final String name;
  final String maskedAccount;
  final double balance;
  final bool kycComplete;
  final bool upiEnabled;
  final bool hasGoal;
  final int goalCount;
  final int financialHealthScore;
  final String lastLogin;
  final bool newUser;

  const UserProfile({
    required this.userId,
    required this.name,
    required this.maskedAccount,
    required this.balance,
    required this.kycComplete,
    required this.upiEnabled,
    required this.hasGoal,
    required this.goalCount,
    required this.financialHealthScore,
    required this.lastLogin,
    required this.newUser,
  });

  UserProfile copyWith({
    String? userId,
    String? name,
    String? maskedAccount,
    double? balance,
    bool? kycComplete,
    bool? upiEnabled,
    bool? hasGoal,
    int? goalCount,
    int? financialHealthScore,
    String? lastLogin,
    bool? newUser,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      maskedAccount: maskedAccount ?? this.maskedAccount,
      balance: balance ?? this.balance,
      kycComplete: kycComplete ?? this.kycComplete,
      upiEnabled: upiEnabled ?? this.upiEnabled,
      hasGoal: hasGoal ?? this.hasGoal,
      goalCount: goalCount ?? this.goalCount,
      financialHealthScore: financialHealthScore ?? this.financialHealthScore,
      lastLogin: lastLogin ?? this.lastLogin,
      newUser: newUser ?? this.newUser,
    );
  }
}
