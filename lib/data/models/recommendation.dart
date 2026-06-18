class Recommendation {
  final String id;
  final String type; // 'next_best_action' | 'discovery_nudge'
  final String title;
  final String subtitle;
  final String actionLabel;
  final int priority;
  final bool completed;
  final String actionRoute;

  const Recommendation({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.priority,
    required this.completed,
    required this.actionRoute,
  });

  Recommendation copyWith({
    String? id,
    String? type,
    String? title,
    String? subtitle,
    String? actionLabel,
    int? priority,
    bool? completed,
    String? actionRoute,
  }) {
    return Recommendation(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      actionLabel: actionLabel ?? this.actionLabel,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      actionRoute: actionRoute ?? this.actionRoute,
    );
  }
}
