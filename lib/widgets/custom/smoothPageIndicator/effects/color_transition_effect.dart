import 'package:flutter/material.dart';
import 'package:tinbanxe/widgets/custom/smoothPageIndicator/painters/color_transition_painter.dart';
import 'package:tinbanxe/widgets/custom/smoothPageIndicator/painters/indicator_painter.dart';

import 'indicator_effect.dart';

class ColorTransitionEffect extends IndicatorEffect {
  // The active dot strokeWidth
  final double activeStrokeWidth;

  const ColorTransitionEffect({
    this.activeStrokeWidth = 1.5,
    double? offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
    bool activeAfterNext = false,
    List<int> listActive = const [0],
  }) : super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
          activeAfterNext: activeAfterNext,
          listActive: listActive,
        );

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return TransitionPainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}
