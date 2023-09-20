import 'package:flutter/material.dart';

class AnimatedResize extends StatefulWidget {
  final Widget child;
  const AnimatedResize({Key? key, required this.child}) : super(key: key);

  @override
  State<AnimatedResize> createState() => _AnimatedResizeState();
}

class _AnimatedResizeState extends State<AnimatedResize>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _sizeAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.elasticOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeAnimation,
      child: widget.child,
      builder: (context, child) =>
          Transform.scale(scale: _sizeAnimation.value, child: child),
    );
  }
}
