import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:progressofttask/utils/extensions/context.dart';

class TopFadeWidget extends StatefulWidget {
  final Color? color;
  final Duration? fadeDuration;
  final bool isAnimate;
  const TopFadeWidget({
    super.key,
    this.color,
    this.fadeDuration,
    this.isAnimate = true,
  });

  @override
  State<TopFadeWidget> createState() => _TopFadeWidgetState();
}

class _TopFadeWidgetState extends State<TopFadeWidget> with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: widget.fadeDuration ?? const Duration(seconds: 2),
    );
    _fadeInFadeOut = widget.isAnimate
        ? Tween<double>(begin: 0.1, end: 0.5).animate(animation)
        : Tween<double>(begin: .5, end: .5).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    _controlAnimation();
  }

  @override
  void dispose() {
    animation.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(TopFadeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Start or stop animation when isAnimate property changes
    if (oldWidget.isAnimate != widget.isAnimate) {
      _controlAnimation();
    }
  }

  void _controlAnimation() {
    if (widget.isAnimate) {
      animation.forward();
      setState(() {
        _fadeInFadeOut = Tween<double>(begin: 0.1, end: 0.5).animate(animation);
      });
    } else {
      animation.stop();
      setState(() {
        _fadeInFadeOut = Tween<double>(begin: .5, end: .5).animate(animation);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Center(
          child: FadeTransition(
            opacity: _fadeInFadeOut,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(
                      400.0,
                    ),
                    bottomLeft: Radius.circular(
                      400.0,
                    ),
                  ),
                  color: widget.color ?? context.primaryColor,
                  shape: BoxShape.rectangle,
                ),
                height: 150,
                width: context.width,
                child: const SizedBox.shrink(),
              ),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 50.0,
            sigmaY: 50.0,
          ),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
