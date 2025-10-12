import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  final double width;
  final double height;
  final double startAlpha;
  final double middleAlpha;
  final double endAlpha;
  final double startStop;
  final double middleStop;
  final double endStop;

  const GradientCircle({
    super.key,
    required this.width,
    required this.height,
    this.startAlpha = 0.3,
    this.middleAlpha = 0.1,
    this.endAlpha = 0.0,
    this.startStop = 0.0,
    this.middleStop = 0.5,
    this.endStop = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withValues(alpha: startAlpha),
            Colors.white.withValues(alpha: middleAlpha),
            Colors.transparent,
          ],
          stops: [startStop, middleStop, endStop],
        ),
      ),
    );
  }
}
