import 'package:flutter/material.dart';
import 'package:demo02/muyu/models/audio_option.dart';

class AudioPanel extends StatelessWidget {
  final List<AudioOption> audioOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  @override
  const AudioPanel({
    super.key,
    required this.audioOptions,
    required this.onSelect,
    required this.activeIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 200,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            // 主轴对齐方式 两端居中对齐
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < audioOptions.length; i++) _buildByIndex(i),
            ],
          ),
        ),
      ),
    );
  }

  String get audioName => audioOptions[activeIndex].name;

  Widget _buildByIndex(int index) {
    bool isActive = activeIndex == index;
    // Border activeBorder = Border.all(color: Colors.blue, width: 2);
    Border activeBorder = Border.fromBorderSide(BorderSide(color: Colors.blue));

    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isActive ? activeBorder : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 水平居中
          children: [
            //  Padding(padding: const EdgeInsets.symmetric(vertical: 16)),
            Text(
              audioName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
