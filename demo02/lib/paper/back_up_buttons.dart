import 'package:flutter/material.dart';

class BackUpButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const BackUpButtons({
    super.key,
    required this.onBack,
    required this.onRevocation,
  });

  @override
  Widget build(BuildContext context) {
    // const BoxConstraints cts = BoxConstraints(maxHeight: 24, maxWidth: 24);
    Color backColor = onBack == null ? Colors.grey : Colors.black;
    Color revocationColor = onRevocation == null ? Colors.grey : Colors.black;

    return Center(
      child: Wrap(
        alignment: WrapAlignment.end,
        spacing: -10,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Transform.scale(
              scaleX: -1,
              child: IconButton(
                // splashRadius: 12,
                // constraints: cts,
                onPressed: onBack,
                icon: Icon(
                  Icons.next_plan_outlined,
                  color: backColor,
                  size: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              // splashRadius: 12,
              // constraints: cts,
              onPressed: onRevocation,
              icon: Icon(
                Icons.next_plan_outlined,
                color: revocationColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
