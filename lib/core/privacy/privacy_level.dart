/// User-selectable AI personalization depth (PRD section 4).
enum PrivacyLevel {
  minimal('Minimal', 'Only generic wellness and trend signals.'),
  standard('Standard', 'Category-level insights — never raw values.'),
  personalized('Personalized', 'Deeper personalization, still no raw sensitive data.');

  const PrivacyLevel(this.label, this.description);

  final String label;
  final String description;
}
