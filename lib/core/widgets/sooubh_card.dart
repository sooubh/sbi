import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SooubhCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool hasAiBorder;
  final bool useGradient;
  final LinearGradient? gradient;
  final double? width;
  final double? height;

  const SooubhCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.hasAiBorder = false,
    this.useGradient = false,
    this.gradient,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: useGradient ? null : AppTheme.cardBg,
        gradient: useGradient 
            ? (gradient ?? AppTheme.primaryGradient) 
            : null,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: hasAiBorder 
            ? Border.all(color: AppTheme.aiTeal.withValues(alpha: 0.4), width: 1.5) 
            : null,
        boxShadow: useGradient ? AppTheme.mediumShadow : AppTheme.softShadow,
      ),
      child: child,
    );

    if (onTap != null) {
      return Container(
        margin: margin ?? EdgeInsets.zero,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            child: cardContent,
          ),
        ),
      );
    }

    return margin != null 
        ? Padding(padding: margin!, child: cardContent) 
        : cardContent;
  }
}
