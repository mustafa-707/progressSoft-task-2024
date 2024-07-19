import 'package:flutter/material.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'dart:math' as math;

class DirectionAware extends StatelessWidget {
  final Widget child;
  final bool reverse;
  const DirectionAware({
    super.key,
    required this.child,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = reverse ? context.isArabic : !context.isArabic;

    return Transform.rotate(
      angle: isRtl ? -math.pi : 0,
      child: child,
    );
  }
}

class DirectionalityAware extends StatelessWidget {
  final Widget child;
  final TextDirection? textDirection;

  const DirectionalityAware({
    super.key,
    required this.child,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    if (textDirection == null) return child;
    return Directionality(
      textDirection: textDirection!,
      child: child,
    );
  }
}
