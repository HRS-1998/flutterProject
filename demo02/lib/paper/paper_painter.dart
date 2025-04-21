import 'dart:ui';

import 'package:flutter/material.dart';
import "package:demo02/paper/models/line.dart";

class PaperPainter extends CustomPainter {
  PaperPainter({required this.lines}) {
    _paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;
  final List<Line> lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  // 画线
  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }
  // 点
  // @override
  // void paint(Canvas canvas, Size size) {
  //   List<Offset> points = [
  //     Offset(100, 100),
  //     Offset(100, 150),
  //     Offset(200, 150),
  //     Offset(200, 100),
  //   ];
  //   Paint paint = Paint();
  //   paint.strokeWidth = 10;
  //   paint.color = Colors.red;
  //   paint.strokeCap = StrokeCap.round;
  //   canvas.drawPoints(PointMode.points, points, paint);
  // }

  // 圆形
  //   override
  //   void paint(Canvas canvas, Size size) {
  //   Paint paint = Paint();
  //   canvas.drawCircle(Offset(100, 100), 50, paint);
  //   paint.style = PaintingStyle.stroke;
  //   canvas.drawCircle(Offset(250, 100), 50, paint);
  // }

  // 矩形
  // @override
  // void paint(Canvas canvas, Size size) {
  // Paint paint = Paint();
  // paint.style = PaintingStyle.stroke;
  // paint.strokeWidth = 2;
  // // 绘制矩形
  // Rect rect = Rect.fromCenter(center: Offset(100, 100), width: 100, height: 80);
  // canvas.drawRect(rect, paint);
  // // 绘制圆角矩形
  // paint.style = PaintingStyle.fill;
  // RRect rrect = RRect.fromRectXY(rect.translate(150, 0), 8, 8);
  // canvas.drawRRect(rrect, paint);
  //}

  //椭圆||圆弧
  // @override
  // void paint(Canvas canvas, Size size) {
  // Paint paint = Paint();
  // paint.strokeWidth = 2;
  //绘制椭圆
  // Rect overRect = Rect.fromCenter(center: Offset(100, 100), width: 100, height: 80);
  // canvas.drawOval(overRect, paint);
  //绘制圆弧
  // canvas.drawArc(overRect.translate(150, 0), 0, pi*1.3,true,paint);
  //}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
