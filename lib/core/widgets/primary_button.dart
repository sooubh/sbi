import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isAiAction;
  final bool useGradient;
  final IconData? icon;
  final bool isLoading;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isAiAction = false,
    this.useGradient = false,
    this.icon,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Style configurations
    Color btnColor = isAiAction ? AppTheme.aiTeal : AppTheme.sbiBlue;
    Color txtColor = Colors.white;

    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(txtColor),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, size: 18, color: txtColor),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: txtColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    Decoration? decoration;
    if (onPressed != null) {
      if (useGradient) {
        decoration = BoxDecoration(
          gradient: isAiAction ? AppTheme.aiGradient : AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
          boxShadow: AppTheme.softShadow,
        );
      } else {
        decoration = BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
          boxShadow: AppTheme.softShadow,
        );
      }
    } else {
      decoration = BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
      );
    }

    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: decoration,
        child: Center(child: buttonContent),
      ),
    );
  }
}
