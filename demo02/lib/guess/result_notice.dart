import 'package:flutter/material.dart';

class ResultNotice extends StatelessWidget {
  final Color color;
  final String result;

  const ResultNotice({super.key, required this.color, required this.result});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(
          result,
          style: TextStyle(
            fontSize: 54,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
