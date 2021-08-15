import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';

class CustomShape extends CustomPainter {
  final Color bgColor;

  CustomShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor.withOpacity(1);

    var path = Path();
    // path.lineTo(-10, 5);
    // path.lineTo(-5, 30);
    // path.lineTo(10, -5);
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomShape2 extends CustomPainter {
  final Color bgColor;

  CustomShape2(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor.withOpacity(1);

    var path = Path();
    // path.lineTo(-10, 5);
    // path.lineTo(-5, 30);
    // path.lineTo(10, -5);
    path.moveTo(0, LayoutSettings.moneyPoolSliverAppBarExpandedHeight - 100);
    path.cubicTo(
        size.width / 3,
        LayoutSettings.moneyPoolSliverAppBarExpandedHeight,
        size.width / 3 * 2,
        LayoutSettings.moneyPoolSliverAppBarExpandedHeight,
        size.width,
        LayoutSettings.moneyPoolSliverAppBarExpandedHeight - 100);
    // path.quadraticBezierTo(
    //     size.width / 2,
    //     LayoutSettings.sliverAppBarLargeExpandedHeight,
    //     size.width,
    //     LayoutSettings.sliverAppBarLargeExpandedHeight - 80);

    // path.quadraticBezierTo(0, LayoutSettings.sliverAppBarLargeExpandedHeight,
    //     size.width / 2, LayoutSettings.sliverAppBarLargeExpandedHeight);
    // path.quadraticBezierTo(
    //     size.width,
    //     LayoutSettings.sliverAppBarLargeExpandedHeight,
    //     size.width,
    //     LayoutSettings.sliverAppBarLargeExpandedHeight - 120);
//    path.lineTo(size.width, LayoutSettings.sliverAppBarLargeExpandedHeight);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    // path.lineTo(0, 10);
    // path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
