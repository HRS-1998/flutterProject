import 'package:flutter/material.dart';

class StrokeWidthSelector extends StatelessWidget {
  final List<double> supportStrokeWidths;
  final int activeIndex;
  final Color color;
  final ValueChanged<int> onSelect;

  const StrokeWidthSelector({
    super.key,
    required this.supportStrokeWidths,
    required this.activeIndex,
    required this.color,
    required this.onSelect,
  }) : assert(supportStrokeWidths.length > 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(supportStrokeWidths.length, _buildByIndex),
      ),
    );
  }

  // bool select(int index) {
  //   return index == activeIndex;
  // }

  Widget _buildByIndex(int index) {
    bool select = index == activeIndex;
    return GestureDetector(
      onTap: () {
        onSelect(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: 18,
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: color,
          borderRadius: BorderRadius.circular(8),
          border: select ? Border.all(color: Colors.blue) : null,
          color: Colors.white,
        ),
        child: Container(
          width: 50,
          color: color,
          height: supportStrokeWidths[index],
        ),
      ),
    );
  }
}
