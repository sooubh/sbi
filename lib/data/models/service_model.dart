class ServiceModel {
  final String id;
  final String name;
  final String category;
  final bool isNew;
  final bool isActivated;
  final String? badge;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    this.isNew = false,
    this.isActivated = false,
    this.badge,
  });

  ServiceModel copyWith({
    String? id,
    String? name,
    String? category,
    bool? isNew,
    bool? isActivated,
    String? badge,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isNew: isNew ?? this.isNew,
      isActivated: isActivated ?? this.isActivated,
      badge: badge ?? this.badge,
    );
  }
}
