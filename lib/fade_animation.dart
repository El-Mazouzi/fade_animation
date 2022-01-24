import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum Properties { dx, opacity }

class FadeAnimation extends StatelessWidget {
  final Widget child;

  FadeAnimation({required this.child});

  TimelineTween<Properties> createComplexTween() {
    var tween = TimelineTween<Properties>();

    tween
        .addScene(begin: const Duration(seconds: 0), duration: const Duration(milliseconds: 300))
        .animate(Properties.dx, tween: Tween<double>(begin: 30.0, end: 0.0))
        .animate(Properties.opacity, tween: Tween<double>(begin: 0.0, end: 1));

    return tween;
  }

  @override
  Widget build(BuildContext context) {
    var _tween = createComplexTween();
    return PlayAnimation<TimelineValue<Properties>>(
      delay: const Duration(milliseconds: 800),
      duration: _tween.duration,
      tween: _tween,
      child: child,
      builder: (context, child, value) => Transform.translate(
        offset: Offset(0, value.get(Properties.dx)),
        child: Opacity(
          opacity: value.get(Properties.opacity),
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
