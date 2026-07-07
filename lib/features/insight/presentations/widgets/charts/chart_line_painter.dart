import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';

class ChartLinePainter extends CustomPainter {
  ChartLinePainter(this.values);

  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(.55)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    final max = values.reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);

      final y = size.height - (values[i] / max) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    final dotPaint = Paint()..color = AppColors.primary;

    for (int i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);

      final y = size.height - (values[i] / max) * size.height;

      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
