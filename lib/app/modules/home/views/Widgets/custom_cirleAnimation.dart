// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomCircleAnimation extends StatefulWidget {
  final Widget child;
  const CustomCircleAnimation({super.key, required this.child});

  @override
  State<CustomCircleAnimation> createState() => _CustomCircleAnimationState();
}

class _CustomCircleAnimationState extends State<CustomCircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    controller.forward();
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: widget.child,
    );
  }
}
