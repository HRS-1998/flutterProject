import 'package:flutter/material.dart';

class ResultNotice extends StatefulWidget {
  final String result;
  final Color color;
  const ResultNotice({super.key, required this.result, required this.color});
  @override
  State<ResultNotice> createState() => _ResultNoticeState();
}

//继承：_ResultNoticeState 继承自 State<ResultNotice>，
//并混入了 SingleTickerProviderStateMixin，用于提供动画控制器所需的 vsync。
class _ResultNoticeState extends State<ResultNotice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.forward(); // 启动动画
  }

  // 监听动画状态
  @override
  void didUpdateWidget(covariant ResultNotice oldWidget) {
    _controller.forward(from: 1);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: widget.color,
        child: AnimatedBuilder(
          animation: _controller,
          builder:
              (_, child) => Text(
                widget.result,
                style: TextStyle(
                  fontSize: 54 * _controller.value,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}
