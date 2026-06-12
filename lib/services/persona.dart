import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_prefs.dart';

/// PRD section 12 demo user profiles.
enum DemoPersona {
  student('Student', 'Riya Sharma', 'Riya', 'RS', 'Demo profile — college student'),
  salaried('Salaried employee', 'Vikram Iyer', 'Vikram', 'VI', 'Demo profile — salaried employee'),
  youngProfessional('Young professional', 'Aarav Rao', 'Aarav', 'AR', 'Demo profile — young professional'),
  family('Family user', 'Meera Nair', 'Meera', 'MN', 'Demo profile — family user');

  const DemoPersona(this.label, this.fullName, this.firstName, this.initials, this.description);

  final String label;
  final String fullName;
  final String firstName;
  final String initials;
  final String description;
}

/// Active demo persona; selection is persisted on-device.
class PersonaNotifier extends Notifier<DemoPersona> {
  @override
  DemoPersona build() {
    final saved = ref.read(appPrefsProvider).personaName;
    return DemoPersona.values.firstWhere(
      (p) => p.name == saved,
      orElse: () => DemoPersona.youngProfessional,
    );
  }

  void select(DemoPersona persona) {
    state = persona;
    ref.read(appPrefsProvider).setPersona(persona.name);
  }
}

final personaProvider =
    NotifierProvider<PersonaNotifier, DemoPersona>(PersonaNotifier.new);
