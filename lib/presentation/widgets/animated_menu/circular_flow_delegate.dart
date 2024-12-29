import 'dart:math';
import 'package:flutter/material.dart';

class CircularFlowMenuDelegate extends FlowDelegate {
  final Animation<double> animation;
  final int itemCount;
  final double radius;

  const CircularFlowMenuDelegate({
    required this.animation,
    required this.itemCount,
    required this.radius,
  }) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width / 2;
    final yStart = size.height / 2;

    for (var i = 0; i < context.childCount; i++) {
      final isLastItem = i == context.childCount - 1;
      final count = context.childCount - 1;

      // Create a 180-degree arc (π radians)
      // Distribute items evenly across the arc
      final double angle = isLastItem ? 0 : pi + (i * pi / (count - 1));

      // Center position for the main button
      final x = xStart - 30;
      final y = yStart - 30;

      if (isLastItem) {
        // Main menu button stays in center
        context.paintChild(
          i,
          transform:
              Matrix4.identity()
                ..translate(x, y, 0)
                ..rotateZ(animation.value * pi * 2),
        );
      } else {
        // Position menu items in arc
        final childX = x + (cos(angle) * radius * animation.value);
        final childY = y + (sin(angle) * radius * animation.value);

        context.paintChild(
          i,
          transform: Matrix4.identity()..translate(childX, childY, 0),
        );
      }
    }
  }

  @override
  bool shouldRepaint(CircularFlowMenuDelegate oldDelegate) {
    return animation != oldDelegate.animation ||
        itemCount != oldDelegate.itemCount ||
        radius != oldDelegate.radius;
  }
}
