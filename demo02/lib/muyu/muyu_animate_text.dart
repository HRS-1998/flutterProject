import 'package:demo02/muyu/models/history_option.dart';
import 'package:flutter/material.dart';

class AnimateText extends StatefulWidget {
  final HistoryItem record;
  const AnimateText({super.key, required this.record});
  @override
  State<AnimateText> createState() => _AnimateTextState();
}

// SingleTickerProviderStateMixin  提供一个 vsync 对象，用于创建 AnimationController。确保动画控制器（AnimationController）与屏幕刷新率同步，从而实现流畅的动画效果。
//在 State 被销毁时自动停止和释放所有绑定到该 Ticker 的动画资源，避免内存泄漏
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
      begin: const Offset(0, 2), //Y轴方向偏移2个单位
      end: Offset.zero, // 回到原点
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('old: ${oldWidget.record.id}, new: ${widget.record.id}');
    if (oldWidget.record.id != widget.record.id) {
      _controller.forward(from: 0);
    }
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
        child: FadeTransition(
          opacity: _opacity,
          child: Text("点赞数+${widget.record.value}"),
        ),
      ),
    );
  }
}
