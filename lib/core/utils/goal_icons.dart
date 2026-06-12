import 'package:flutter/material.dart';

/// Icon for a goal category — shared by all goal widgets.
IconData goalIcon(String category) => switch (category) {
      'emergency' => Icons.health_and_safety_rounded,
      'travel' => Icons.flight_takeoff_rounded,
      'vehicle' => Icons.two_wheeler_rounded,
      'education' => Icons.school_rounded,
      'family' => Icons.family_restroom_rounded,
      _ => Icons.flag_rounded,
    };
