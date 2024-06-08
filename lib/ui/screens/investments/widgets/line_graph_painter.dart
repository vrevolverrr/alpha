import 'dart:math';

import 'package:flutter/material.dart';

class LineGraphPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final List<Point<double>> points;

  LineGraphPainter(this.points,
      {this.strokeWidth = 2.5, this.color = const Color(0xffDF4141)});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      // ..color = const Color(0xffDF4141).withOpacity(0.2)
      ..shader = LinearGradient(colors: [
        color.withOpacity(0.6),
        color.withOpacity(0.1),
      ], stops: const [
        0.0,
        0.6
      ], transform: const GradientRotation(1.571))
          .createShader(Rect.fromPoints(Offset(points.first.x, points.first.y),
              Offset(points.last.x, points.last.y)))
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(points.first.x - 1.5, size.height);
    for (final point in points) {
      /// Offset the first and last points to account for the stroke width and
      /// rounded edges
      if (point == points.first) {
        path.lineTo(point.x - 1.5, point.y);
        continue;
      }

      if (point == points.last) {
        path.lineTo(point.x + 1.5, point.y);
        continue;
      }
      path.lineTo(point.x, point.y);
    }

    path.lineTo(points.last.x + 1.5, size.height);
    path.close();
    canvas.drawPath(path, fillPaint);

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = Offset(points[i].x, points[i].y);
      final p2 = Offset(points[i + 1].x, points[i + 1].y);
      canvas.drawLine(p1, p2, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant LineGraphPainter oldDelegate) {
    if (oldDelegate.points.length != points.length) return true;

    for (int i = 0; i < points.length; i++) {
      if (oldDelegate.points[i] != points[i]) return true;
    }

    return false;
  }
}
