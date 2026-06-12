import 'package:flutter/material.dart';

/// Compass brand palette — premium, high-contrast dark banking theme (PRD Section 8.1 & 8.2).
abstract final class AppColors {
  static const background = Color(0xFF0B0F19); // Very deep, rich banking dark navy
  static const surface = Color(0xFF151D30);    // Card surfaces (medium contrast)
  static const lightBlue = Color(0xFF1F2B48);   // Soft dark-blue accents (active chips)
  
  static const deepBlue = Color(0xFF295FE3);    // Vibrant primary blue accent
  static const blue = Color(0xFF5386F9);        // Glow highlight blue
  
  static const ink = Color(0xFFF3F4F6);         // High-contrast primary text (almost white)
  static const slate = Color(0xFF9CA3AF);       // Secondary muted text (slate grey)
  
  static const divider = Color(0xFF24304D);     // Subtle borders and lines
  static const success = Color(0xFF10B981);     // Emerald green success indicator
  static const successBg = Color(0xFF064E3B);   // Deep green background card
  static const warning = Color(0xFFF59E0B);     // Amber warning
  static const warningBg = Color(0xFF78350F);   // Deep amber background card
}
