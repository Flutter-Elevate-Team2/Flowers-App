import 'package:flutter/material.dart';

class RoundedRectangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundedRectangleTabIndicator({required Color color, required double weight})
    : _painter = _RoundedRectanglePainter(color, weight);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _RoundedRectanglePainter extends BoxPainter {
  final Paint _paint;
  final double weight;

  _RoundedRectanglePainter(Color color, this.weight)
    : _paint = Paint()
        ..color = color
        ..isAntiAlias = true
        ..strokeCap = StrokeCap.round
        ..strokeWidth = weight
        ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size!;
    final rect = Rect.fromLTWH(
      offset.dx,
      offset.dy + size.height - weight,
      size.width,
      weight,
    );

    final rRect = RRect.fromRectAndCorners(
      rect,
      topLeft: const Radius.circular(8),
      topRight: const Radius.circular(8),
      bottomLeft: Radius.zero,
      bottomRight: Radius.zero,
    );

    canvas.drawRRect(rRect, _paint..style = PaintingStyle.fill);
  }
}
