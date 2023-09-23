import 'package:flutter/material.dart';

class LineProgressIndicator extends StatefulWidget {
  final Color color;
  final Color backgroundColor;
  final double percent;
  final bool showPercent;
  final BorderRadiusGeometry borderRadius;
  final double width;
  final double height;

  const LineProgressIndicator({
    Key? key,
    required this.color,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.percent,
    this.showPercent = true,
    required this.borderRadius,
  }) : super(key: key);

  @override
  State<LineProgressIndicator> createState() => _LineProgressIndicatorState();
}

class _LineProgressIndicatorState extends State<LineProgressIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0.0, end: widget.percent).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: LinearProgressIndicator(
              color: widget.color,
              minHeight: 3.5,
              backgroundColor: widget.backgroundColor,
              value: widget.showPercent ? animation.value : 0.0,
            ),
          ),
        );
      },
    );
  }
}
