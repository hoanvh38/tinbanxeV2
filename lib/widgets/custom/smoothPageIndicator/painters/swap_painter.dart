import 'package:tinbanxe/widgets/custom/smoothPageIndicator/effects/swap_effect.dart';
import 'package:flutter/material.dart';

import 'indicator_painter.dart';

class SwapPainter extends IndicatorPainter {
  final SwapEffect effect;

  SwapPainter({
    required double offset,
    required this.effect,
    required int count,
    required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    final dotOffset = offset - offset.floor();
    final activePaint = Paint()..color = effect.activeDotColor;
    for (int i = count - 1; i >= 0; i--) {
      double posOffset = i.toDouble();
      Paint paint = dotPaint;

      if (i == current) {
        paint = activePaint;
        posOffset = offset;
      } else if (i - 1 == current) {
        posOffset = i - dotOffset;
      }

      final xPos =
          effect.spacing / 2 + (posOffset * (effect.dotWidth + effect.spacing));
      final yPos = (effect.dotHeight) / 2;
      final rRect = RRect.fromLTRBR(xPos, yPos - effect.dotHeight / 2,
          xPos + effect.dotWidth, yPos + effect.dotHeight / 2, dotRadius);

      canvas.drawRRect(rRect, paint);
    }
  }
}
