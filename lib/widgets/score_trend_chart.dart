import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Dependency-free sparkline for the health score history.
class ScoreTrendChart extends StatelessWidget {
  const ScoreTrendChart({super.key, required this.history});

  /// Monthly values, oldest first.
  final List<int> history;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: CustomPaint(painter: _SparklinePainter(values: history)),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.values});

  final List<int> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    final min = values.reduce((a, b) => a < b ? a : b).toDouble();
    final max = values.reduce((a, b) => a > b ? a : b).toDouble();
    final range = (max - min) == 0 ? 1.0 : (max - min);
    final dx = size.width / (values.length - 1);

    Offset pointAt(int i) {
      final normalized = (values[i] - min) / range;
      return Offset(i * dx, size.height - 4 - normalized * (size.height - 8));
    }

    final line = Path()..moveTo(pointAt(0).dx, pointAt(0).dy);
    for (var i = 1; i < values.length; i++) {
      line.lineTo(pointAt(i).dx, pointAt(i).dy);
    }

    // Soft gradient fill under the line.
    final fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.lightBlue.withOpacity(0.9), AppColors.lightBlue.withOpacity(0.0)],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      line,
      Paint()
        ..color = AppColors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // End-point marker for the current month.
    final last = pointAt(values.length - 1);
    canvas.drawCircle(last, 4.5, Paint()..color = AppColors.deepBlue);
    canvas.drawCircle(last, 2, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_SparklinePainter oldDelegate) =>
      oldDelegate.values != values;
}
