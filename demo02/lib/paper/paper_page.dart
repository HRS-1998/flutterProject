import 'package:flutter/material.dart';
import 'package:demo02/paper/paper_app_bar.dart';
import 'package:demo02/paper/paper_painter.dart';
import 'package:demo02/paper/models/line.dart';
import 'package:demo02/paper/dialog/confirm_dialog.dart';
import 'package:demo02/paper/select/color_selector.dart';
import 'package:demo02/paper/select/stroke_width_selector.dart';

class PaperPage extends StatefulWidget {
  final String title;
  const PaperPage({super.key, required this.title});

  @override
  State<PaperPage> createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage> {
  final List<Line> _lines = [];
  final List<Line> _historyLines = [];
  int _activeColorIndex = 0;
  int _activeStrokeWidthIndex = 0;

  //支持的颜色
  final List<Color> _colors = [
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.teal,
    Colors.lime,
    Colors.amber,
    Colors.brown,
  ];
  //支持的画笔宽度
  final List<double> _strokeWidths = [1, 2, 4, 6, 8, 10];

  void _onPanStart(DragStartDetails details) {
    _lines.add(
      Line(
        points: [details.localPosition],
        color: _colors[_activeColorIndex],
        strokeWidth: _strokeWidths[_activeStrokeWidthIndex],
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    print(details);
    Offset points = details.localPosition;
    print(points);
    double distance = (_lines.last.points.last - points).distance; //计算距离
    if (distance > 5) {
      _lines.last.points.add(details.localPosition);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppbar(
        title: widget.title,
        onClear: _showClearDialog,
        onBack: _lines.isEmpty ? null : _onBack,
        onRevocation: _historyLines.isEmpty ? null : _onRevocation,
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            child: CustomPaint(
              painter: PaperPainter(lines: _lines),
              child: ConstrainedBox(constraints: const BoxConstraints.expand()),
            ),
          ),
          // Positioned(
          //   bottom: 40,
          //   width: 240,
          //   child: ColorSelector(
          //     supportColors: _colors,
          //     activeIndex: _activeColorIndex,
          //     onSelect: _onSelectColor,
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   right: 10,
          //   child: StrokeWidthSelector(
          //     supportStrokeWidths: _strokeWidths,
          //     activeIndex: _activeStrokeWidthIndex,
          //     color: Colors.black,
          //     onSelect: _onSelectStrokeWidth,
          //   ),
          // ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ColorSelector(
                    supportColors: _colors,
                    activeIndex: _activeColorIndex,
                    onSelect: _onSelectColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StrokeWidthSelector(
                        supportStrokeWidths: _strokeWidths,
                        activeIndex: _activeStrokeWidthIndex,
                        color: _colors[_activeColorIndex],
                        onSelect: _onSelectStrokeWidth,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDialog() {
    String msg = "清除画布？";
    showDialog(
      context: context,
      builder:
          (ctx) => ConfirmDialog(
            title: '清空提示',
            conformText: '确定',
            msg: msg,
            onConform: _clear,
          ),
    );
  }

  void _onBack() {
    _historyLines.add(_lines.last);
    _lines.removeLast();
    setState(() {});
  }

  void _onRevocation() {
    // if (_historyLines.isEmpty) return;
    _lines.add(_historyLines.last);
    _historyLines.removeLast();
    setState(() {});
  }

  void _clear() {
    // 清空画布，关闭弹窗
    _lines.clear();
    Navigator.of(context).pop();
    setState(() {});
  }

  void _onSelectStrokeWidth(int index) {
    setState(() {
      _activeStrokeWidthIndex = index;
    });
  }

  void _onSelectColor(int index) {
    setState(() {
      _activeColorIndex = index;
    });
  }
}
