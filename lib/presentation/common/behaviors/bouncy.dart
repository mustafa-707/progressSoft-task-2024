import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BouncyButtonBehavior extends HookWidget {
  final Widget child;
  final VoidCallback? onTap;

  const BouncyButtonBehavior({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.9,
      upperBound: 1.0,
      initialValue: 1.0,
    );

    return Listener(
      onPointerDown: (PointerDownEvent event) {
        controller.reverse();
      },
      onPointerUp: (PointerUpEvent event) {
        controller.forward();
        onTap?.call();
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform.scale(
          scale: controller.value,
          child: child,
        ),
        child: child,
      ),
    );
  }
}
