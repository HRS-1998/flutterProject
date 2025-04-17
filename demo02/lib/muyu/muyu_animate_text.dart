import 'package:flutter/material.dart';

class AnimateText extends StatefulWidget {
  final String text;
  const AnimateText({super.key, required this.text});
  @override
  State<AnimateText> createState() => _AnimateTextState();
}

class _AnimateTextState extends State<AnimateText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  late Animation<Offset> _position;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity = Tween(begin: 1.0, end: 0.0).animate(_controller);
    _scale = Tween(begin: 1.0, end: 0.9).animate(_controller);
    _position = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: SlideTransition(
        position: _position,
        child: FadeTransition(opacity: _opacity, child: Text(widget.text)),
      ),
    );
  }
}
